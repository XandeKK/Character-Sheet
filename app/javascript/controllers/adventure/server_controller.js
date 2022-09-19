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
        connected() {
        },

        disconnected() {
        },

        received(data) {
          console.log(data);
        }
    })
    this.startButtonTarget.classList.add("hidden");
    this.terminateButtonTarget.classList.remove("hidden");
  }

  terminateServer() {
    this.channel.unsubscribe();
    this.channel = null;
    this.terminateButtonTarget.classList.add("hidden");
    this.startButtonTarget.classList.remove("hidden");
  }
}

