import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
  ]

  connect() {
    this.characters = {};
  }

  sendToLifeSender(id) {
    this.dispatch("send", { 
      detail: 
        { id: id, character: this.characters[id] }
      }
    );
  }

  healHp(event) {
    let id = event.params.id;
    let current_hp = document.getElementById(`current_hp_character_${id}`);
    let hp_input = document.getElementById(`hp_input_character_${id}`);
    let value = parseInt(hp_input.value) || 1;

    value = Math.abs(value);

    this.setCharacterIfNotExist(id);

    this.characters[id].current_hp += value;
    this.characters[id].dirty = true;

    this.setCharacterInLocalStorage();

    if (this.characters[id].current_hp > this.characters[id].max_hp) {
      this.characters[id].current_hp = this.characters[id].max_hp;
    }

    this.sendToLifeSender(id);

    current_hp.textContent = this.characters[id].current_hp;
    hp_input.value = "";
  }

  damageHp(event) {
    let id = event.params.id;
    let current_hp = document.getElementById(`current_hp_character_${id}`);
    let temp_hp = document.getElementById(`temp_hp_character_${id}`);
    let hp_input = document.getElementById(`hp_input_character_${id}`);
    let value = parseInt(hp_input.value) || 1;

    value = Math.abs(value);

    this.setCharacterIfNotExist(id);

    value = this.damageTempHp(id, value);

    this.characters[id].current_hp -= value;
    this.characters[id].dirty = true;

    this.setCharacterInLocalStorage();

    if (this.characters[id].current_hp < 0) {
      this.characters[id].current_hp = 0;
    }
    
    this.sendToLifeSender(id);

    current_hp.textContent = this.characters[id].current_hp;
    temp_hp.textContent = this.characters[id].temp_hp;
    hp_input.value = "";
  }

  addTempHp(event) {
    let id = event.params.id;
    let temp_hp = document.getElementById(`temp_hp_character_${id}`);
    let temp_hp_input = document.getElementById(`temp_hp_input_character_${id}`);
    let value = parseInt(temp_hp_input.value) || 1;

    this.setCharacterIfNotExist(id);

    this.characters[id].temp_hp += value;
    this.characters[id].dirty = true;

    this.setCharacterInLocalStorage();
    this.sendToLifeSender(id);

    temp_hp.textContent = this.characters[id].temp_hp;
    temp_hp_input.value = "";
  }

  damageTempHp(id, value) {
    let damage = value - this.characters[id].temp_hp;
    if(damage <= 0) {
      this.characters[id].temp_hp -= value;
      return 0;
    } 

    this.characters[id].temp_hp = 0;
    return damage;
  }

  setCharacterIfNotExist(id) {
    if (this.characters[id] === undefined) {
      let max_hp = document.getElementById(`max_hp_character_${id}`);
      let current_hp = document.getElementById(`current_hp_character_${id}`);
      let temp_hp = document.getElementById(`temp_hp_character_${id}`);

      max_hp = parseInt(max_hp.textContent) || 0;
      current_hp = parseInt(current_hp.textContent) || 0;
      temp_hp = parseInt(temp_hp.textContent) || 0;

      this.characters[id] = {
        "max_hp": max_hp,
        "current_hp": current_hp,
        "temp_hp": temp_hp,
        "dirty": false
      }
    }
  }

  setCharacterInLocalStorage() {
    if (storageAvailable('localStorage')) {
      let characters = JSON.stringify(this.characters);
      localStorage.setItem("characters", characters);
    }
  }
}

