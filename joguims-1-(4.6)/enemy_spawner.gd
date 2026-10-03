extends Node3D

@export var inimigo_scene: PackedScene
@export var tempo_min := 60
@export var tempo_max := 240
@export var distancia_spawn := 20

var player

func _ready():
	player = get_tree().get_first_node_in_group("player")
	spawn_loop()

func spawn_loop():
	while true:
		await get_tree().create_timer(
			randf_range(tempo_min, tempo_max)
		).timeout

		spawn_inimigo()

func spawn_inimigo():
	if player == null:
		return

	var angulo = randf() * TAU

	var pos = player.global_position
	pos.x += cos(angulo) * distancia_spawn
	pos.z += sin(angulo) * distancia_spawn

	var inimigo = inimigo_scene.instantiate()
	inimigo.global_position = pos

	add_child(inimigo)
