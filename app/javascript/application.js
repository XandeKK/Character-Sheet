// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import scrollSpy from 'simple-scrollspy'
import Cropper from 'cropperjs';

window.Cropper = Cropper;

window.addEventListener("turbo:load", function() {
  const mainMenu = document.getElementById('main-menu');
  if (mainMenu) {
    const options = {
      sectionClass: '.scrollspy',
      menuActiveTarget: '.menu-item',
      offset: 100,
      hrefAttribute: "href-spy",
      activeClass: "fill-rose-500"
    }

    scrollSpy(mainMenu, options);
  }
})


window.storageAvailable = function(type) {
  try {
    var storage = window[type],
      x = '__storage_test__';
    storage.setItem(x, x);
    storage.removeItem(x);
    return true;
  } catch (e) {
    return e instanceof DOMException && (
        // everything except Firefox
        e.code === 22 ||
        // Firefox
        e.code === 1014 ||
        // test name field too, because code might not be present
        // everything except Firefox
        e.name === 'QuotaExceededError' ||
        // Firefox
        e.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
      // acknowledge QuotaExceededError only if there's something already stored
      storage.length !== 0;
  }
}