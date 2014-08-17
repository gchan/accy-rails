//
// http://bootstrap-datepicker.readthedocs.org
//
(function(){
  $(document).on('page:load ready', function(){
    $(".form-group.date .input-group input").datepicker({
      format: 'd MM yyyy',
      weekStart: 1,
      todayHighlight: true
    });
  });
}());
