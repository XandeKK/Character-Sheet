import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "toggleTv", "messageBody", "chatBody"
  ]

  connect() {
    this.player = this.element.dataset["channels-ChatPlayerParam"];
    this.toggleTv = this.toggleTvTarget.checked;
  }

  inputToggleTv() {
    this.toggleTv = this.toggleTvTarget.checked;
  }

  sendMessage() {
    let message = this.messageBodyTarget.value;
    this.makeTalk({player: this.player, message: message});
    this.messageBodyTarget.value = "";
  }

  makeTalk(data) {
    let isPlayer = this.isPlayer(data.player);
    let body = `<div class="flex items-center ${ isPlayer ? "justify-start flex-row-reverse": "flex-row" }">
        <div class="flex items-center justify-center h-10 w-10 rounded-full bg-indigo-600 flex-shrink-0">
          <img src="" class="rounded-full">
        </div>
        <div class="relative ${ isPlayer ? "mr-3" : "ml-3" } text-sm bg-indigo-100 py-2 px-4 shadow rounded-xl">
          <div>
            <span class="font-bold">${data.player} say:</span>
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

  isPlayer(player) {
    return false;
    return player == this.player;
  }
}
