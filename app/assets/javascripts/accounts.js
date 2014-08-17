$(document).on('ready page:load', function () {
  $('#accounts').dataTable({
    aoColumnDefs: [
        { 'bSortable': false, 'aTargets': [ 4 ] }
     ],
    pageLength: 25,
    lengthMenu: [ [10, 25, 50, -1], [10, 25, 50, "All"] ],
    sDom: 'tilp'
  });
});


$(document).on('ready page:load', function () {
  $('#transactions').dataTable({
    bSort: false,
    pageLength: 25,
    lengthMenu: [ [10, 25, 50, -1], [10, 25, 50, "All"] ],
    sDom: 'tilp'
  });
});
