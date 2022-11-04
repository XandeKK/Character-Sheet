import { Controller } from "@hotwired/stimulus"
import DiceBox from "@3d-dice/dice-box";

export default class extends Controller {
  static targets = ["chat"]

  connect() {
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
    data.dice = data.dice.replaceAll(/[a-cf-zA-CF-Z]/gi, "");
    let dice = this.handlingDice(data.dice);

    this.charactersEvents.push({
      name: data.name,
      image: data.image,
      color: data.color,
      dice_normal: data.dice,
      dice: dice
    });

    let regex = /\d*d(4|6|8|100|10|12|20)/gi
    let arr_dice = dice.match(regex)

    this.box.add(arr_dice, {
      themeColor: data.color,
      theme: data.theme,
      charactersEventsIndex: this.charactersEvents.length
    });
  }

  handlingDice(dice) {
    let regex = /\d*d(4|6|8|100|10|12|20)/gi
    let arr_dice = dice.match(regex)

    arr_dice.forEach((item)=>{
      let qty = item.replace(/d(4|6|8|100|10|12|20)/gi, "");
      qty = parseInt(qty)
      let sides = item.replace(/\d*d/gi, "");
      if (qty > 1) {
        let arr = [];
        for (let i = 0; i < qty; i++) {
          arr.push(`1d${sides}`);
        }
        arr = arr.join(" + ");
        arr = `(${arr})`;

        dice = dice.replace(item, arr);
      }
    });

    return dice;
  }

  rollComplete(dieResult) {
    let previous_player = null;
    let current_player = previous_player;
    let dices = [];

    for(let i = this.currentIndex; i < dieResult.length; i++) {
      current_player = dieResult[i].charactersEventsIndex;

      if (i == this.currentIndex) {
        previous_player = current_player;
      }

      if (previous_player == current_player) {
        dices.push(dieResult[i]);
      } else {
        let item = this.createItemChat(dices);
        this.chatTarget.appendChild(item);

        this.removeDice(dices);

        dices = [dieResult[i]];
      }
      previous_player = current_player;
    }

    if (dices.length != 0) {
      let item = this.createItemChat(dices);
      this.chatTarget.appendChild(item);
      this.removeDice(dices);
    }

    this.currentIndex = dieResult.length;

    this.chatTarget.scrollBy({
      top: this.chatTarget.scrollHeight,
      left: 0,
      behavior: 'smooth'
    })
  }

  removeDice(dices) {
    for (let i=0; i<dices.length; i++) {
      let groupId = dices[i].id;
      let qty = dices[i].qty;
      setTimeout(this.timeoutRemove.bind(this, groupId, qty), 8000); // 8 seconds
    }
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

  createItemChat(dices) {
    let id = dices[0].charactersEventsIndex - 1;
    let character = this.charactersEvents[id];
    let dice_str = character.dice;

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
    popoverDiv.id = `popover-${id}`;

    // Set ClassName
    mainDiv.className = "w-full h-20 rounded-lg shadow-md p-2 flex space-x-4";
    contentDiv.className = "text-xl";
    popoverDiv.className = "inline-block absolute invisible z-10 w-64 text-md font-light text-gray-500 bg-white rounded-lg border border-gray-200 shadow-sm opacity-0 transition-opacity duration-300 dark:text-gray-400 dark:border-gray-600 dark:bg-gray-800";
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

    // Get value rolls
    let rolls = dice_str;
    dices.forEach((roll)=> {
      let str = `${roll.qty}d${roll.sides}`;
      rolls = rolls.replace(str, roll.value);
    })

    // Set text Content
    spanName.textContent = `${character.name}: `;
    spanResult.textContent = eval(rolls);

    img.src = character.image;

    pPopoverText.innerHTML = `dice: ${character.dice_normal}</br>rolls: ${rolls}`;

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

    // Clear
    this.clearCharactersEvents(id);

    this.sendToCharacters({name: character.name, rolls: eval(rolls), image: character.image});

    return mainDiv;
  }

  clearCharactersEvents(id) {
    this.charactersEvents[id] = ""
  }

  sendToCharacters(data) {
    data.act = "messageTv";
    this.dispatch("sendToCharacters", { detail: { data: data } });
  }
}
