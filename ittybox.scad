include <constants.scad>

module panel(wall_thickness, side=false) {
	bolt_x = side ? bolt_offset_y : bolt_offset_x;
	bolt_z = side ? bolt_offset_x : bolt_offset_y;
	width = side ? panel_depth : panel_width;
	overlap_cutout_potition = side ? 0 : -end_corner_height;

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

			if (side) {
				// Plexi support
				support_height = (panel_width - plexi_width)/2 + 4;
				translate([0, -height/2 + plexi_thickness/2, support_height/2]) {
					cube([width - corner_radius*2, plexi_thickness + 8, support_height], center=true);
				}
			}
		}

		for (x = [-1, 1]) {
			// Bolt hole
			translate([x*(width/2 - bolt_x), height/2 - end_corner_height*2, bolt_z]) {
				rotate([-90, 0, 0]) cylinder(height, d=bolt_diameter, center=false);
				rotate([0, -45, 0]) cube([bolt_diameter/2, height, bolt_diameter/2], center=false);
				bolt_depression = bolt_nut_thickness/2;
				rotate([90, 0, 0]) cylinder(bolt_nut_clearance, d=bolt_nut_width, center=false, $fn=6);
				mirror([0, 1, 0]) translate([-bolt_nut_width/2, 0, 0]) cube([bolt_nut_width, bolt_nut_clearance, bolt_nut_width], center=false);
			}

			// Overlap cutout
			translate([x*(width/2), height/2 + overlap_cutout_potition - end_corner_height/2, 0]) {
				cube([corner_overlap*2, end_corner_height, corner_overlap*4], center=true);
			}

			// Diagonal corner cut
			translate([x*(width/2), height/2 - end_corner_height*2, 0]) {
				mirror([0, 1, 0]) rotate([0, -45, 0]) cube([width, height, width], center=false);
			}
		}
	}
}

module plexi_hole() {
	hull() {
		translate([
			-plexi_width/2 + plexi_hole_offset_x + plexi_hole_diameter/2,
			-plexi_depth/2 + plexi_hole_offset_y + plexi_hole_diameter/2,
			0,
		]) {
			cylinder(plexi_thickness*2, d=plexi_hole_diameter, center=true);
			translate([0, plexi_hole_length - plexi_hole_diameter, 0]) cylinder(plexi_thickness*2, d=plexi_hole_diameter, center=true);
		}
	}
}

module plexi() {
	difference() {
		translate([0, 0, plexi_thickness/2]) {
			minkowski() {
				cube([
					plexi_width - plexi_corner_radius*2,
					plexi_depth - plexi_corner_radius*2,
					plexi_thickness/2,
				], center=true);
				cylinder(plexi_thickness/2, r=plexi_corner_radius, center=true);
			}
		}
		// plexi_hole();
		// mirror([0, 1, 0]) plexi_hole();
		// mirror([1, 0, 0]) plexi_hole();
		// rotate([0, 0, 180]) plexi_hole();
	}
}

module end_panel(wall_thickness) {
	difference() {
		panel(wall_thickness, side=false);
		translate([0, -height/2, panel_depth/2]) rotate([-90, 0, 0]) plexi();
	}
}

module side_panel(wall_thickness) {
	difference() {
		panel(wall_thickness, side=true);
		translate([0, -height/2, panel_width/2]) rotate([-90, 90, 0]) plexi();
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

module left_panel() {
	side_panel(4);
}

module right_panel() {
	wall_thickness = 4;
	switch_offset_x = panel_depth - 43;
	switch_offset_y = 8;
	difference() {
		side_panel(wall_thickness);
		translate([-panel_depth/2 + switch_offset_x, height/2 - switch_offset_y, 0]) {
			cube([12, 10, wall_thickness*3], center=true);
		}
	}
}

module panel_joint() {
	joint_inner = 8;
	joint_outer = 12;
	joint_length = 6;
	spacing = (joint_inner + joint_outer)/2;
	translate([-joint_length/2, 0, -corner_overlap])
	linear_extrude(height=corner_overlap*3)
	polygon([
		[0, height],
		[-panel_width, height],
		[-panel_width, -height],
		[0, -height],
		[0, -spacing - joint_inner/2],
		[joint_length, -spacing - joint_outer/2],
		[joint_length, -spacing + joint_outer/2],
		[0, -spacing + joint_inner/2],
		[0, spacing - joint_inner/2],
		[joint_length, spacing - joint_outer/2],
		[joint_length, spacing + joint_outer/2],
		[0, spacing + joint_inner/2],
	]);
}

module panel_split() {
  translate([0, -height, -corner_overlap*2])
  mirror([1, 0, 0])
  cube([panel_width, height*2, corner_overlap*4]);
}

back_panel();
translate([0, height*1.5, 0]) front_panel();
translate([0, height*-1.5, 0]) right_panel();
translate([0, height*-3, 0]) left_panel();
