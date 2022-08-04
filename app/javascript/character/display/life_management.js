function sendHP() {
  if (localStorage.getItem("updated") === 'true') {
    let json = {'currentHp': localStorage.getItem("currentHp"), 'temporary': localStorage.getItem("temporary") }
    xhttp.open("PUT", "http://10.0.0.22:3000/character/update_life/" + character_id, true);
    xhttp.setRequestHeader('X-CSRF-Token', csrf);
    xhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhttp.send(JSON.stringify(json));
  }
}

function updateHp() {
  temporary.innerText = main_json.character.hitPoints.temporary;
  hp.innerText = main_json.character.hitPoints.currentHp + "/" + main_json.character.hitPoints.maxHp;
  localStorage.setItem("currentHp", main_json.character.hitPoints.currentHp);
  localStorage.setItem("temporary", main_json.character.hitPoints.temporary);
  localStorage.setItem("updated", true);
}

function damageHp() {
  let maxHp = parseInt(main_json.character.hitPoints.maxHp);
  let currentHp = parseInt(main_json.character.hitPoints.currentHp);
  let temporary = parseInt(main_json.character.hitPoints.temporary);
  let damage = parseInt(inputHp.value || 1);
  damage = -Math.abs(damage);

  let result = damage + temporary;

  if (result >= 0){
    main_json.character.hitPoints.temporary = result;
    updateHp();
    inputHp.value = '';

    return;
  }
  
  main_json.character.hitPoints.temporary = 0;

  if ((currentHp + result) <= 0) {
    main_json.character.hitPoints.currentHp = 0;
  } else {
    main_json.character.hitPoints.currentHp = currentHp + result;
  }
  updateHp();
  inputHp.value = '';
}

function healHp() {
  let maxHp = parseInt(main_json.character.hitPoints.maxHp);
  let currentHp = parseInt(main_json.character.hitPoints.currentHp);
  let heal = parseInt(inputHp.value || 1);
  heal = Math.abs(heal);

  if ((currentHp + heal) >= maxHp) {
    main_json.character.hitPoints.currentHp = maxHp;
  } else {
    main_json.character.hitPoints.currentHp = currentHp + heal;
  }
  updateHp();
  inputHp.value = '';
}

function addTemporaryHp() {
  let temporary = parseInt(main_json.character.hitPoints.temporary);
  let hp = parseInt(inputTemporary.value || 1);
  hp = Math.abs(hp);
  main_json.character.hitPoints.temporary = temporary + hp
  updateHp();
  inputTemporary.value = '';
}


function main() {
  if (localStorage.getItem("updated") === 'true') {
    sendHP();
    main_json.character.hitPoints.currentHp = localStorage.getItem("currentHp");
    main_json.character.hitPoints.temporary = localStorage.getItem("temporary");
    temporary.innerText = main_json.character.hitPoints.temporary;
    hp.innerText = localStorage.getItem("currentHp") + "/" + main_json.character.hitPoints.maxHp;
  }

  setInterval(sendHP, 60000);

  damageBtn.addEventListener("click", damageHp);
  healBtn.addEventListener("click", healHp);
  temporaryBtn.addEventListener("click", addTemporaryHp);
}

document.addEventListener("DOMContentLoaded", main);

let xhttp = new XMLHttpRequest();
let csrf = document.querySelector("[name='csrf-token']").content;

xhttp.onreadystatechange = function() {
  if (this.readyState == 4 && this.status == 200) {
    localStorage.setItem("updated", false);
  }
};