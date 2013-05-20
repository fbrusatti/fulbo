# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class AvatarCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1
      setSelect: [600, 600, 0, 0]
      onSelect: @update
      onChange: @update
  
  update: (coords) =>
    $('#user_profile_crop_x').val(coords.x)
    $('#user_profile_crop_y').val(coords.y)
    $('#user_profile_crop_w').val(coords.w)
    $('#user_profile_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#preview').css
      width: Math.round(100/coords.w * $('#cropbox').width()) + 'px'
      height: Math.round(100/coords.h * $('#cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
jQuery ->
  new AvatarCropper()
