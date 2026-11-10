extends CharacterBody3D

@onready var player_camera_pivot: Node3D = $PlayerCameraPivot
@onready var player_camera: Camera3D = $PlayerCameraPivot/PlayerCamera

const STAND_HEIGHT = 1.80
const WALK_SPEED = 2.0
const SENSITIViTY = 0.003
const JUMP_VELOCITY = 4.5

var jump_speed = WALK_SPEED
var direction
@export var speed: float = 3
var gravity = 9.8

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_speed = speed
	
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	direction = (player_camera_pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if is_on_floor():
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = direction.x * jump_speed
			velocity.z = direction.z * jump_speed
	elif is_on_floor():
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 8.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 8.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * jump_speed, delta * 5.0)
		velocity.z = lerp(velocity.z, direction.z * jump_speed, delta * 5.0)
	
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		player_camera_pivot.rotate_y(-event.relative.x * SENSITIViTY)
		player_camera.rotate_x(-event.relative.y * SENSITIViTY)
		player_camera.rotation.x = clamp(player_camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
