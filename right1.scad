include <constants.scad>
use <ittybox.scad>;

translate([panel_depth/4, 0, 0])
intersection() {
  right_panel();
  panel_joint();
}