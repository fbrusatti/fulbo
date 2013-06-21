# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(".affiliation")
    .on("ajax:beforeSend", () ->
      $.fancybox.showLoading()
    )
    .on("ajax:success", () ->
      $.fancybox.hideLoading()
    )
  $(".unaffiliation")
    .on("ajax:beforeSend", () ->
      $.fancybox.showLoading()
    )
    .on("ajax:success", () ->
      $.fancybox.hideLoading()
    )
