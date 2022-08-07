// Event
damageBtnArray = document.querySelectorAll(".damageBtn")
healBtnArray = document.querySelectorAll(".healBtn")
temporaryBtnArray = document.querySelectorAll(".temporaryBtn")

for (var i = 0; i < damageBtnArray.length; i++) {
  damageBtnArray[i].addEventListener("click", damageHp)
}

for (var i = 0; i < healBtnArray.length; i++) {
  healBtnArray[i].addEventListener("click", healHp)
}

for (var i = 0; i < temporaryBtnArray.length; i++) {
  temporaryBtnArray[i].addEventListener("click", addTemporaryHp)
}

// Functions
function updateHp(id) {
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
}

function damageHp(event) {
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
  updateHp(id);
}

function healHp(event) {
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
  updateHp(id);
  input.value = '';
}

function addTemporaryHp(event) {
  let id = event.target.getAttribute("character_id");
  let character_json = json[id];
  let temporary = parseInt(character_json["temporary"]);
  let input = document.getElementById("inputTemporary_character_" + id);
  let hp = parseInt(input.value || 1);
  hp = Math.abs(hp);
  
  json[id]["temporary"] = temporary + hp
  updateHp(id);
  input.value = '';
}