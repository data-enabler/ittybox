$fn = 20;

// AllFightSticks 9.5" Button Panel - Stickless
// https://allfightsticks.com/collections/9-5-enclosures/products/9-5-button-panel?variant=21327143141455
width = 229;
depth = 173.5;
height = 45;
screw_radius = 2.14;
screw_offset_x = 7.7;
screw_offset_y = 4.5;
corner_radius = 5;

// FocusAttack Blank Plexi Cover for AllFightSticks 9.5" Solid Bottom Panel
// https://focusattack.com/blank-plexi-cover-for-allfightsticks-9-5-solid-bottom-panel/
plexi_width = 218;
plexi_depth = depth;

// Sanwa SDM-18 buttons
// https://paradisearcadeshop.com/home/controls/buttons/sanwa/358-sanwa-sdm-series
button_diameter = 18;
button_panel_thickness = 3;

wall_thickness = 10;

spacer = 20;
offset_x = width/2 + spacer;
offset_y = depth/2 + spacer;

module quadrant() {
	difference() {
		union() {
			translate([corner_radius, -corner_radius, 0]) cylinder(height, r=corner_radius);
			translate([0, -depth/2, 0]) cube([wall_thickness, depth/2 - corner_radius, height]);
			translate([corner_radius, -wall_thickness, 0]) cube([width/2 - corner_radius, wall_thickness, height]);
			translate([wall_thickness, -wall_thickness*1.5, 0]) rotate(45) cube([wall_thickness, wall_thickness, height]);
		}
		translate([screw_offset_x + screw_radius, -screw_offset_y - screw_radius, 0]) cylinder(height*3, r=screw_radius, center=true);
	}
}

translate([-offset_x, offset_y, 0]) {
	quadrant();
}

translate([offset_x, offset_y, 0]) {
	mirror([1, 0, 0]) quadrant();
}

translate([-offset_x, -offset_y, 0]) {
	mirror([0, 1, 0]) quadrant();
}

translate([offset_x, -offset_y, 0]) {
	mirror([1, 0, 0]) mirror([0, 1, 0]) quadrant();
}
