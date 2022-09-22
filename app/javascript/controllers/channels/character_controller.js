import { Controller } from "@hotwired/stimulus"
import consumer from "../../channels/consumer"

export default class extends Controller {
  static targets = [
    "serverName", "password", "formServer", "terminateButton"
  ]

  connect() {
    let id = document.querySelector("[data-id]").getAttribute("data-id");

    let name = document.getElementById(`character-name`).textContent.trim();
    let max_hp = document.getElementById(`max_hp_character_${id}`);
    let current_hp = document.getElementById(`current_hp_character_${id}`);
    let temp_hp = document.getElementById(`temp_hp_character_${id}`);

    max_hp = parseInt(max_hp.textContent) || 0;
    current_hp = parseInt(current_hp.textContent) || 0;
    temp_hp = parseInt(temp_hp.textContent) || 0;

    this.character = {
      id: id,
      name: name,
      max_hp: max_hp,
      current_hp: current_hp,
      temp_hp: temp_hp,
      image: document.getElementById("character-image").src,
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
    this.sendCharacterExit();
    this.channel.unsubscribe();
    this.channel = null;
    this.terminateButtonTarget.classList.add("hidden");
    this.formServerTarget.classList.remove("hidden");
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
    }
  }

  _cableRejected() {
    console.log("rejected")
  }

  sendPlayerToAdventure() {
    let dataToSend = Object.assign({}, this.character)
    dataToSend.act = "putMeOnAdventure";

    this.channel.send(dataToSend);
  }

  sendCharacterExit() {
    let id = this.character.id;
    let dataToSend = {act: "characterExit", id: id};

    this.channel.send(dataToSend);
  }

  sendUptadedHp() {
    let id = this.character.id;
    let dataToSend = Object.assign({}, this.character)
    dataToSend.act = "updateHp";

    delete dataToSend.name;
    delete dataToSend.image;
    delete dataToSend.max_hp;

    this.channel.send(dataToSend); 
  }

  updateHp({ detail: { id, character }}) {
    this.character.current_hp = character.current_hp;
    this.character.temp_hp = character.temp_hp;
    
    this.sendUptadedHp();
  }
}

