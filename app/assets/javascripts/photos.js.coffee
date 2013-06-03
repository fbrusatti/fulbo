// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(".fancybox-button").fancybox
    prevEffect: "none"
    nextEffect: "none"
    closeBtn: false
    helpers:
      title:
        type: "inside"

      buttons: {}
