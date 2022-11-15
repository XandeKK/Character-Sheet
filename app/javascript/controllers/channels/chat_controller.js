import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable"
const consumer = createConsumer();

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

    this.actions = {
      "message": this.addMessage.bind(this),
      "private_message": this.addPrivateMessage.bind(this),
      "message_tv": this.addMessageTv.bind(this),
      "put_me_on_chat": this.putCharacterOnChat.bind(this),
      "character_exit": this.removeCharacterOnChat.bind(this),
      "want_characters": this.sendCharacter.bind(this)
    }
  }

  startServer() {
    if (this.channel) return;
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

  startServerAdventure() {
    if (this.channel) return;
    this.channel = consumer.subscriptions.create(
      {channel: "ChatChannel", server_name: this.serverNameTarget.textContent},
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

    this.channel.perform("character_exit", {id: this.id});

    this.channel.unsubscribe();
    this.channel = null;
  }

  _cableConnected() {
    this.sendCharacterToOtherPlayers();
    this.channel.perform("want_characters", {id: this.id });
  }

  _cableDisconnected() {
  }

  _cableReceived(data) {
    this.actions[data["action"]](data);
  }

  _cableRejected() {;
    this.channel = null;
  }

  sendCharacterToOtherPlayers() {
    let dataToSend = Object.assign({}, this.character);

    this.channel.perform("put_me_on_chat", dataToSend);
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
    dataToSend.message = message;

    let player = message.match(/^@[0-9a-zA-Z_\ \-]*:/g);

    if (player) {
      player = player[0].replace(/@/, "");
      dataToSend.to = player.replace(/:/, "");
      this.sendPrivateMessage(dataToSend);
    } else {
      this.sendMessageToAll(dataToSend);
    }

    this.messageBodyTarget.value = "";
    this.messageBodyTarget.rows = 1;
  }

  sendMessageToAll(dataToSend) {
    this.channel.perform("message", dataToSend);
  }

  sendPrivateMessage(dataToSend) {
    dataToSend.message = dataToSend.message.replace(/^@[0-9a-zA-Z_\ \-]*: ?/g, "");
    this.channel.perform("private_message", dataToSend);
  }

  addMessageTv(data) {
    if (!this.toggleTv) return;

    let body = `<div class="flex items-center flex-row">
        <div class="flex items-center justify-center h-10 w-10 rounded-full bg-indigo-600 flex-shrink-0">
          <img src="${data.image}" class="rounded-full">
        </div>
        <div class="relative ml-3 text-sm bg-indigo-100 py-2 px-4 shadow rounded-xl">
          <div>
            <span class="font-bold">${data.name} roll:</span>
            <p class="ml-2 whitespace-pre-line">${data.rolls}</p>
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

  addMessage(data, isPrivate=false) {
    let isPlayer = this.isPlayer(data.id);
    let body = `<div class="flex items-center ${ isPlayer ? "justify-start flex-row-reverse": "flex-row" }">
        <div class="flex items-center justify-center h-10 w-10 rounded-full bg-indigo-600 flex-shrink-0">
          <img src="${data.image}" class="rounded-full">
        </div>
        <div class="relative ${ isPlayer ? "mr-3" : "ml-3" } text-sm bg-indigo-100 py-2 px-4 shadow rounded-xl">
          <div>
            <span class="font-bold">${data.name} ${isPrivate ? `told ${data.to}` : "told everyone"}:</span>
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

  addPrivateMessage(data) {
    if (data.to == this.name || data.id == this.id) {
      this.addMessage(data, true);
    }
  }

  addPlayerInBodyMessage(event) {
    let name = event.target.dataset["channels-ChatNameParam"];
    if (name == undefined) return;

    this.messageBodyTarget.value = `@${name}: `;
    this.messageBodyTarget.click();
    this.messageBodyTarget.focus();
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

    let body = `<p class="flex items-center py-2 px-4 hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white cursor-pointer" data-channels--chat-name-param="${data.name}">
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
