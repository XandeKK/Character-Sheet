import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "drawer_navigation", "drawer_character",
    "drawer_character_title", "drawer_character_note", "dice_div",
    "attack", "secondAttack", "thirdAttack", "damage",
    "weaponDice", "macro", "inputColor", "inputTheme"
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
    let note = `Note:\n${event.params.note}`

    if (event.params.volume) {
      let body = `Volume: ${event.params.volume} Quatity: ${event.params.quatity}\n\n`
      note = `${body}Note:\n${event.params.note}`
    }

    this.dice_divTarget.classList.add("hidden")
    this.drawer_character_titleTarget.textContent = event.params.name
    this.drawer_character_noteTarget.textContent = note
    this.drawerRight.toggle();
  }

  toggleDrawerWeapon(event) {
    this.drawer_character_titleTarget.textContent = event.params.name
    this.drawer_character_noteTarget.textContent = `Other: ${event.params.other}\n\nTraits: ${event.params.traits}\n\nNote: \n${event.params.note}`
    this.attackTarget.textContent = event.params.attack;
    this.secondAttackTarget.textContent = event.params.secondAttack;
    this.thirdAttackTarget.textContent = event.params.thirdAttack;

    this.drawerRight.toggle();
    this.macroTarget.classList.add("hidden")
    this.weaponDiceTarget.classList.remove("hidden")
    this.dice_divTarget.classList.remove("hidden")
    this.setThemeDice(event.params.characterId)
  }

  toggleDrawerMacro(event) {
    this.drawer_character_titleTarget.textContent = event.params.name
    this.drawer_character_noteTarget.textContent = `Note: \n${event.params.note}`

    this.macroTarget.textContent = event.params.notation;
    this.macroTarget.textContent = event.params.notation;
    this.macroTarget.setAttribute("data-channels--character-dice-param", event.params.notation);

    this.drawerRight.toggle();
    this.macroTarget.classList.remove("hidden")
    this.weaponDiceTarget.classList.add("hidden")
    this.dice_divTarget.classList.remove("hidden")
    this.setThemeDice(event.params.characterId)
  }

  setThemeDice(characterId) {
    this.inputColorTarget.setAttribute("data-edit-character--theme-dice-character-id-param", characterId)
    if (localStorage[`theme-${characterId}`]) {
      let json = JSON.parse(localStorage[`theme-${characterId}`])
      this.inputColorTarget.value = json.color
      this.inputThemeTarget.value = json.theme
    }
  }
}

