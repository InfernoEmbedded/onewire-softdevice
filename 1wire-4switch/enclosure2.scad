
rj45_width = 15.2;
rj45_height = 14.8;
pcb_thickness = 1.2;
leg_height = 2.5;
pcb_length = 71.628;
pcb_mains_side_buffer = 30;

pcb_surface = pcb_thickness + leg_height;

4port_width = 20.5;
4port_height = 8;

cable_entry_width = 40;
cable_entry_height = 20;

lip_thickness = 1;

include <OpenSCAD_Parametric_Packaging_Script_v2-6k-WIMUv4_2013.scad>;
has_device = false;
device_xyz = [pcb_length + pcb_mains_side_buffer, 59.436, 21 + pcb_thickness + leg_height];
clearance_xyz = [0, 0, 0];
lip_h = 3;
top_bottom_ratio = 0.6;

// Ensure the lid locks on tightly
locking_feature_max_h=lip_fit * 2;

holes = [//format [face_name, shape_name, shape_position[x_pos,y_pos,x_offs,y_offs,rotate,align], shape_size[depth,,,]]
	["N", "Rectangle", [0, 0, (device_xyz[0]) / 2 - 4port_width / 2 - 3, device_xyz[2] / -2 + 4port_height / 2 + pcb_surface, 0, "inside"], [wall_t, 4port_width, 4port_height]],
	["S", "Rectangle", [0, 0, (device_xyz[0]) / 2 - 4port_width / 2 - 5.08, device_xyz[2] / -2 + 4port_height / 2 + pcb_surface, 0, "inside"], [wall_t, 4port_width, 4port_height]],
	["S", "Rectangle", [0, 0, (device_xyz[0]) / 2 - 4port_width / 2 - 27.94, device_xyz[2] / -2 + 4port_height / 2 + pcb_surface, 0, "inside"], [wall_t, 4port_width, 4port_height]],
	["E", "Rectangle", [0, 0, 0, 0, 0, "inside"], [wall_t, cable_entry_width, cable_entry_height]],
	["W", "Rectangle", [0, 0, rj45_width / -2 - 1.35, device_xyz[2] / -2 + 4port_height / 2 + pcb_surface, 0, "inside"], [wall_t, rj45_width, rj45_height]],
	["W", "Rectangle", [0, 0, rj45_width / 2 + 1.35, device_xyz[2] / -2 + 4port_height / 2 + pcb_surface, 0, "inside"], [wall_t, rj45_width, rj45_height]],
,
];

text = [];
items = [];
posts = [ //format [face_name, shape_name shape_position[x_pos,y_pos,x_offs,y_offs,rotate,align], shape_size[depth,,,]]
// Bottom lip
	["W", "Rectangle", [0, 0, 0, device_xyz[2] / -2 + leg_height / 2, 0, "inside"], [lip_thickness, device_xyz[1], leg_height]],
	["N", "Rectangle", [0, 0, pcb_mains_side_buffer / 2, device_xyz[2] / -2 + leg_height / 2, 0, "inside"], [lip_thickness, pcb_length, leg_height]],
	["S", "Rectangle", [0, 0, pcb_mains_side_buffer / 2, device_xyz[2] / -2 + leg_height / 2, 0, "inside"], [lip_thickness, pcb_length, leg_height]],
	["B", "Rectangle", [0, 0, device_xyz[0] / -2 + pcb_length, 0, 0, "inside"], [leg_height, lip_thickness, device_xyz[1]]],
	["B", "Rectangle", [0, 0, device_xyz[0] / -2 + pcb_length + lip_thickness, 0, 0, "inside"], [leg_height + pcb_thickness * 2, lip_thickness, device_xyz[1]]],

// Wall side clips
	["W", "Rectangle", [0, 0, 0, device_xyz[2] / -2 + leg_height / 2 + pcb_thickness + leg_height, 0, "inside"], [lip_thickness, 2, leg_height]],
	["W", "Rectangle", [0, 0,  device_xyz[1] / 2 - 1.5, device_xyz[2] / -2 + leg_height / 2 + pcb_thickness + leg_height,0, "inside"], [lip_thickness, 3, leg_height]],
	["W", "Rectangle", [0, 0,  device_xyz[1] / -2 + 1.5, device_xyz[2] / -2 + leg_height / 2 + pcb_thickness + leg_height,0, "inside"], [lip_thickness, 3, leg_height]],
	["N", "Rectangle", [0, 0,  0, device_xyz[2] / -2 + leg_height / 2 + pcb_thickness + leg_height,0, "inside"], [lip_thickness / 2, 3, leg_height]],
	["S", "Rectangle", [0, 0,  0, device_xyz[2] / -2 + leg_height / 2 + pcb_thickness + leg_height,0, "inside"], [lip_thickness / 2, 3, leg_height]],

	
];
