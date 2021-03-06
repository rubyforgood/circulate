// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "controllers"

require("trix")
require("@rails/actiontext")

require.context('../images', true)

const feather = require("feather-icons/dist/feather")
document.addEventListener("turbolinks:load", function() {
  feather.replace({
    width: 20,
    height: 20,
    class: "feather-icon",
  });
})

import scrollIntoView from 'smooth-scroll-into-view-if-needed';

Turbolinks.ScrollManager.prototype.scrollToElement = function(element) {
  let classes = element.classList;
  if (classes.contains("highlightable")) {
    classes.add("highlight");
  }
  scrollIntoView(element, {
    behavior: 'smooth',
    scrollMode: 'if-needed',
  });
}