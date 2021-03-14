include <_constants.scad>
use <_ittybox.scad>;

translate([-panel_depth/4, 0, 0])
difference() {
  left_panel();
  translate([joint_offset, 0, 0]) panel_joint();
}