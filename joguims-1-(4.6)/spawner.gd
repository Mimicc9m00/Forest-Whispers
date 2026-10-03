extends Node3D

@export var enemy_scene: PackedScene
@export var raio := 12.0
@export var tempo_spawn := 1

@onready var player = get_tree().get_first_node_in_group("player")

var timer := 0.0

func _process(delta):
	if not player:
		return

	timer += delta

	if timer >= tempo_spawn:
		timer = 0.0
		spawn()
		
func spawn():
	var enemy = enemy_scene.instantiate()

	var angle = randf() * TAU
	var offset = Vector3(cos(angle), 0, sin(angle)) * raio

	enemy.global_position = player.global_position + offset

	get_tree().current_scene.add_child(enemy)
