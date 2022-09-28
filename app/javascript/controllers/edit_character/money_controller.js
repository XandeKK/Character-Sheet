import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.money_total = document.getElementById("money-total");
    this.copper = document.getElementById("character_pathfinder_money_attributes_copper");
    this.silver = document.getElementById("character_pathfinder_money_attributes_silver");
    this.gold = document.getElementById("character_pathfinder_money_attributes_gold");
    this.platinum = document.getElementById("character_pathfinder_money_attributes_platinum");
  }

  updateMoney() {
    let money = 0;

    let copper = parseInt(this.copper.value) || 0;
    let silver = parseInt(this.silver.value) || 0;
    let gold = parseInt(this.gold.value) || 0;
    let platinum = parseInt(this.platinum.value) || 0;

    money += copperToGold(copper);
    money += silverToGold(silver);
    money += gold;
    money += platinumToGold(platinum);

    this.money_total.value = `${money}gp`;
  }
}

function copperToGold(value) {
  return value/100;
}

function silverToGold(value) {
  return value/10;
}

function platinumToGold(value) {
  return value*10;
}