// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

//External Imports
import "bootstrap";
import GameSpace from "../components/game_space";


// Marty Magic
document.addEventListener('turbolinks:load', () => {
  const initPlugin = (querySelector, Component) => {
    const els = document.querySelectorAll(querySelector);
    if (els) {
      els.forEach(el => {
        Component(el);
      });
    }
  };
  initPlugin(".js-game-space", GameSpace);
});

// window.addEventListener('turbolinks:load', function() { window. scrollTo(0, 0); });

// Resize event for input

window.addEventListener('resize', addressResize);

const addressResize = (event) => {
  document.querySelector('body').style.backgroundColor = 'blue';
}
// document.documentElement.style.setProperty(‘overflow’, ‘auto’)
// const metaViewport = document.querySelector(‘meta[name=viewport]’)
// metaViewport.setAttribute(‘content’, ‘height=’ + initialHeight + ‘px, width=device-width, initial-scale=1.0’)

// const metaViewport = document.querySelector(‘meta[name=viewport]’)
// metaViewport.setAttribute(‘content’, ‘width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0’)



