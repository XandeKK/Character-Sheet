import { Controller } from "@hotwired/stimulus"
import consumer from "../../channels/consumer"

export default class extends Controller {
  static targets = [
    "serverName", "startButton", "terminateButton"
  ]

  connect() {
  }

  startServer() {
    this.channel = consumer.subscriptions.create(
      {channel: "AdventureChannel", server_name: this.serverNameTarget.textContent},
      {
        connected: this._cableConnected.bind(this),
        received: this._cableReceived.bind(this),
    })
  }

  terminateServer() {
    this.channel.unsubscribe();
    this.channel = null;
    this.terminateButtonTarget.classList.add("hidden");
    this.startButtonTarget.classList.remove("hidden");
  }

  _cableConnected() {
    this.startButtonTarget.classList.add("hidden");
    this.terminateButtonTarget.classList.remove("hidden");
  }

  _cableReceived(data) {
    console.log(data)
  }
}

