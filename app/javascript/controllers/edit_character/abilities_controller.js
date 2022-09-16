import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "str_total", "str_background", "str_class", "str_ascentry", "str_free",
    "dex_total", "dex_background", "dex_class", "dex_ascentry", "dex_free",
    "con_total", "con_background", "con_class", "con_ascentry", "con_free",
    "int_total", "int_background", "int_class", "int_ascentry", "int_free",
    "wis_total", "wis_background", "wis_class", "wis_ascentry", "wis_free",
    "cha_total", "cha_background", "cha_class", "cha_ascentry", "cha_free",
  ]

  updateTotalStrength() {
    let value = 10;
    value += parseInt(this.str_backgroundTarget.value) || 0;
    value += parseInt(this.str_classTarget.value) || 0;
    value += parseInt(this.str_ascentryTarget.value) || 0;
    value += parseInt(this.str_freeTarget.value) || 0;
    this.str_totalTarget.value = value;
  }

  updateTotalDexterity() {
    let value = 10;
    value += parseInt(this.dex_backgroundTarget.value) || 0;
    value += parseInt(this.dex_classTarget.value) || 0;
    value += parseInt(this.dex_ascentryTarget.value) || 0;
    value += parseInt(this.dex_freeTarget.value) || 0;
    this.dex_totalTarget.value = value;
  }

  updateTotalConstitution() {
    let value = 10;
    value += parseInt(this.con_backgroundTarget.value) || 0;
    value += parseInt(this.con_classTarget.value) || 0;
    value += parseInt(this.con_ascentryTarget.value) || 0;
    value += parseInt(this.con_freeTarget.value) || 0;
    this.con_totalTarget.value = value;
  }

  updateTotalIntelligence() {
    let value = 10;
    value += parseInt(this.int_backgroundTarget.value) || 0;
    value += parseInt(this.int_classTarget.value) || 0;
    value += parseInt(this.int_ascentryTarget.value) || 0;
    value += parseInt(this.int_freeTarget.value) || 0;
    this.int_totalTarget.value = value;
  }

  updateTotalWisdom() {
    let value = 10;
    value += parseInt(this.wis_backgroundTarget.value) || 0;
    value += parseInt(this.wis_classTarget.value) || 0;
    value += parseInt(this.wis_ascentryTarget.value) || 0;
    value += parseInt(this.wis_freeTarget.value) || 0;
    this.wis_totalTarget.value = value;
  }

  updateTotalCharisma() {
    let value = 10;
    value += parseInt(this.cha_backgroundTarget.value) || 0;
    value += parseInt(this.cha_classTarget.value) || 0;
    value += parseInt(this.cha_ascentryTarget.value) || 0;
    value += parseInt(this.cha_freeTarget.value) || 0;
    this.cha_totalTarget.value = value;
  }
}

function getModifier(value) {
  return Math.floor((value/2) - 5);
}