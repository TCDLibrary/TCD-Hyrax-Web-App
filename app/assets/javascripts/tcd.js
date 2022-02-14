// see views/hyrax/base/_attribute_rows.html.erb

// TCDdots is a marker just before the collapsible button
// TCDspot is a nice spot to scroll to after clicking Read less
// TCDmore contains the metadata to be expaned
// TCDMoreBtn is the button

function TCDCollapsibleFunction() {
  var tcd_dots = document.getElementById("TCDdots");
  var tcd_spot = document.getElementById("TCDspot");
  var tcd_moreText = document.getElementById("TCDmore");
  var tcd_btnText = document.getElementById("TCDMoreBtn");

  if (tcd_dots.style.display === "none") {
    tcd_dots.style.display = "inline";
    tcd_btnText.innerHTML = "Read more";
    tcd_moreText.style.display = "none";
    tcd_spot.scrollIntoView();
  } else {
    tcd_dots.style.display = "none";
    tcd_btnText.innerHTML = "Read less";
    tcd_moreText.style.display = "inline";
  }
}

function TCDActivateButton() {

  TCDGenerateTable();

  var my_button = $('<input type="submit" value="Proceed"/>');

  // Insert into DOM
  $('#proceed_button').html(my_button);
}


function TCDGenerateTable() {
  var data = $('textarea[name=excel_data]').val();
  //console.log(data);
  const queryString = window.location.search;
  const urlParams = new URLSearchParams(queryString);
  const objid = urlParams.get('id')
  var rows = data.split("\n");

  var table = $('<table class="table table-striped" />');

  table.append('<thead><tr><th>Owner ID</th><th>Image Name</th><th>New Image Label</th></tr></thead>')

  for(var y in rows) {
      var cells = rows[y].split("\t");
      var row = $('<tr />');
      row.append('<td>'+objid+'</td>');
      for(var x in cells) {
          row.append('<td>'+cells[x]+'</td>');
      }
      table.append(row);
  }

  // Insert into DOM
  $('#excel_table').html(table);
}
