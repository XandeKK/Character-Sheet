import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "fortitude_total", "fortitude_proficiency", "fortitude_item", "fortitude_misc", "fortitude_penalty",
    "reflex_total", "reflex_proficiency", "reflex_item", "reflex_misc", "reflex_penalty",
    "will_total", "will_proficiency", "will_item", "will_misc", "will_penalty",
  ]

  connect() {
    this.con_total = document.getElementById("character_pathfinder_ability_attributes_con_total");
    this.dex_total = document.getElementById("character_pathfinder_ability_attributes_dex_total");
    this.wis_total = document.getElementById("character_pathfinder_ability_attributes_wis_total");
  }

  updateFortitude() {
    let con_total = parseInt(this.con_total.value) || 0;
    let modifier = this.getModifier(con_total);

    let proficiency = parseInt(this.fortitude_proficiencyTarget.value) || 0;
    let item = parseInt(this.fortitude_itemTarget.value) || 0;
    let misc =parseInt(this.fortitude_miscTarget.value) || 0;
    let penalty = -Math.abs(parseInt(this.fortitude_penaltyTarget.value) || 0);

    let value = proficiency + item + misc + penalty + modifier;

    this.fortitude_totalTarget.value = value;
  }

  updateReflex() {
    let dex_total = parseInt(this.dex_total.value) || 0;
    let modifier = this.getModifier(dex_total);

    let proficiency = parseInt(this.reflex_proficiencyTarget.value) || 0;
    let item = parseInt(this.reflex_itemTarget.value) || 0;
    let misc =parseInt(this.reflex_miscTarget.value) || 0;
    let penalty = -Math.abs(parseInt(this.reflex_penaltyTarget.value) || 0);

    let value = proficiency + item + misc + penalty + modifier;

    this.reflex_totalTarget.value = value;
  }

  updateWill() {
    let wis_total = parseInt(this.wis_total.value) || 0;
    let modifier = this.getModifier(wis_total);

    let proficiency = parseInt(this.will_proficiencyTarget.value) || 0;
    let item = parseInt(this.will_itemTarget.value) || 0;
    let misc =parseInt(this.will_miscTarget.value) || 0;
    let penalty = -Math.abs(parseInt(this.will_penaltyTarget.value) || 0);

    let value = proficiency + item + misc + penalty + modifier;

    this.will_totalTarget.value = value;
  }
  
  getModifier(value) {
    return Math.floor((value/2) - 5);
  }
}