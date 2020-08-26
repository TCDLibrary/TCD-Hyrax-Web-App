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
