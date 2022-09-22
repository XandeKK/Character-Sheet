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
  }

  _cableRejected() {
    console.log("rejected")
  }
}

