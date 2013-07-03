$(function () {
  $('#team_player_tokens').tokenInput('/users.json', { 
    crossDomain: false,
    prePopulate: $('#team_player_tokens').data('pre'),
    theme: "facebook",
    preventDuplicates: true
  });
});