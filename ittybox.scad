$fn = 20;

// AllFightSticks 9.5" Button Panel - Stickless
// https://allfightsticks.com/collections/9-5-enclosures/products/9-5-button-panel?variant=21327143141455
width = 229;
depth = 173.5;
bolt_offset_x = 9.6; // distance to center of hole
bolt_offset_y = 6.5; // distance to center of hole
corner_radius = 5;

// FocusAttack Blank Plexi Cover for AllFightSticks 9.5" Solid Bottom Panel
// https://focusattack.com/blank-plexi-cover-for-allfightsticks-9-5-solid-bottom-panel/
plexi_width = 218;
plexi_depth = depth;

// Sanwa SDM-18 buttons
// https://paradisearcadeshop.com/home/controls/buttons/sanwa/358-sanwa-sdm-series
button_diameter = 18;
button_tab_diameter = 24;
button_panel_thickness = 3;

// Brook Wireless Fighting Board
// https://www.brookaccessory.com/detail/41130595/
usb_panel_width = 26;
usb_panel_height = 31;
usb_panel_depth = 1.5;

// M4 x 20mm internal hex button-head screw
bolt_diameter = 4;
bolt_length = 20;
bolt_nut_thickness = 3.2;
bolt_nut_width = 8; // outer
bolt_nut_clearance = 10;

height = 45;
corner_overlap = 20;
end_corner_height = 8;
corner_chamfer = 16;
button_spacing = button_tab_diameter*1.2;

module end_panel(wall_thickness) {
	difference() {
		union() {
			// Main panel
			translate([0, 0, wall_thickness/2]) {
				cube([width - corner_radius*2, height, wall_thickness], center=true);
			}

			for (x = [-1, 1]) {
				// Rounded corner
				translate([x*(width/2 - corner_radius), 0, corner_radius]) {
					r = corner_radius;
					rotate([90, 0, 0]) {
						intersection() {
							cylinder(height, r=r, center=true, $fn=4);
							mirror([x > 0 ? 1 : 0, 0, 0]) translate([0, 0, -height/2]) {
								linear_extrude(height=height) polygon([[-r, r], [-r, -r], [r, -r]]);
							}
						}
					}
				}
				overlap_length = corner_overlap - corner_radius;

				// Overlap side
				translate([x*(width/2 - wall_thickness/2), 0, corner_radius + overlap_length/2]) {
					cube([wall_thickness, height, overlap_length], center=true);
				}

				// Corner chamfer
				translate([x*(width/2), height/2 - end_corner_height*2, 0]) {
					mirror([x > 0 ? 1 : 0, 0, 0])
					intersection() {
						rotate([0, 45, 0]) cube([corner_chamfer*2, height*2, corner_chamfer*2], center=true);
						translate([wall_thickness, 0, wall_thickness]) {
							cube([width/2, end_corner_height*2, corner_overlap - wall_thickness], center=false);
						}
					}
				}
			}
		}
		for (x = [-1, 1]) {
			// Bolt hole
			translate([x*(width/2 - bolt_offset_x), height/2 - end_corner_height*2, bolt_offset_y]) {
				rotate([-90, 0, 0]) cylinder(height, d=bolt_diameter, center=false);
				rotate([0, -45, 0]) cube([bolt_diameter/2, height, bolt_diameter/2], center=false);
				bolt_depression = bolt_nut_thickness/2;
				translate([0, bolt_depression, 0]) {
					rotate([90, 0, 0]) cylinder(bolt_nut_clearance + bolt_depression, d=bolt_nut_width, center=false, $fn=6);
				}
				mirror([0, 1, 0]) translate([-bolt_nut_width/2, 0, 0]) cube([bolt_nut_width, bolt_nut_clearance, bolt_nut_width], center=false);
			}

			// Overlap cutout
			translate([x*(width/2), height/2 - end_corner_height*3/2, 0]) {
				cube([corner_overlap*2, end_corner_height, corner_overlap*4], center=true);
			}

			// Diagonal corner cut
			translate([x*(width/2), height/2 - end_corner_height*1.9, 0]) {
				mirror([0, 1, 0]) rotate([0, -45, 0]) cube([width, height, width], center=false);
			}
		}
	}
}

module button_hole() {
	cylinder(button_panel_thickness*3, d=button_diameter, center=true);
	translate([0, 0, button_panel_thickness])
		cylinder(button_panel_thickness*2, d=button_tab_diameter, center=false);
}

module back_panel() {
	wall_thickness = 8;
	difference() {
		end_panel(wall_thickness);

		// USB port panel
		translate([0, height/2, wall_thickness/2]) {
			cube([usb_panel_width, usb_panel_height*2, usb_panel_depth], center=true);
			cube([usb_panel_width-1, usb_panel_height*2, wall_thickness*2], center=true);
		}

		// Button holes
		translate([0, height/2 - usb_panel_height/2, 0]) {
			offset = usb_panel_width/2;
			for (x = [
				-(offset + button_spacing*2),
				-(offset + button_spacing),
				(offset + button_spacing),
				(offset + button_spacing*2),
			]) {
				translate([x, 0, 0]) {
					button_hole();
				}
			}
		}
	}
}

module front_panel() {
	end_panel(4);
}

back_panel();
translate([0, height*1.5, 0]) front_panel();
