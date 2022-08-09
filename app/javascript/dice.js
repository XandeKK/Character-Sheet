import DiceBox from "@3d-dice/dice-box";

let Box = new DiceBox("#dice-box",{
  assetPath: '/dice-box/',
})

Box.init().then(() => {});

export function rollDice(property) {
  let dice = concatenateMixed(property["qty"], property["dice"], property["bonus"]);

  addCharacter(property["name"], property["image"]);

  Box.add(dice, {
    themeColor: property["color"],
    theme: property["theme"]
   });
}

let currentIndex = 0;
let removed = 0;
let characters = [];

Box.onRollComplete = function(dieResult) {
  for (var i = currentIndex; i < dieResult.length; i++) {
    let div = createChat(dieResult[i]);
    chat.appendChild(div);

    removeDice(dieResult[i].id, dieResult[i].qty)
  }
  currentIndex = dieResult.length;
  addPopver();

  chat.scrollTo(0, chat.scrollHeight);
}

function addCharacter(name, image) {
  characters.push({
    name: name,
    image: image
  });
}

function concatenateMixed(qty, dice, bonus) {
  if (bonus > 0) {
    bonus = "+" + bonus;
  } else if (bonus == 0) {
    bonus = "";
  }
  return qty + dice + bonus;
}

function createChat(dieResult) {
  // Create Elements
  let card = document.createElement("div");
  let cardBody = document.createElement("div");
  let imageDiv = document.createElement("div");
  let image = document.createElement("img");
  let infoDiv = document.createElement("div");
  let nameDiv = document.createElement("div");
  let rollDiv = document.createElement("div");
  let resultDiv = document.createElement("div");

  // Add class name
  card.className = "card mb-3";
  cardBody.className = "card-body d-inline-flex";
  imageDiv.className = "me-3";
  image.className = "rounded-circle";

  image.width = 80;
  image.height = 80;

  // Inner Text
  nameDiv.innerText = "Name: " + characters[dieResult.id]["name"];
  rollDiv.innerHTML = "Result: " + concatenateRolls(dieResult["rolls"], dieResult["modifier"], dieResult["value"]);
  image.src = characters[dieResult.id]["image"];

  // Append Child
  infoDiv.appendChild(nameDiv);
  infoDiv.appendChild(rollDiv);
  infoDiv.appendChild(resultDiv);

  imageDiv.appendChild(image);

  cardBody.appendChild(imageDiv);
  cardBody.appendChild(infoDiv);

  card.appendChild(cardBody);

  return card;
}

function concatenateRolls(rolls, bonus, value) {
  let rollSpan = document.createElement("span");

  rollSpan.innerText = value;

  rollSpan.dataset.bsToggle = "popover";
  rollSpan.dataset.bsTrigger = "hover focus";
  rollSpan.dataset.bsContent = "dice: ";
  rollSpan.dataset.bsPlacement = "bottom";
  rollSpan.setAttribute("tabindex", "0");

  for (var i = 0; i < rolls.length; i++) {
    let roll = (rolls[i].value).toString();
    
     if (i === (rolls.length - 1)) {
      rollSpan.dataset.bsContent += roll
    } else {
      rollSpan.dataset.bsContent += roll + " + "
    }
  }

  if (bonus > 0) {
    rollSpan.dataset.bsContent += " | bonus: " + bonus;
  } else if (bonus < 0) {
    rollSpan.dataset.bsContent += " | bonus:" + bonus;
  }

  let html = rollSpan.outerHTML

  return html;
}

function removeDice(id, qty) {
  setTimeout(function() {
    for (let i = removed; i < qty + removed; i++){
      Box.remove({groupId: id,rollId: i});
    }
    removed += qty;
  }, 8000); // 8 segundos
}

function addPopver() {
  let popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
  let popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl));
}