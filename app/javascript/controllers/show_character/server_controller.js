import { Controller } from "@hotwired/stimulus"
import consumer from "../../channels/consumer"

export default class extends Controller {
  static targets = [
    "serverName", "password", "formServer", "terminateButton"
  ]

  connect() {
  }

  startServer() {
    this.channel = consumer.subscriptions.create(
      {channel: "CharacterChannel", server_name: this.serverNameTarget.value,
      password: this.passwordTarget.value},
      {
        connected: this._cableConnected.bind(this),
        received: this._cableReceived.bind(this),
        rejected: this._cableRejected.bind(this),
    })
  }

  terminateServer() {
    this.channel.unsubscribe();
    this.channel = null;
    this.terminateButtonTarget.classList.add("hidden");
    this.formServerTarget.classList.remove("hidden");
  }

  _cableConnected() {
    this.formServerTarget.classList.add("hidden");
    this.terminateButtonTarget.classList.remove("hidden");
  }

  _cableReceived(data) {
    console.log(data)
  }

  _cableRejected() {
    console.log("rejected")
  }
}

