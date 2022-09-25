import { Controller } from "@hotwired/stimulus"
import consumer from "../../channels/consumer"

export default class extends Controller {
  static targets = [
    "serverName", "startButton", "terminateButton", "bodyPlayers",
    "inputColor", "inputTheme"
  ]

  connect() {
    this.weapon = null;
    this.characters_ids = {};
    this.act = {
      "putMeOnAdventure": this.putOnAdventure.bind(this),
      "characterExit": this.removeCharacter.bind(this),
      "updateHp": this.updateHp.bind(this),
    }
  }

  startServer() {
    this.channel = consumer.subscriptions.create(
      {channel: "AdventureChannel", server_name: this.serverNameTarget.textContent},
      {
        connected: this._cableConnected.bind(this),
        received: this._cableReceived.bind(this),
    })
  }

  _cableConnected() {
    this.startButtonTarget.classList.add("hidden");
    this.terminateButtonTarget.classList.remove("hidden");
    this.channel.send({ act: "wantPlayers" });
  }

  _cableReceived(data) {
    this.act[data["act"]](data);
  }

  terminateServer() {
    this.channel.unsubscribe();
    this.channel = null;
    this.terminateButtonTarget.classList.add("hidden");
    this.startButtonTarget.classList.remove("hidden");
  }

  putOnAdventure(data) {
    let id = data.id;
    if (this.characters_ids[id]) {
      return;
    } else {
      delete data.act;
      this.characters_ids[id] = data;

      let name = data.name;
      let image = data.image;
      let max_hp = data.max_hp;
      let current_hp = data.current_hp;
      let temp_hp = data.temp_hp;

      let body = 
      `<div class="p-3 flex justify-center md:basis-64 relative w-full h-40">
        <img class="rounded-full drop-shadow-lg w-40 h-40 bg-white" src="${image}">
      </div>
      <div class="space-y-3 p-6 md:p-0 flex-1">
        <h1 class="md:mt-6 text-3xl">
          ${name}
        </h1>
        <div class="px-6 py-3 flex flex-wrap gap-6">
          <div class="flex mb-6 gap-6">
            <div>
              <h3 class="italic text-rose-700 dark:text-rose-500">
                HP
              </h3>
              <span class="text-2xl pl-3">
                <span id="current_hp-${id}">
                  ${current_hp}
                </span>
                /
                <span id="max_hp-${id}">
                  ${max_hp}
                </span>
              </span>
            </div>
            <p class="h-max-2 w-0.5 bg-gray-500 opacity-50 rotate-12"></p>
          </div>
          <div class="flex mb-6 gap-6">
            <div>
              <h3 class="italic text-rose-700 dark:text-rose-500">
                Temp HP
              </h3>
              <span id="temp_hp-${id}" class="text-2xl pl-3">
                ${temp_hp}
              </span>
            </div>
            <p class="h-max-2 w-0.5 bg-gray-500 opacity-50 rotate-12"></p>
          </div>
        </div>
      </div>`;

      let div = document.createElement("div");

      div.id = `character-${id}`;
      div.className = `flex flex-col md:flex-row mx-6 rounded-lg border border-gray-200 shadow-md dark:border-gray-700`;
      div.innerHTML = body;

      this.bodyPlayersTarget.appendChild(div);
    }
  }

  removeCharacter(data) {
    console.log(data);
    let id = data.id;
    if (this.characters_ids[id] === undefined) {
      return;
    } else {
      document.getElementById(`character-${id}`).remove();
      delete this.characters_ids[id];
    }
  }

  sendDice(dice) {
    if (!this.channel) return;

    let color = this.inputColorTarget.value;
    let theme = this.inputThemeTarget.value;
    let id = this.characters.id;
    let dataToSend = Object.assign({}, this.characters)

    dataToSend.act = "rollDice";
    dataToSend.color = color;
    dataToSend.theme = theme;
    dataToSend.dice = dice;

    this.channel.send(dataToSend);
  }

  diceNormal(event) {
    let dice = event.params.dice;
    this.sendDice(dice);
  }

  diceDamage() {
    let bonus = this.weapon.bonus;
    let qty = this.weapon.qty;
    let dice = this.weapon.dice;

    dice = `${qty}${dice}`

    if (bonus != 0) {
      dice = `${dice}${bonus}`
    }

    this.sendDice(dice);
  }

  diceCritical() {

  }

  diceAttack(event) {
    let attack = this.weapon[event.params.attack];
    let dice = "1d20";

    if (attack != 0) {
      dice += attack;
    }
    this.sendDice(dice);
  }

  setWeaponAndCharacter(event) {
    this.characters = {
      id: event.params.id,
      name: event.params.name,
      image: event.params.image,
    };
    this.weapon = {
      attack: event.params.attack,
      secondAttack: event.params.secondAttack,
      thirdAttack: event.params.thirdAttack,
      qty: event.params.qty,
      dice: event.params.dice,
      bonus: event.params.bonus,
    };
  }

  updateHp(data) {
    let id = data.id;
    document.getElementById(`current_hp-${id}`).textContent = data.current_hp;
    document.getElementById(`temp_hp-${id}`).textContent = data.temp_hp;
  }
}