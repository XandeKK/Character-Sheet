import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "current_hp", "max_hp", "temp_hp", "hp_input", "temp_hp_input"
  ]

  connect() {
    this.max_hp = parseInt(this.max_hpTarget.textContent);
    this.current_hp = parseInt(this.current_hpTarget.textContent);
    this.temp_hp = parseInt(this.temp_hpTarget.textContent);
  }

  healHp() {
    let value = parseInt(this.hp_inputTarget.value) || 1;
    value = Math.abs(value);

    this.current_hp += value;

    if (this.current_hp > this.max_hp) {
      this.current_hp = this.max_hp;
    }

    this.current_hpTarget.textContent = this.current_hp;
    this.hp_inputTarget.value = "";
  }

  damageHp() {
    let value = parseInt(this.hp_inputTarget.value) || 1;
    value = Math.abs(value);

    value = this.damageTempHp(value);

    this.current_hp -= value;

    if (this.current_hp < 0) {
      this.current_hp = 0;
    }

    this.current_hpTarget.textContent = this.current_hp;
    this.temp_hpTarget.textContent = this.temp_hp;
    this.hp_inputTarget.value = "";
  }

  addTempHp() {
    let value = parseInt(this.temp_hp_inputTarget.value) || 1;
    this.temp_hp += value;

    this.temp_hpTarget.textContent = this.temp_hp;
    this.temp_hp_inputTarget.value = "";
  }

  damageTempHp(value) {
    let damage = value - this.temp_hp;
    if(damage <= 0) {
      this.temp_hp -= value;
      return 0;
    } 

    this.temp_hp = 0;
    return damage;
  }
}

