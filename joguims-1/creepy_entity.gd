extends Node3D

@onready var audio_spawn = $AudioStreamPlayer3D

var player = null
var camera = null

var visto = false
var tempo_visto = 0.0

func _ready():
	player = get_tree().get_first_node_in_group("player")

	if player:
		camera = player.get_node("Camera3D")
		
func _process(delta):
	if not camera:
		return

	var space = get_world_3d().direct_space_state

	var query = PhysicsRayQueryParameters3D.create(
		camera.global_position,
		global_position
	)

	query.exclude = [self]

	var result = space.intersect_ray(query)

	# SE O RAYCAST ACERTAR DIRETO
	if result and result.collider == self:
		on_seen()

	if visto:
		tempo_visto += delta

		if tempo_visto >= 1.0:
			queue_free()

func on_seen():
	if visto:
		return

	visto = true
	tempo_visto = 0.0

	if audio_spawn:
		audio_spawn.play()

	get_tree().call_group("flash", "flash")
