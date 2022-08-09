var el = document.getElementById('croppie');
let vanilla = new Croppie(el, {
  viewport: { width: 300, height: 300, type: 'circle' },
  boundary: { width: 300, height: 300 },
});

vanilla.bind({
  url: url
});

let original = document.getElementById('original');
original.addEventListener("change", previewFile);

function previewFile() {
  let file = original.files[0];
  let reader = new FileReader();

  reader.onloadend = function () {
    vanilla.bind({
      url: reader.result
    })
  }

  if (file) {
    reader.readAsDataURL(file);
  } else {
    preview.src = "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==";
  }
}