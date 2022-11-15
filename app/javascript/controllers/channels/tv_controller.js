import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
const consumer = createConsumer();

export default class extends Controller {
  static targets = [
    "serverName", "password", "formServer", "terminateButton"
  ]

  connect() {
    this.actions = {
      "roll": this.sendDice.bind(this),
    }
  }

  startServer() {
    if (this.channel) return;
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
    this.actions[data["action"]](data);
  }

  _cableRejected() {
    this.channel = null;
  }

  sendDice(data) {
    this.dispatch("sendDice", { detail: { data: data } })
  }

  sendToCharacters({ detail: { data }}) {
    this.channel.perform("message_tv", data)
  }
}

