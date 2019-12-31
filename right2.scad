include <ittybox.scad>;

translate([-panel_depth/4, 0, 0])
difference() {
  right_panel();
  panel_joint();
}