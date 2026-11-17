extends MeshInstance3D

var material: StandardMaterial3D = StandardMaterial3D.new()
var current_colour: int = 0
var colours: Array[Color] = [Color(1.0, 0.0, 0.0, 1.0), Color(0.0, 1.0, 0.0, 1.0), Color(0.0, 0.0, 1.0, 1.0), Color(1.0, 1.0, 0.0, 1.0)]

func _ready() -> void:
	material.albedo_color = colours[current_colour]
	material_override = material

func callback(_node):
	current_colour = wrapi(current_colour + 1, 0, 4)
	material.albedo_color = colours[current_colour]
	material_override = material
