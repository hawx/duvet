$(document).ready(function() {

  t = $('table.sort');
  
  $('#filter').keyup(function() {
    $.uiTableFilter(t, this.value);
    calculate_totals();
  });
  
  $('table.sort').tablesorter({
    sortList: [[0,0]],
    cssAsc: 'ascending',
    cssDesc: 'descending',
    widthFixed: true
  });
  
  
  // Need to get the cov and code totals to be weighted, if possible, to
  // the number of lines as in the ruby.
  function calculate_totals(col) {
    var sum = 0;
    var rows = [];
    
    var lines = 0;
    var loc = 0;
    var cov = 0;
    var code = 0;
    $('table.sort tbody tr').each(function(i) {
      if ($(this).css("display") != "none") {
        rows += $(this);
        
        $(this).children('td.lines').each(function(j) {
          lines += parseFloat($(this).text());
        });
        $(this).children('td.loc').each(function(j) {
          loc += parseFloat($(this).text());
        });
        $(this).children('td.cov').each(function(j) {
          cov += parseFloat($(this).text());
        });
        $(this).children('td.code').each(function(j) {
          code += parseFloat($(this).text());
        });
      }
    });
    var count = rows.length/15; // gets actual number of rows
    
    $('table.sort tfoot td.lines').text(lines);
    $('table.sort tfoot td.loc').text(loc);
    $('table.sort tfoot td.cov').text((cov/count).toFixed(2) + '%');
    $('table.sort tfoot td.code').text((code/count).toFixed(2) + '%');
  }

});