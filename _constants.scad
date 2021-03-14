$fn = 40;

// AllFightSticks 9.5" Button Panel - Stickless
// https://allfightsticks.com/collections/9-5-enclosures/products/9-5-button-panel?variant=21327143141455
panel_width = 228.2;
panel_depth = 171.5;
bolt_offset_x = 9.6; // distance to center of hole
bolt_offset_y = 6.5; // distance to center of hole
corner_radius = 5;

// FocusAttack Blank Plexi Cover for AllFightSticks 9.5" Solid Bottom Panel
// https://focusattack.com/blank-plexi-cover-for-allfightsticks-9-5-solid-bottom-panel/
plexi_width = 218;
plexi_depth = panel_depth;
plexi_thickness = 1.5;
plexi_hole_offset_x = 11.1; // distance to edge
plexi_hole_offset_y = 8.85; // distance to edge
plexi_hole_diameter = 8;
plexi_hole_length = 14;
plexi_corner_radius = 10;

// Sanwa SDM-18 buttons
// https://paradisearcadeshop.com/home/controls/buttons/sanwa/358-sanwa-sdm-series
button_diameter = 18;
button_tab_diameter = 24;
button_panel_thickness = 3;

// Brook Wireless Fighting Board
// https://www.brookaccessory.com/detail/41130595/
usb_panel_width = 26;
usb_panel_height = 31.2;
usb_panel_depth = 1.6;
usb_panel_hole_offset = 3.5; // from top/side edge
usb_panel_hole_diameter = 3; // M3
usb_panel_board_thickness = 1.65; // horizontal board
usb_panel_board_pos_y = 17.6; // from top
usb_panel_inner_width = 12; // USB connector housing
usb_panel_inner_height = 20; // USB connector housing/3.5mm jack

// M4 x 20mm internal hex button-head screw
bolt_diameter = 4;
bolt_length = 20;
bolt_nut_thickness = 3.2;
bolt_nut_width = 8; // outer
bolt_nut_clearance = 10;

height = usb_panel_height + plexi_thickness;
corner_overlap = 20;
end_corner_height = 8;
corner_chamfer = 16;
button_spacing = button_tab_diameter*1.2;
joint_offset = 0.5; // Accounts for extra length added by joint
