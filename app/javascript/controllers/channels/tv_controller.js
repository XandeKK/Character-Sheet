import { Controller } from "@hotwired/stimulus"
import consumer from "../../channels/consumer"

export default class extends Controller {
  static targets = [
    "serverName", "password", "formServer", "terminateButton"
  ]

  connect() {
    this.act = {
      "rollDice": this.sendDice.bind(this),
    }
  }

  startServer() {
    this.channel = consumer.subscriptions.create(
      {channel: "TvChannel", server_name: this.serverNameTarget.value,
      password: this.passwordTarget.value},
      {
        connected: this._cableConnected.bind(this),
        disconnected: this._cableDisconnected.bind(this),
        received: this._cableReceived.bind(this),
        rejected: this._cableRejected.bind(this),
    })
  }

  terminateServer() {
    // this.channel.unsubscribe();
    // this.channel = null;
    // this.terminateButtonTarget.classList.add("hidden");
    // this.formServerTarget.classList.remove("hidden");
  }

  _cableConnected() {
    this.formServerTarget.classList.add("hidden");
    // this.terminateButtonTarget.classList.remove("hidden");
  }

  _cableDisconnected() {
  }

  _cableReceived(data) {
    this.act[data["act"]](data);
  }

  _cableRejected() {
    console.log("rejected")
  }

  sendDice(data) {
    this.dispatch("sendDice", { detail: { data: data } })
  }

  sendToCharacters({ detail: { data }}) {
    this.channel.send(data)
  }
}

