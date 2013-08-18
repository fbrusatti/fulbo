$(document).ready(function(){
  $('#datetimepicker2').datetimepicker({
    maskInput: true,
    language: 'es',
    pick12HourFormat: true,
    pickSeconds: false,
    minuteStep: 15,
    format: 'dd/MM/yyyy hh:mm',
    startDate: new Date()
  });
});