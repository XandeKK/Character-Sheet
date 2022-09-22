import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "drawer_navigation", "drawer_character",
    "drawer_character_title", "drawer_character_note", "dice_div",
    "attack", "second_attack", "third_attack", "damage",
  ]
  connect() {
    if (this.hasDrawer_navigationTarget) {
      this.drawerLeft = new Drawer(this.drawer_navigationTarget);
    }

    if (this.hasDrawer_characterTarget) {
      this.drawerRight = new Drawer(this.drawer_characterTarget, {placement: "right"});
    }
  }

  toggleDrawerLeft() {
    this.drawerLeft.toggle();
  }

  toggleDrawerRight(event) {
    let name = event.params.name
    let note = event.params.note

    if (event.params.volume) {
      let body = `Volume: ${event.params.volume} Quatity: ${event.params.quatity}\n\n`
      note = body + note
    }

    this.dice_divTarget.classList.add("hidden")
    this.drawer_character_titleTarget.textContent = name
    this.drawer_character_noteTarget.textContent = note
    this.drawerRight.toggle();
  }

  toggleDrawerWeapon(event) {
    let name = event.params.name;
    let note = event.params.note;
    let other = event.params.other;
    let traits = event.params.traits;
    let attack = event.params.attack;
    let secondAttack = event.params.secondAttack;
    let thirdAttack = event.params.thirdAttack;
    let damage = event.params.damage;

    this.drawer_character_titleTarget.textContent = name
    this.drawer_character_noteTarget.textContent = `Other: ${other}\n\nTraits: ${traits}\n\nNote: \n${note}`
    this.attackTarget.textContent = attack;
    this.attackTarget.setAttribute("data-channels--character-dice-param", `1d20${attack}`);
    this.second_attackTarget.textContent = secondAttack;
    this.second_attackTarget.setAttribute("data-channels--character-dice-param", `1d20${secondAttack}`);
    this.third_attackTarget.textContent = thirdAttack;
    this.third_attackTarget.setAttribute("data-channels--character-dice-param", `1d20${thirdAttack}`);
    this.damageTarget.setAttribute("data-channels--character-damage-param", damage);

    this.drawerRight.toggle();
    this.dice_divTarget.classList.remove("hidden")
  }
}

