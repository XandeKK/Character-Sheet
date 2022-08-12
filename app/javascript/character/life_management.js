class LifeManagement {
  constructor() {
    this.start();
    
    this.damageBtnArray = document.querySelectorAll(".damageBtn");
    this.healBtnArray = document.querySelectorAll(".healBtn");
    this.temporaryBtnArray = document.querySelectorAll(".temporaryBtn");
    this.saveBtn = document.getElementById("saveBtn");
    this.addEvent();
  }

  addEvent() {
    for (let i = 0; i < this.damageBtnArray.length; i++) {
      this.damageBtnArray[i].addEventListener("click", this.damageHp.bind(this))
    }

    for (let i = 0; i < this.healBtnArray.length; i++) {
      this.healBtnArray[i].addEventListener("click", this.healHp.bind(this))
    }

    for (let i = 0; i < this.temporaryBtnArray.length; i++) {
      this.temporaryBtnArray[i].addEventListener("click", this.addTemporaryHp.bind(this))
    }
  }

  start() {
    if (localStorage.getItem("characterList") === '{}') return
    sendHP();
  }

  damageHp(event) {
    let id = event.target.getAttribute("character_id");
    let character_json = json[id];
    let currentHp = parseInt(character_json["currentHp"]);
    let temporary = parseInt(character_json["temporary"]);
    let input = document.getElementById("inputHp_character_" + id);
    let damage = parseInt(input.value || 1);
    damage = -Math.abs(damage);

    let result = damage + temporary;

    if (result >= 0){
      json[id]["temporary"] = result;
      input.value = '';
    }else {
      json[id]["temporary"] = 0;

      if ((currentHp + result) <= 0) {
        json[id]["currentHp"] = 0;
      } else {
        json[id]["currentHp"] = currentHp + result;
      }
      input.value = '';
    }
    this.updateDisplayHp(id);
  }

  healHp(event) {
    let id = event.target.getAttribute("character_id");
    let character_json = json[id];
    let currentHp = parseInt(character_json["currentHp"]);
    let maxHp = parseInt(character_json["maxHp"]);
    let input = document.getElementById("inputHp_character_" + id);
    let heal = parseInt(input.value || 1);
    heal = Math.abs(heal);

    if ((currentHp + heal) >= maxHp) {
      json[id]["currentHp"] = maxHp;
    } else {
      json[id]["currentHp"] = currentHp + heal;
    }
    this.updateDisplayHp(id);
    input.value = '';
  }

  addTemporaryHp(event) {
    let id = event.target.getAttribute("character_id");
    let character_json = json[id];
    let temporary = parseInt(character_json["temporary"]);
    let input = document.getElementById("inputTemporary_character_" + id);
    let hp = parseInt(input.value || 1);
    hp = Math.abs(hp);
    
    json[id]["temporary"] = temporary + hp
    this.updateDisplayHp(id);
    input.value = '';
  }

  updateDisplayHp(id) {
    let hp = document.getElementById("hp_character_" + id);
    let temp = document.getElementById("temporary_character_" + id);

    hp.innerText = json[id]["currentHp"] + "/" + json[id]["maxHp"];
    temp.innerText = json[id]["temporary"];

    if (localStorage.getItem("characterList") === null) {
      let array = {};
      localStorage.setItem("characterList", JSON.stringify(array));
    }

    let characterList = localStorage.getItem("characterList");
    characterList = JSON.parse(characterList);

    characterList[id] = json[id];

    characterList = JSON.stringify(characterList);
    localStorage.setItem("characterList", characterList);
    localStorage.setItem("updated", true);

    this.saveBtn.disabled = false;
  }
}

window.onload = function() {
  const lifeManagement = new LifeManagement();
}