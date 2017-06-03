
rj45_width = 16.2;
rj45_height = 14.2;
pcb_thickness = 1.2;

include <OpenSCAD_Parametric_Packaging_Script_v2-6k-WIMUv4_2013.scad>;
has_device = false;
device_xyz = [60, 32, 18];


holes = [//format [face_name, shape_name, shape_position[x_pos,y_pos,x_offs,y_offs,rotate,align], shape_size[depth,,,]]
	["S", "Rectangle", [0, 0, 0, pcb_thickness, 0, "inside"], [wall_t, rj45_width, rj45_height]],
	["E", "Rectangle", [0, 0, 0, pcb_thickness, 0, "inside"], [wall_t, rj45_width, rj45_height]],
	["W", "Rectangle", [0, 0, 0, pcb_thickness, 0, "inside"], [wall_t, rj45_width, rj45_height]],
	["T", "Ellipse",   [0, 9.1, 0, 0, 0, "inside"],             [wall_t, 3, 3, 16]],
];

text = [];
items = [];
posts = [ //format [face_name, shape_name shape_position[x_pos,y_pos,x_offs,y_offs,rotate,align], shape_size[depth,,,]]
];
