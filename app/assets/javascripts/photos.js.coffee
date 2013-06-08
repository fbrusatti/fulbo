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

  $("#add_a_photo").on("ajax:success", () ->
    $(document).ready ->
      $("#new_photo")
        .on("ajax:beforeSend", () ->
          $.fancybox.showLoading()
          $(".btn_modal").attr("disabled", true)
        )
        .on("ajax:success", () ->
          $.fancybox.hideLoading()
          $(".btn_modal").attr("disabled", false)
        )
  );
