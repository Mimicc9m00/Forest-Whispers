extends CharacterBody3D

@onready var camera_3d = $car/Camera3D

var SPEED = 60
const CAMERA_SENS = 0.003

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	add_to_group("inicio")
	
func _input(event):
	if event is InputEventMouseMotion:
		camera_3d.rotation.y -= event.relative.x * CAMERA_SENS
		camera_3d.rotation.x -= event.relative.y * CAMERA_SENS
		camera_3d.rotation.x = clamp(
			camera_3d.rotation.x,
			-0.5,
			1.2
		)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	var direction = -transform.basis.z.normalized()
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	move_and_slide()
	
	
