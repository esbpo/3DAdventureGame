extends MeshInstance3D

@export var sequence: Array[int] = [0,0,0,0]

func callback(_node):
	if ($"../Button1".current_colour == sequence[0] and 
	$"../Button2".current_colour == sequence[1] and
	$"../Button3".current_colour == sequence[2] and
	$"../Button4".current_colour == sequence[3]):
		print("You Win")
		material_override.albedo_color = Color(0.0, 1.0, 0.0, 1.0)
	else:
		print("Try again")
		material_override.albedo_color = Color(1,0,0,1)
