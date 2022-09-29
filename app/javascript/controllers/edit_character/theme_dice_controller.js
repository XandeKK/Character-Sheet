import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "inputColor", "inputTheme"
  ]

  saveThemeLocalStorage() {
    let json = {
      color: this.inputColorTarget.value,
      theme: this.inputThemeTarget.value
    }
    let characterId = this.inputColorTarget.getAttribute("data-edit-character--theme-dice-character-id-param")

    localStorage.setItem(`theme-${characterId}`, JSON.stringify(json))
  }
}
