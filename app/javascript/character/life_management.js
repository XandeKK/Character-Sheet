class LifeManagement {
  constructor() {
    this.start();

    this.npc = document.getElementById('Npc');
    this.enemy = document.getElementById('Enemy');
    
    this.damageBtnArray = document.querySelectorAll(".damageBtn");
    this.healBtnArray = document.querySelectorAll(".healBtn");
    this.temporaryBtnArray = document.querySelectorAll(".temporaryBtn");

    this.damageHp = this.damageHp.bind(this);
    this.healHp = this.healHp.bind(this);
    this.addTemporaryHp = this.addTemporaryHp.bind(this);

    this.saveBtn = document.getElementById("saveBtn");
    this.addEvent();

    this.observer = this.mutationObserver();
    this.observe();
  }

  restartEvent() {
    this.removeEvent();
    this.addEvent();
  }

  removeEvent() {
    for (let i = 0; i < this.damageBtnArray.length; i++) {
      this.damageBtnArray[i].removeEventListener("click", this.damageHp)
    }

    for (let i = 0; i < this.healBtnArray.length; i++) {
      this.healBtnArray[i].removeEventListener("click", this.healHp)
    }

    for (let i = 0; i < this.temporaryBtnArray.length; i++) {
      this.temporaryBtnArray[i].removeEventListener("click", this.addTemporaryHp)
    }

    this.damageBtnArray = document.querySelectorAll(".damageBtn");
    this.healBtnArray = document.querySelectorAll(".healBtn");
    this.temporaryBtnArray = document.querySelectorAll(".temporaryBtn");
  }

  addEvent() {
    for (let i = 0; i < this.damageBtnArray.length; i++) {
      this.damageBtnArray[i].addEventListener("click", this.damageHp)
    }

    for (let i = 0; i < this.healBtnArray.length; i++) {
      this.healBtnArray[i].addEventListener("click", this.healHp)
    }

    for (let i = 0; i < this.temporaryBtnArray.length; i++) {
      this.temporaryBtnArray[i].addEventListener("click", this.addTemporaryHp)
    }
  }

  mutationObserver() {
    const restartEvent = this.restartEvent.bind(this);

    const observer = new MutationObserver(function(mutations) {
      mutations.forEach(function(mutation) {
        if (mutation.type === 'childList') {
          restartEvent();
        }
      });
    });
    return observer;
  }

  observe() {
    if (this.npc === null) return;
    this.observer.observe(this.npc, {
      childList: true
    });

    this.observer.observe(this.enemy, {
      childList: true
    });
  }

  start() {
    if (localStorage.getItem("characters") === null) localStorage.setItem("characters", '{}');
    if (localStorage.getItem("characters") === '{}') return
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
    let updateLife = document.getElementById("update-life");
    if (updateLife !== null) updateLife.click(); // Trigger an event to send the data to websocket 

    let hp = document.getElementById("hp_character_" + id);
    let temp = document.getElementById("temporary_character_" + id);

    hp.innerText = json[id]["currentHp"] + "/" + json[id]["maxHp"];
    temp.innerText = json[id]["temporary"];

    if (localStorage.getItem("characters") === null) {
      let array = {};
      localStorage.setItem("characters", JSON.stringify(array));
    }

    let characters = localStorage.getItem("characters");
    characters = JSON.parse(characters);

    characters[id] = json[id];

    characters = JSON.stringify(characters);
    localStorage.setItem("characters", characters);
    localStorage.setItem("updated", true);

    this.saveBtn.disabled = false;
  }
}

window.onload = function() {
  const lifeManagement = new LifeManagement();
}