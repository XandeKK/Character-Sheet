import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "image_base64_input", "image_input", "character_image"
  ]

  connect() {
    this.cropper = null;
  }

  changeImage(event) {
    let files = event.target.files;

    let reader;
    let file;
    let url;

    if (files && files.length > 0) {
      file = files[0];

      if (URL) {
        this.addCropper(URL.createObjectURL(file));
      } else if (FileReader) {
        reader = new FileReader();
        reader.onload = function (e) {
          this.addCropper(reader.result);
        };
        reader.readAsDataURL(file);
      }
    }
  }

  addCropper(url) {
    if (this.cropper) this.cropper.destroy();
    this.cropper = null;
    this.image_inputTarget.value = '';
    this.character_imageTarget.src = url;

    this.cropper = new Cropper(this.character_imageTarget, {
      aspectRatio: 1,
      viewMode: 1,
      dragMode: "move",
      rotatable: false,
      cropBoxMovable: false,
      cropBoxResizable: false,
      responsive: false,
      toggleDragModeOnDblclick: false
    })
  }

  setBase64() {
    let croppedCanvas = this.cropper.getCroppedCanvas({maxWidth: 384, maxHeight: 384});
    this.image_base64_inputTarget.value = croppedCanvas.toDataURL();
  }
}
