import { Controller } from "@hotwired/stimulus"
import consumer from "../../channels/consumer"

export default class extends Controller {
  static targets = [
    "serverName", "password", "formServer", "terminateButton",
    "inputColor", "inputTheme", "warning"
  ]

  connect() {
    let id = document.querySelector("[data-id]").getAttribute("data-id");

    let name = document.getElementById(`character-name`).textContent.trim();
    let max_hp = document.getElementById(`max_hp_character_${id}`);
    let current_hp = document.getElementById(`current_hp_character_${id}`);
    let temp_hp = document.getElementById(`temp_hp_character_${id}`);
    let image = document.getElementById(`character-image`);

    image = image ? image.src : ""

    max_hp = parseInt(max_hp.textContent) || 0;
    current_hp = parseInt(current_hp.textContent) || 0;
    temp_hp = parseInt(temp_hp.textContent) || 0;

    this.weapon = null;
    this.channel = null;
    this.character = {
      id: id,
      name: name,
      max_hp: max_hp,
      current_hp: current_hp,
      temp_hp: temp_hp,
      image: image,
    };
  }

  startServer() {
    this.channel = consumer.subscriptions.create(
      {channel: "CharacterChannel", server_name: this.serverNameTarget.value,
      password: this.passwordTarget.value},
      {
        connected: this._cableConnected.bind(this),
        disconnected: this._cableDisconnected.bind(this),
        received: this._cableReceived.bind(this),
        rejected: this._cableRejected.bind(this),
    })
  }

  terminateServer() {
    this.channel.unsubscribe();
    this.channel = null;
  }

  _cableConnected() {
    this.formServerTarget.classList.add("hidden");
    this.terminateButtonTarget.classList.remove("hidden");

    this.sendPlayerToAdventure();
    document.addEventListener("turbo:load", this.sendCharacterExit.bind(this));
    window.addEventListener("beforeunload", this.sendCharacterExit.bind(this));
  }

  _cableDisconnected() {
  }

  _cableReceived(data) {
    if (data["act"] == "wantPlayers") {
      this.sendPlayerToAdventure();
    } else if (data["act"] == "characterExit" && data["id"] == this.character.id){
      this.terminateServer();
    }
  }

  _cableRejected() {;
    this.warningTarget.innerHTML = '<div class="text-red-500 dark:text-red-400 font-bold">Bad server name or password</div>';
  }

  sendPlayerToAdventure() {
    let dataToSend = Object.assign({}, this.character)
    dataToSend.act = "putMeOnAdventure";

    this.channel.send(dataToSend);
  }

  sendCharacterExit() {
    this.terminateButtonTarget.classList.add("hidden");
    this.formServerTarget.classList.remove("hidden");
    this.warningTarget.innerHTML = "";

    if (this.channel == null) return;

    let id = this.character.id;
    let dataToSend = {act: "characterExit", id: id};

    this.channel.send(dataToSend);
  }

  sendUptadedHp() {
    if (!this.channel) return;

    let id = this.character.id;
    let dataToSend = Object.assign({}, this.character)
    dataToSend.act = "updateHp";

    delete dataToSend.name;
    delete dataToSend.image;
    delete dataToSend.max_hp;

    this.channel.send(dataToSend); 
  }

  sendDice(dice) {
    if (!this.channel) return;

    let color = this.inputColorTarget.value;
    let theme = this.inputThemeTarget.value;
    let id = this.character.id;
    let dataToSend = Object.assign({}, this.character)

    dataToSend.act = "rollDice";
    dataToSend.color = color;
    dataToSend.theme = theme;
    dataToSend.dice = dice;

    delete dataToSend.max_hp;
    delete dataToSend.current_hp;
    delete dataToSend.temp_hp;

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

  setWeapon(event) {
    this.weapon = event.params;
  }

  updateHp({ detail: { id, character }}) {
    this.character.current_hp = character.current_hp;
    this.character.temp_hp = character.temp_hp;
    
    this.sendUptadedHp();
  }
}

