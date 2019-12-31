include <ittybox.scad>;

translate([-panel_width/4, 0, 0])
difference() {
  front_panel();
  panel_joint();
}