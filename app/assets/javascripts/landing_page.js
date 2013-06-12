$(document).ready(function(){
  $('.slides').cycle({
    fx:               'scrollRight',
    next:             '.controls .right',
    prev:             '.controls .left',
    containerResize:  false,
    slideResize:      false,
    fit:              1,
    timeout:          0
  });
});