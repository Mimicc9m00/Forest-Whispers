extends Node3D

@export var inimigo_scene: PackedScene

var player
var inimigo

func _ready():

	randomize()

	await get_tree().process_frame

	player = get_tree().get_first_node_in_group("player")

	if player == null:
		push_error("Player não encontrado!")
		return

	if inimigo_scene == null:
		push_error("Inimigo Scene não definida!")
		return

	inimigo = inimigo_scene.instantiate()

	get_tree().current_scene.add_child(inimigo)

	spawnar_atras()


func spawnar_atras():

	if inimigo == null:
		return

	var camera = player.get_node("Camera3D")

	var tras = camera.global_transform.basis.z.normalized()
	var direita = camera.global_transform.basis.x.normalized()

	var pos = player.global_position

	pos += tras * randf_range(12.0,18.0)
	pos += direita * randf_range(-4.0,4.0)

	pos.y = player.global_position.y

	inimigo.global_position = pos

	inimigo.player = player

	inimigo.visible = true

	if inimigo.has_node("CollisionShape3D"):
		inimigo.get_node("CollisionShape3D").disabled = false
