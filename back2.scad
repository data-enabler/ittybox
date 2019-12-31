include <ittybox.scad>;

translate([-panel_width/4, 0, 0])
difference() {
  back_panel();
  panel_split();
}