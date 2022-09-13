// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import scrollSpy from 'simple-scrollspy'

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

