import consumer from "channels/consumer"

class GmChannel {
  constructor() {
    this.serverName = document.getElementById("serverName");
    this.startBtn = document.getElementById("startServer");
    this.stopBtn = document.getElementById("stopServer");
    this.btn = document.getElementById("diceBtn");
    this.eventRollDice = this.rollDice.bind(this)
    this.addEvent()
  }

  addEvent() {
    this.startBtn.addEventListener("click", this.start.bind(this));
    this.stopBtn.addEventListener("click", this.stop.bind(this));
  }

  start() {
    this.btn.addEventListener("click", this.eventRollDice);
    this.channel = this.createChannel();
    this.stopBtn.className = "btn btn-danger";
    this.startBtn.className = "btn btn-dark d-none";
  }

  stop() {
    this.channel.unsubscribe();
    this.channel = null;

    this.stopBtn.className = "btn btn-danger d-none";
    this.startBtn.className = "btn btn-dark";

    this.btn.removeEventListener("click", this.eventRollDice);
  }

  createChannel() {
    const channel = consumer.subscriptions.create({channel: "GmChannel", unique_name: serverName.textContent }, {
      connected() {
      },

      disconnected() {
      },

      received(data) {
      }
    });
    return channel;
  }

  rollDice() {
    let quantity = document.getElementById("quantity").value || 1;
    let dice = document.getElementById("dice").value || "d4";
    let bonus = document.getElementById("bonus").value || 0; 
    let character = document.getElementById("characterId").value;
    let name = document.getElementById("name").value;
    let color = document.getElementById("color").value || "#fff";
    let theme = document.getElementById("theme").value || "default";
    let image = document.getElementById("characterImage").value;
    
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
  if (document.getElementById("serverName") !== null) {
    const gmChannel = new GmChannel();
  }
})