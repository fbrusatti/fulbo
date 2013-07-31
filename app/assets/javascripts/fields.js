$(document).ready(function(){
  $('#datetimepicker2').datetimepicker({
    maskInput: true,
    language: 'es',
    pick12HourFormat: true,
    format: 'dd/MM/yyyy hh:mm',
    startDate: new Date()
  });
});