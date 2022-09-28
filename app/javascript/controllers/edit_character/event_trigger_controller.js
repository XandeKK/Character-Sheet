import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "hp", "saving_throw"
  ]

  updateMaxHp() {
    let hp = this.application.getControllerForElementAndIdentifier(this.hpTarget, 'edit-character--hp');
    hp.updateMaxHp();
  }

  updateFortitude() {
    let saving_throw = this.application.getControllerForElementAndIdentifier(this.saving_throwTarget, 'edit-character--saving-throw');
    saving_throw.updateFortitude();
  }

  updateReflex() {
    let saving_throw = this.application.getControllerForElementAndIdentifier(this.saving_throwTarget, 'edit-character--saving-throw');
    saving_throw.updateReflex();
  }

  updateWill() {
    let saving_throw = this.application.getControllerForElementAndIdentifier(this.saving_throwTarget, 'edit-character--saving-throw');
    saving_throw.updateWill();
  }
}
