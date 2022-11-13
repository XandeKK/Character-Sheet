import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.opacity = 1;

    setTimeout(()=> {this.transtion(this.element)}, 10000)
  }

  transtion(element) {
    if (this.opacity > 0) {
      this.opacity -= .1;
      setTimeout(()=> {this.transtion(element)},2.5);
    }
    element.style.opacity = this.opacity;
   }
}

