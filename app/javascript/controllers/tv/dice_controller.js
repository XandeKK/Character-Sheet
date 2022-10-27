import { Controller } from "@hotwired/stimulus"
import DiceBox from "@3d-dice/dice-box";

export default class extends Controller {
  static targets = ["chat"]

  connect() {
    this.characters = {};
    this.charactersEvents = [];
    this.currentIndex = 0;
    this.accumulatorRoll = 0;

    this.box = new DiceBox("#dice-box", {
      id: "dice-canvas",
      assetPath: '/dice-box/',
      scale: 6
    })

    document.getElementById("dice-canvas").className = "fixed pointer-events-none w-full h-full"

    this.box.init();

    this.box.onRollComplete = this.rollComplete.bind(this);
  }

  rollDice(data) {
    this.characters[data.id] = {
      name: data.name,
      image: data.image,
      color: data.color
    };

    this.charactersEvents.push(data.id);

    this.box.add(data.dice, {
      themeColor: data.color,
      theme: data.theme,
    });
  }

  rollComplete(dieResult) {
    for(let i = this.currentIndex; i < dieResult.length; i++) {
      let groupId = dieResult[i].id;
      let qty = dieResult[i].qty;
      let item = this.createItemChat(i, dieResult[i]);
      this.chatTarget.appendChild(item);

      this.removeDice(groupId, qty);

      this.chatTarget.scrollBy({
        top: this.chatTarget.scrollHeight,
        left: 0,
        behavior: 'smooth'
      })
    }
    this.currentIndex = dieResult.length;
  }

  removeDice(groupId, qty) {
    setTimeout(this.timeoutRemove.bind(this, groupId, qty), 8000); // 8 seconds
  }

  timeoutRemove(groupId, qty) {
    for (let i = this.accumulatorRoll; i < qty + this.accumulatorRoll; i++) {
      this.box.remove({groupId: groupId, rollId: i});
    }
    this.accumulatorRoll += qty;
  } 

  getDices({ detail: { data }}) {
    this.rollDice(data)
  }

  createItemChat(index, dieResult) {
    let id = this.charactersEvents[index];
    let character = this.characters[id];

    // Create Element
    let mainDiv = document.createElement("div");
    let contentDiv = document.createElement("div");
    let popoverDiv = document.createElement("div");
    let popoverContentDiv = document.createElement("div");
    let popperArrow = document.createElement("div");

    let img = document.createElement("img");

    let pText = document.createElement("p");
    let pPopoverText = document.createElement("p");
    let spanName = document.createElement("span");
    let spanResult = document.createElement("span");

    // Set id
    popoverDiv.id = `popover-${index}`;

    // Set ClassName
    mainDiv.className = "w-full h-20 rounded-lg shadow-md p-2 flex space-x-4";
    contentDiv.className = "text-xl";
    popoverDiv.className = "inline-block absolute invisible z-10 w-64 text-sm font-light text-gray-500 bg-white rounded-lg border border-gray-200 shadow-sm opacity-0 transition-opacity duration-300 dark:text-gray-400 dark:border-gray-600 dark:bg-gray-800";
    popoverContentDiv.className = "py-2 px-3";

    img.className = "rounded-full w-16 h-16";

    pText.className = "text-black dark:text-white"
    spanName.className = "font-bold";

    // Set style
    let isDark = document.documentElement.classList.contains("dark");

    if (isDark) {
      mainDiv.style.backgroundColor = `${character.color}20`
    } else {
      mainDiv.style.backgroundColor = `${character.color}50`
    }

    // Set Attribute
    popoverDiv.setAttribute("data-popover", "");
    popoverDiv.setAttribute("role", "tooltip");
    popperArrow.setAttribute("data-popper-arrow", "");

    // Set text Content
    spanName.textContent = `${character.name}: `;
    spanResult.textContent = dieResult.value;

    img.src = character.image;

    let rolls = dieResult.rolls.map(function(roll) {return roll.value});
    rolls = rolls.join(" + ");

    let popoverText = null;

    if (dieResult.modifier != 0) {
      popoverText = `dice: ${dieResult.qty}d${dieResult.sides}</br>rolls: ${rolls} | bonus: ${dieResult.modifier}`;
    } else {
      popoverText = `dice: ${dieResult.qty}d${dieResult.sides}</br>rolls: ${rolls}`;
    }

    pPopoverText.innerHTML = popoverText

    // Append element
    mainDiv.appendChild(img);

    pText.appendChild(spanName);
    pText.appendChild(spanResult);
    contentDiv.appendChild(pText);

    mainDiv.appendChild(contentDiv);

    popoverContentDiv.appendChild(pPopoverText);
    popoverDiv.appendChild(popoverContentDiv);
    popoverDiv.appendChild(popperArrow);

    mainDiv.appendChild(popoverDiv);

    // Add Event
    const popover = new Popover(popoverDiv, spanResult);

    return mainDiv;
  }
}
