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

  updateTotal(event) {
    let value = 10;
    value += parseInt(this[`${event.params.ability}_backgroundTarget`].value) || 0;
    value += parseInt(this[`${event.params.ability}_classTarget`].value) || 0;
    value += parseInt(this[`${event.params.ability}_ascentryTarget`].value) || 0;
    value += parseInt(this[`${event.params.ability}_freeTarget`].value) || 0;
    this[`${event.params.ability}_totalTarget`].value = value;
  }
}
