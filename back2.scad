include <constants.scad>
use <ittybox.scad>;

translate([-panel_width/4, 0, 0])
difference() {
  back_panel();
  translate([joint_offset, 0, 0]) panel_joint();
}