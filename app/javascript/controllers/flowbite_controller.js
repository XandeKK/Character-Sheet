import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  drawer = ""
  connect() {
    const targetEl = document.getElementById('drawer-navigation');
    this.drawer = new Drawer(targetEl);
  }

  toggleDrawer() {
    this.drawer.toggle();
  }
}
