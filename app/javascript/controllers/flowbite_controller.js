import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
  "drawer_navigation", "drawer_character",
  "drawer_character_title", "drawer_character_note"
    ]
  connect() {
    this.drawerLeft = new Drawer(this.drawer_navigationTarget);

    if (this.hasDrawer_characterTarget) {
      this.drawerRight = new Drawer(this.drawer_characterTarget, {placement: "right"});
    }
  }

  toggleDrawerLeft() {
    this.drawerLeft.toggle();
  }

  toggleDrawerRight(event) {
    this.drawer_character_titleTarget.textContent = event.params.name

    if (event.params.volume) {
      let body = `Volume: ${event.params.volume} Quatity: ${event.params.quatity}\n\n`
      this.drawer_character_noteTarget.textContent = body + event.params.note
    } else {
      this.drawer_character_noteTarget.textContent = event.params.note
    }

    this.drawerRight.toggle();
  }
}

