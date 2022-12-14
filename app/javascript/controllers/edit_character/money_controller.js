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

    money += this.copperToGold(copper);
    money += this.silverToGold(silver);
    money += gold;
    money += this.platinumToGold(platinum);

    this.money_total.value = `${money}gp`;
  }

  copperToGold(value) {
    return value/100;
  }
  
  silverToGold(value) {
    return value/10;
  }

  platinumToGold(value) {
    return value*10;
  }
}

