import consumer from "channels/consumer"

document.addEventListener("turbo:submit-end", connect)
let playerChannel;

function connect(event) {  
  playerChannel = consumer.subscriptions.create({channel: "PlayerChannel", unique_name: unique_name.value}, {
    connected() {
    },

    disconnected() {
    },

    received(data) {
      console.log(data);
    }
  });
}

let dicesBtn = document.querySelectorAll(".dice");
for (var i = 0; i < dicesBtn.length; i++) {
  dicesBtn[i].addEventListener("click", rollDice);
}

function rollDice(event) {
  let dice = event.target.getAttribute("dice");
  playerChannel.send({ dice: dice });
}