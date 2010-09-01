$(document).ready(function() {

  t = $('table');
  
  $('#filter').keyup(function() {
    $.uiTableFilter(t, this.value);
  });
  
  $('table').tablesorter({
    sortList: [[0,0]],
    cssAsc: 'ascending',
    cssDesc: 'descending',
    widthFixed: true
  });

});