$(function(){
  $('form').submit(function(){
    $.post('/chat', { message: $('#message').val() }, function(){
      $('#message').val('');
    });
    return false;
  });
  
  function poll () {
    $.getJSON('/poll', function(messages){
      $('#log').empty();
      $.each(messages, function(i, m){
        $('<p/>').text(m).appendTo("#log");
      });
      poll();
    });
  }
  poll();
});