import consumer from "channels/consumer"

class PlayerChannel {
  constructor() {
    this.btn = document.getElementById("diceBtn");
    this.eventRollDice = this.rollDice.bind(this)
    this.addEvent()
  }

  addEvent() {
    this.btn.addEventListener("click", this.eventRollDice);
    document.addEventListener("turbo:submit-end", this.start.bind(this));
  }

  start() {
    this.channel = this.createChannel()
    this.btn.disabled = false;
  }

  createChannel() {
    const playerChannel = consumer.subscriptions.create({channel: "PlayerChannel", unique_name: unique_name.value}, {
      connected() {
      },

      disconnected() {
      },

      received(data) {
      }
    });
    return playerChannel;
  }

  rollDice() {
    let quantity = document.getElementById("quantity").value || 1;
    let dice = document.getElementById("dice").value || "d4";
    let bonus = document.getElementById("bonus").value || 0;
    let character = Object.keys(json)[0];
    let name = characterName.textContent;
    let color = document.getElementById("color").value || "#fff";
    let theme = document.getElementById("theme").value || "default";
    let image = document.getElementById("image").src;

    this.channel.send({ 
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
}

window.addEventListener("turbo:load", function() {
  if (document.getElementById("form") !== null) {
    const playerChannel = new PlayerChannel();
  }
})