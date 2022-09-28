import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.characters = {};

    if (storageAvailable('localStorage')) {
      let characters = localStorage.getItem("characters");
      if (characters) {
        this.characters = JSON.parse(characters);
        this.updateDisplayHp();
        this.send();
      }
    }

    setInterval(this.send.bind(this), 30000) ;
  }

  updateDisplayHp() {
    for (const key in this.characters) {
      if (this.characters[key].dirty) {
        let current_hp = document.getElementById(`current_hp_character_${key}`);
        let temp_hp = document.getElementById(`temp_hp_character_${key}`);

        current_hp.textContent = this.characters[key].current_hp;
        temp_hp.textContent = this.characters[key].temp_hp;
      }
    }
  }

  send() {
    if (Object.keys( this.characters ).length == 0) return

    let xhttp = new XMLHttpRequest();
    let csrf = document.querySelector("[name='csrf-token']").content;
    let origin = window.location.origin;
    let url = origin + "/hit_point";

    let characters = {"characters": null};
    characters["characters"] = this.characters;
    characters = JSON.stringify(characters);

    xhttp.open("PUT", url, true);
    xhttp.setRequestHeader('X-CSRF-Token', csrf);
    xhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhttp.send(characters);

    xhttp.onreadystatechange = this.getResponse.bind(this);
  }

  getResponse(event) {
    if (event.target.readyState == 4 && event.target.status == 200) {
      // Isso pode ter problema
      // Por ser assíncrono
      // Ou seja, pode ser que sobrepôs a variavel
      this.characters = {};
      localStorage.removeItem("characters");
    }
  }

  setCharacter({ detail: { id, character } }) {
    this.characters[id] = character;
  }
}