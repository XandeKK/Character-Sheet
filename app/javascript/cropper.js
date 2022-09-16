// window.addEventListener("turbo:load", function() {
//   let character_image = document.getElementById("character-image");
//   let input = document.getElementById("input");
//   let character_image_input = document.getElementById("character_character_image");
//   let cropper;

//   function addCropper(url) {
//     if (cropper) cropper.destroy();
//     cropper = null;
//     input.value = '';
//     character_image.src = url;

//     cropper = new Cropper(character_image, {
//       aspectRatio: 1,
//       viewMode: 1,
//       dragMode: "move",
//       rotatable: false,
//       cropBoxMovable: false,
//       cropBoxResizable: false,
//       responsive: false,
//       toggleDragModeOnDblclick: false,
//       ready: function() {
//         let croppedCanvas = cropper.getCroppedCanvas({maxWidth: 384, maxHeight: 384});
//         character_image_input.value = croppedCanvas.toDataURL();
//       },
//       cropend: function() {
//         let croppedCanvas = cropper.getCroppedCanvas({maxWidth: 384, maxHeight: 384});
//         character_image_input.value = croppedCanvas.toDataURL();
//       },
//       zoom: function() {
//         let croppedCanvas = cropper.getCroppedCanvas({maxWidth: 384, maxHeight: 384});
//         character_image_input.value = croppedCanvas.toDataURL();
//       }
//     })
//   }


//   function addImage(e) {
//     var files = e.target.files;

//     var done = function (url) {
//       addCropper(url);
//     };

//     var reader;
//     var file;
//     var url;

//     if (files && files.length > 0) {
//       file = files[0];

//       if (URL) {
//         done(URL.createObjectURL(file));
//       } else if (FileReader) {
//         reader = new FileReader();
//         reader.onload = function (e) {
//           done(reader.result);
//         };
//         reader.readAsDataURL(file);
//       }
//     }
//   }
  
//   input.addEventListener('change', addImage); 
  
// })
