import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "drawer", "drawer_character_title", "drawer_character_note", "dice_div",
    "attack", "secondAttack", "thirdAttack", "damage", "weaponDice", "macro"
  ]

  connect() {
    if (this.hasDrawerTarget) {
      this.drawer = new Drawer(this.drawerTarget, {placement: "right"});
    }
  }

  toggleDrawerWeapon(event) {
    let name = event.params.name;
    let note = event.params.note;
    let other = event.params.other;
    let traits = event.params.traits;
    let attack = event.params.attack;
    let secondAttack = event.params.secondAttack;
    let thirdAttack = event.params.thirdAttack;

    this.drawer_character_titleTarget.textContent = name
    this.drawer_character_noteTarget.textContent = `Other: ${other}\n\nTraits: ${traits}\n\nNote: \n${note}`
    this.attackTarget.textContent = attack;
    this.secondAttackTarget.textContent = secondAttack;
    this.thirdAttackTarget.textContent = thirdAttack;

    this.drawer.toggle();
    this.macroTarget.classList.add("hidden")
    this.weaponDiceTarget.classList.remove("hidden")
    this.dice_divTarget.classList.remove("hidden")
  }

  toggleDrawerMacro(event) {
    let name = event.params.name;
    let notation = event.params.notation;
    let note = event.params.note;

    this.drawer_character_titleTarget.textContent = name
    this.drawer_character_noteTarget.textContent = `Note: \n${note}`

    this.macroTarget.textContent = notation;
    this.macroTarget.setAttribute("data-channels--adventure-dice-param", notation);

    this.drawer.toggle();
    this.macroTarget.classList.remove("hidden")
    this.weaponDiceTarget.classList.add("hidden")
    this.dice_divTarget.classList.remove("hidden")
  }
}

