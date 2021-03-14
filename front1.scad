include <_constants.scad>
use <_ittybox.scad>;

translate([panel_width/4, 0, 0])
intersection() {
  front_panel();
  panel_joint();
}