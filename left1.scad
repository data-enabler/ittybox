include <ittybox.scad>;

translate([panel_depth/4, 0, 0])
intersection() {
  left_panel();
  panel_joint();
}