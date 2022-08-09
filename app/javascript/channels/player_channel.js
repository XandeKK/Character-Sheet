import consumer from "channels/consumer"

document.addEventListener("turbo:submit-end", connect)
let playerChannel;
let btn = document.getElementById("diceBtn");
btn.addEventListener("click", rollDice);

function connect(event) {  
  playerChannel = consumer.subscriptions.create({channel: "PlayerChannel", unique_name: unique_name.value}, {
    connected() {
      btn.disabled = false;
    },

    disconnected() {
    },

    received(data) {
      console.log(data);
    }
  });
}

function rollDice(event) {
  let quantity = document.getElementById("quantity").value || 1;
  let dice = document.getElementById("dice").value || "d4";
  let bonus = document.getElementById("bonus").value || 0;
  let character = Object.keys(json)[0];
  let name = characterName.textContent;
  let color = document.getElementById("color").value || "#fff";
  let theme = document.getElementById("theme").value || "default";
  let image = document.getElementById("image").src;

  playerChannel.send({ 
    name: name,
    qty: quantity,
    dice: dice,
    bonus: bonus,
    character: character,
    color: color,
    theme: theme,
    image: image
  });
}