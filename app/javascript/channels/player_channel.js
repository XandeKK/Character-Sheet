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
    window.addEventListener("beforeunload", this.playerLeaves.bind(this));

    const hpBtn = document.getElementsByClassName("hp");
    for (var i = 0; i < hpBtn.length; i++) {
      hpBtn[i].addEventListener("click", this.updateLife.bind(this));
    }
  }

  start() {
    this.channel = this.createChannel()
    this.btn.disabled = false;
  }

  createChannel() {
    const takePlayer = this.takePlayer;
    const playerChannel = consumer.subscriptions.create({channel: "PlayerChannel", unique_name: unique_name.value}, {
      connected() {
        this.send(takePlayer());
      },

      disconnected() {
      },

      received(data) {
        if (data["act"] == "wantPlayers"){
          this.send(takePlayer());
        }
      }
    });
    return playerChannel;
  }

  updateLife() {
    let id = Object.keys(json)[0];
    const maxHp = parseInt(json[id]["maxHp"]);
    const currentHp = parseInt(json[id]["currentHp"]);
    const temporary = parseInt(json[id]["temporary"]);

    this.channel.send({
      act: "updateLife",
      character_id: id,
      maxHp: maxHp,
      currentHp: currentHp,
      temporary: temporary
    });
  }

  playerLeaves() {
    this.channel.send({
      act: "playerLeaves",
      character_id: Object.keys(json)[0]
    });
  }

  takePlayer() {
    let id = Object.keys(json)[0];
    let image = document.getElementById("image");
    if (image !== null) { image = image.src }

    return {
      act: "takePlayer",
      name: characterName.textContent,
      character_id: Object.keys(json)[0],
      maxHp: json[id]["maxHp"],
      currentHp: json[id]["currentHp"],
      temporary: json[id]["temporary"],
      image: image
    }; 
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
      act: "rollDice", 
      name: name,
      qty: quantity,
      dice: dice,
      bonus: bonus,
      character_id: character,
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