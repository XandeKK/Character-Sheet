import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
  ]

  connect() {
    document.addEventListener("turbo:submit-end", this.submitEnd.bind(this))
  }

  submitEnd() {
    let button = event.detail.formSubmission.submitter;

    if (!event.detail.formSubmission.result.success) {
      this.errorSubmit();
      return;
    }

    let characterId = button.getAttribute("data-character");
    let characterCategory = button.getAttribute("data-category");

    if (button.getAttribute("data-action") == "add") {
      this.addCharacter(characterId, characterCategory);
    } else {
      this.removeCharacter(characterId, characterCategory);
    }
  }

  errorSubmit() {
    console.log("Error!")
  }

  addCharacter(id, category) {
    document.getElementById(`form-add-${id}`).classList.add("hidden");
    document.getElementById(`form-remove-${id}`).classList.remove("hidden");
  }

  removeCharacter(id, category) {
    document.getElementById(`form-remove-${id}`).classList.add("hidden");
    document.getElementById(`form-add-${id}`).classList.remove("hidden");
    document.getElementById(`character-${id}`).remove();
  }
}

