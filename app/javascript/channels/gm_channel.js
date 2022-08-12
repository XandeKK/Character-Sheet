import consumer from "channels/consumer"

class GmChannel {
  constructor() {
    this.serverName = document.getElementById("serverName");
    this.startBtn = document.getElementById("startServer");
    this.stopBtn = document.getElementById("stopServer");
    this.btn = document.getElementById("diceBtn");
    this.playerDiv = document.getElementById("player");

    this.eventRollDice = this.rollDice.bind(this);
    this.addEvent()

    this.players = [];
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
    this.players = [];
    this.playerDiv.innerHTML = '<h3 class="border-bottom pb-2">Player</h3>'
  }

  createChannel() {
    const pushPlayer = this.pushPlayer.bind(this);
    const removePlayer = this.removePlayer.bind(this);
    const updateLife = this.updateLife.bind(this);
    const channel = consumer.subscriptions.create({channel: "GmChannel", unique_name: serverName.textContent }, {
      connected() {
        this.send({ act: "wantPlayers" })
      },

      disconnected() {
      },

      received(data) {
        if (data["act"] == "takePlayer"){
          pushPlayer(data);
        } else if (data["act"] == "playerLeaves") {
          removePlayer(data["character_id"]);
        } else if (data["act"] == "updateLife") {
          updateLife(data);
        }
      }
    });
    return channel;
  }

  isPlayerIncluded(id) {
    return this.players.includes(id);
  }

  pushPlayer(data) {
    if (this.isPlayerIncluded(data["character_id"])) return;

    const body = [
      `<div class="row mb-3 border-bottom">`,
        `<div class="col-md-3 mb-2">`,
          `<img src="${data["image"]}" class="rounded-circle" style="width: 200px; height: auto;">`,
        `</div>`,
        `<div class="col-md-8 row mb-2">`,
          `<div class="row col-12">`,
            `<span class="col fw-semibold fs-5" type="button">${data["name"]}</span>`,
          `</div>`,
          `<div class="col-12 row">`,
            `<span class="col-auto fw-semibold text-danger">HP</span>`,
            `<span class="col-auto ms-2 hp" id="hp-${data["character_id"]}">${data["currentHp"]}/${data["maxHp"]}</span>`,
          `</div>`,
          `<div class="col-12 row">`,
            `<span class="col-auto fw-semibold text-danger">Temporary</span>`,
            `<span class="col-auto ms-2 hp" id="temporary-${data["character_id"]}">${data["temporary"]}</span>`,
          `</div>`,
        `</div>`,
      `</div>`
    ].join('');

    const div = document.createElement("div");
    div.id = data["character_id"];
    div.className = "animated fadeInDown";
    div.innerHTML = body;

    this.playerDiv.appendChild(div);
    this.players.push(data["character_id"]);
  }

  removePlayer(id) {
    if (!this.isPlayerIncluded(id)) return;
    document.getElementById(id).remove();
    this.players = this.players.filter(item => item !== id);
  }

  updateLife(data) {
    if (!this.isPlayerIncluded(data["character_id"])) return;

    let hp = document.getElementById("hp-" + data["character_id"]);
    let temporary = document.getElementById("temporary-" + data["character_id"]);

    hp.textContent = data["currentHp"] + "/" + data["maxHp"];
    temporary.textContent = data["temporary"];
  }

  rollDice() {
    let quantity = document.getElementById("quantity").value || 1;
    let dice = document.getElementById("dice").value || "d4";
    let bonus = document.getElementById("bonus").value || 0; 
    let character_id = document.getElementById("characterId").value;
    let name = document.getElementById("name").value;
    let color = document.getElementById("color").value || "#fff";
    let theme = document.getElementById("theme").value || "default";
    let image = document.getElementById("characterImage").value;
    
    this.channel.send({
      act: "sendDice",
      name: name,
      qty: quantity,
      dice: dice,
      bonus: bonus,
      character_id: character_id,
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