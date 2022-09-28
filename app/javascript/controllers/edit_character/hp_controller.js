import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "max_hp", "current_hp", "ancestry_hp", "class_hp" ]

  connect() {
    this.con_total = document.getElementById("character_pathfinder_ability_attributes_con_total");
    this.level = document.getElementById("character_pathfinder_basic_attributes_level");
  }

  updateMaxHp() {
    let max_hp = 0;
    let class_hp = 0;
    let constitution = parseInt(this.con_total.value) || 0;

    class_hp = parseInt(this.class_hpTarget.value) || 0;
    class_hp *= parseInt(this.level.value) || 1;

    max_hp += parseInt(this.ancestry_hpTarget.value) || 0;
    max_hp += class_hp;
    max_hp += getModifier(constitution);
    this.max_hpTarget.value = max_hp;
    character_pathfinder_defense_attributes_max_hp.value = max_hp

    let current_hp = parseInt(this.current_hpTarget.value) || 0;

    if (current_hp == 0 || current_hp > max_hp) {
      this.current_hpTarget.value = max_hp;
    }
  }
}

function getModifier(value) {
  return Math.floor((value/2) - 5);
}