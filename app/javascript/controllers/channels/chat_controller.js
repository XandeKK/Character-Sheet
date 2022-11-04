import { Controller } from "@hotwired/stimulus";
import consumer from "../../channels/consumer"

export default class extends Controller {
  static targets = [
    "serverName", "password", "toggleTv", "messageBody", "chatBody"
  ]

  connect() {
    this.name = this.element.dataset["channels-ChatNameParam"];
    this.image = this.element.dataset["channels-ChatImageParam"];
    this.id = this.element.dataset["channels-ChatIdParam"];
    this.toggleTv = this.toggleTvTarget.checked;

    this.character = {
      id: this.id,
      name: this.name,
      image: this.image
    }
  }

  startServer() {
    this.channel = consumer.subscriptions.create(
      {channel: "ChatChannel", server_name: this.serverNameTarget.value,
      password: this.passwordTarget.value},
      {
        connected: this._cableConnected.bind(this),
        disconnected: this._cableDisconnected.bind(this),
        received: this._cableReceived.bind(this),
        rejected: this._cableRejected.bind(this),
    })
  }

  terminateServer() {
    this.chatBodyTarget.innerHTML = "";
    this.channel.unsubscribe();
    this.channel = null;
  }

  _cableConnected() {
    this.sendPlayerToOtherPlayers();
  }

  _cableDisconnected() {
  }

  _cableReceived(data) {
    if(data.act == "message") {
      this.makeTalk(data);
    } else if(data.act == "putMeOnChat") {

    }
  }

  _cableRejected() {;
  }

  sendPlayerToOtherPlayers() {
    let dataToSend = Object.assign({}, this.character)
    dataToSend.act = "putMeOnChat";

    this.channel.send(dataToSend);
  }

  inputToggleTv() {
    this.toggleTv = this.toggleTvTarget.checked;
  }

  sendMessage() {
    let message = this.messageBodyTarget.value;

    let dataToSend = Object.assign({}, this.character)
    dataToSend.act = "message";

    this.channel.send(dataToSend);

    this.messageBodyTarget.value = "";
  }

  makeTalk(data) {
    let isPlayer = this.isPlayer(data.id);
    let body = `<div class="flex items-center ${ isPlayer ? "justify-start flex-row-reverse": "flex-row" }">
        <div class="flex items-center justify-center h-10 w-10 rounded-full bg-indigo-600 flex-shrink-0">
          <img src="${this.image}" class="rounded-full">
        </div>
        <div class="relative ${ isPlayer ? "mr-3" : "ml-3" } text-sm bg-indigo-100 py-2 px-4 shadow rounded-xl">
          <div>
            <span class="font-bold">${data.id} say:</span>
            <p class="ml-2 whitespace-pre-line">${data.message}</p>
          </div>
        </div>
      </div>`

    const div = document.createElement("div");
    div.className = "col-start-1 col-end-13 p-3 rounded-lg";
    div.innerHTML = body;

    this.chatBodyTarget.append(div);
  }

  expandArea(event) {
    let height = event.target.scrollHeight;
    event.target.style.height = `${height}px`
  }

  isPlayer(id) {
    return id == this.id;
  }
}
