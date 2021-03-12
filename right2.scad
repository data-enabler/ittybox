include <constants.scad>
use <ittybox.scad>;

translate([-panel_depth/4, 0, 0])
difference() {
  right_panel();
  translate([joint_offset, 0, 0]) panel_joint();
}