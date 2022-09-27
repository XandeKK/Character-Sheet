import { Controller } from "@hotwired/stimulus"
import DiceBox from "@3d-dice/dice-box";
import AdvancedRoller from "advanced-roller";

export default class extends Controller {
  static targets = ["chat"]

  connect() {
    this.characters = {};
    this.charactersEvents = [];
    this.currentIndex = 0;
    this.finalResultLength = 0;

    this.box = new DiceBox("#dice-box", {
      id: "dice-canvas",
      assetPath: '/dice-box/',
      scale: 6
    })

    document.getElementById("dice-canvas").className = "fixed pointer-events-none w-full h-full"

    this.box.init();

    this.box.onRollComplete = this.rollComplete.bind(this);

    this.Roller = new AdvancedRoller({
      target: "#dice-box",
      onSubmit: (notation, theme) => this.box.add(notation, theme),
      onClear: () => {
        this.box.clear();
      },
      onReroll: (rolls) => {
        // loop through parsed roll notations and send them to the Box
        rolls.forEach((roll) => this.box.add(roll, roll.groupId));
      },
      onResults: (results) => {
        let item = this.createItemChat(results);
        this.chatTarget.appendChild(item);
        this.chatTarget.scrollBy({
          top: this.chatTarget.scrollHeight,
          left: 0,
          behavior: 'smooth'
        })
      }
    });
  }

  rollDice(data) {
    this.characters[data.id] = {
      name: data.name,
      image: data.image,
      color: data.color,
      dice: data.dice
    };

    let regex = /\d*d(4|6|8|100|10|12|20)/gi

    let length = data.dice.match(regex).length

    for (var i = 0; i < length; i++) {
      this.charactersEvents.push({
        id: data.id,
        finalResultLength: this.finalResultLength,
        dice: data.dice
      });
    }

    this.finalResultLength += 1;

    this.Roller.submit(data.dice, {
      themeColor: data.color,
      theme: data.theme,
    });
  }

  rollComplete(results) {
    let previousPlayer = null
    let currentPlayer = null
    let groupResults = []

    for (var i = this.currentIndex; i < results.length; i++) {
      currentPlayer = this.charactersEvents[i];

      if (previousPlayer == null) {
        previousPlayer = currentPlayer;
      }

      if (currentPlayer.id == previousPlayer.id && currentPlayer.finalResultLength == previousPlayer.finalResultLength) {
        groupResults.push(results[i])
      } else {
        this.Roller.handleResults(groupResults, previousPlayer.finalResultLength);
        groupResults = []
        groupResults.push(results[i])
      }

      if (currentPlayer.id == previousPlayer.id && i == results.length-1) {
        this.Roller.handleResults(groupResults, currentPlayer.finalResultLength);
        groupResults = [] 
      }

      if (i == results.length-1 && groupResults.length > 0) {
        this.Roller.handleResults(groupResults, currentPlayer.finalResultLength);
      }
      
      previousPlayer = currentPlayer;
      
      this.removeDice(results[i].rolls)

    }

    this.currentIndex = results.length;
  }

  removeDice(rolls) {
    rolls.forEach((roll)=> {
      setTimeout(()=> {
        this.box.remove({groupId: roll.groupId, rollId: roll.rollId})
      }, 8000)
    })
  }

  getDices({ detail: { data }}) {
    this.rollDice(data)
  }

  createItemChat(results) {
    let playerPosition = results.playerPosition;
    let dice = this.charactersEvents[playerPosition].dice;
    let id = this.charactersEvents[playerPosition].id;
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
    popoverDiv.id = `popover-${playerPosition}`;

    // Set ClassName
    mainDiv.className = "w-full h-20 rounded-lg shadow-md p-2 flex space-x-4";
    contentDiv.className = "text-xl";
    popoverDiv.className = "inline-block absolute invisible z-10 w-64 text-sm font-light text-gray-500 bg-white rounded-lg border border-gray-200 shadow-sm opacity-0 transition-opacity duration-300 dark:text-gray-400 dark:border-gray-600 dark:bg-gray-800";
    popoverContentDiv.className = "py-2 px-3";

    img.className = "rounded-full w-16 h-16";

    pText.className = "text-black dark:text-white"
    pPopoverText.className = "text-lg"
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
    spanResult.textContent = results.value;

    img.src = character.image;

    let popoverText = `<span class="font-bold">${dice}</span></br>${this.showResults(results)}`

    pPopoverText.innerHTML = popoverText;

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

  showResults(data){
    let rolls
    if(data.rolls && !Array.isArray(data.rolls)){
      rolls = Object.values(data.rolls).map(roll => roll)
    } else {
      rolls = Object.values(this.recursiveSearch(data,'rolls')).map(group => {
        return Object.values(group)
      }).flat()
    }

    let total = 0
    if(data.hasOwnProperty('value')) {
      total = data.value
    } else { 
      total = rolls.reduce((val,roll) => val + roll.value,0)
      let modifier = data.reduce((val,roll) => val + roll.modifier,0)
      total += modifier
    }

    total = isNaN(total) ? '...' : total
    let resultString = ''

    rolls.forEach((roll,i) => {
      let val
      let sides = roll.die || roll.sides || 'fate'
      if(i !== 0) {
        resultString += ', '
      }

      // if(roll.success !== undefined && roll.success !== null){
      //   val = roll.success ?
      //    `<svg class="success"><use href="${checkIcon}#checkmark"></use></svg>` : roll.failures > 0 ?
      //     `<svg class="failure"><use href="${cancelIcon}#cancel"></use></svg>` : `<svg class="null"><use href="${minusIcon}#minus"></use></svg>`
      // } else {
        // convert to string in case value is 0 which would be evaluated as falsy
      val = roll.hasOwnProperty('value') ? roll.value.toString() : '...'
      // }
      let classes = ''

      if(roll.critical === "success" || (roll.hasOwnProperty('value') && sides == roll.value)) {
        classes += ' text-green-700'
      }
      if(roll.critical === "failure" || (roll.success === null && roll.hasOwnProperty('value') && roll.value <= 1 && sides !== 'fate')) {
        classes += ' text-red-700'
      }
      if(roll.drop) {
        classes += ' text-gray-600 line-through decoration-gray-700'
      }
      if(roll.reroll) {
        classes += ' text-gray-600 line-through decoration-gray-700'
      }
      if(roll.explode) {
        classes += ' text-green-700 after:content-["!"]'
      }
      if(sides === 'fate'){
        if(roll.value === 1){
          classes += ' text-green-700'
        }
        if(roll.value === -1){
          classes += ' text-red-700'
        }
      }

      if(classes !== ''){
        val = `<span class='font-bold ${classes.trim()}'>${val}</span>`
      }

      resultString += val
    })
    resultString += ` = <strong class="font-bold">${total}</strong>`

    return resultString
  }

  recursiveSearch(obj, searchKey, results = [], callback) {
    const r = results;
    Object.keys(obj).forEach(key => {
      const value = obj[key];
      if(key === searchKey){
        r.push(value);
        if(callback && typeof callback === 'function') {
          callback(obj)
        }
      } else if(value && typeof value === 'object'){
        this.recursiveSearch(value, searchKey, r, callback);
      }
    });
    return r;
  }
}
