import { Controller } from "@hotwired/stimulus";
import consumer from "../../channels/consumer"

export default class extends Controller {
  static targets = [
    "serverName", "password", "toggleTv", "messageBody", "chatBody", "bodyScroll", "boxCharacters"
  ]

  connect() {
    this.characters = {};
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
    this.boxCharactersTarget.innerHTML = "";
    this.characters = {};

    let dataToSend = {act: "characterExit", id: this.id};

    this.channel.send(dataToSend);

    this.channel.unsubscribe();
    this.channel = null;
  }

  _cableConnected() {
    this.sendCharacterToOtherPlayers();
    this.channel.send({ act: "wantCharacters", id: this.id });
  }

  _cableDisconnected() {
  }

  _cableReceived(data) {
    if(data.act == "message") {
      this.makeTalk(data);
    } else if(data.act == "putMeOnChat") {
      this.putCharacterOnChat(data);
    } else if(data.act == "characterExit") {
      this.removeCharacterOnChat(data);
    } else if (data.act == "wantCharacters") {
      this.sendCharacter(data);
    }
  }

  _cableRejected() {;
  }

  sendCharacterToOtherPlayers() {
    let dataToSend = Object.assign({}, this.character);
    dataToSend.act = "putMeOnChat";

    this.channel.send(dataToSend);
  }

  sendCharacter(data) {
    if (data.id == this.id) return;

    this.sendCharacterToOtherPlayers();
  }

  inputToggleTv() {
    this.toggleTv = this.toggleTvTarget.checked;
  }

  sendMessage() {
    let message = this.messageBodyTarget.value;

    let dataToSend = Object.assign({}, this.character);
    dataToSend.act = "message";
    dataToSend.message = message;

    this.channel.send(dataToSend);

    this.messageBodyTarget.value = "";
    this.messageBodyTarget.rows = 1;
  }

  makeTalk(data) {
    let isPlayer = this.isPlayer(data.id);
    let body = `<div class="flex items-center ${ isPlayer ? "justify-start flex-row-reverse": "flex-row" }">
        <div class="flex items-center justify-center h-10 w-10 rounded-full bg-indigo-600 flex-shrink-0">
          <img src="${data.image}" class="rounded-full">
        </div>
        <div class="relative ${ isPlayer ? "mr-3" : "ml-3" } text-sm bg-indigo-100 py-2 px-4 shadow rounded-xl">
          <div>
            <span class="font-bold">${data.name} say:</span>
            <p class="ml-2 whitespace-pre-line">${data.message}</p>
          </div>
        </div>
      </div>`;

    const div = document.createElement("div");
    div.className = "col-start-1 col-end-13 p-3 rounded-lg";
    div.innerHTML = body;

    this.chatBodyTarget.append(div);
    this.bodyScrollTarget.scrollBy({
      top: this.bodyScrollTarget.scrollHeight,
      left: 0,
      behavior: "smooth"
    })
  }

  expandArea(event) {
    let count = (event.target.value.match(/\n/g) || []).length;
    count = count == 0 ? 1 : count + 1;

    event.target.rows = count;
  }

  isPlayer(id) {
    return id == this.id;
  }

  putCharacterOnChat(data) {
    if (this.characters[data.id] || data.id == this.id) return;
    this.characters[data.id] = data;

    let body = `<p class="flex items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white cursor-pointer">
        <img class="mr-2 w-6 h-6 rounded-full" src="${data.image}">
        ${data.name}
      </p>`;

    const li = document.createElement("li");
    li.id = `characterChat-${data.id}`;
    li.innerHTML = body;

    this.boxCharactersTarget.append(li);
  }

  removeCharacterOnChat(data) {
    delete this.characters[data.id];
    document.getElementById(`characterChat-${data.id}`).remove();
  }
}
