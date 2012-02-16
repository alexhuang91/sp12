$(function() {
    $( "#starts_at" ).datetimepicker({
      ampm: true,
      showMinute: false,
      minute: 0,
      minuteMax: 0,
    dateFormat: 'yy-mm-dd'
    });
      });

$(function() {
    $( "#ends_at" ).datetimepicker({
    ampm: true,
    minuteMax:0,
    minute:0,
    showMinute: false,
    dateFormat: 'yy-mm-dd'
    });
      });

$(function() {
  $( "#slider" ).slider();
 });
$(function() {
    $( "#accordion" ).accordion({
          collapsible: true
              });
                });
