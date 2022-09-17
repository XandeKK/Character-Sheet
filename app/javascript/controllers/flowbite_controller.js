import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "drawer_navigation", "drawer_character", "drawer_character_title", "drawer_character_note" ]
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
    console.log(event.params)
    this.drawer_character_titleTarget.textContent = event.params.name
    this.drawer_character_noteTarget.textContent = event.params.note
    this.drawerRight.toggle();
  }
}
