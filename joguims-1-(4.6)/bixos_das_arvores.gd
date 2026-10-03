extends CharacterBody3D

var player

var velocidade := 2.5
var tempo_olhando := 0.0
var desaparecendo := false

var tempo_reaparecer := 120
const TEMPO_MINIMO := 3.0
const REDUCAO := 3

func _ready():

	randomize()


func _physics_process(delta):

	if player == null:
		return

	if desaparecendo:
		return

	var dir = player.global_position - global_position
	dir.y = 0
	dir = dir.normalized()

	velocity.x = dir.x * velocidade
	velocity.z = dir.z * velocidade

	move_and_slide()

	look_at(
		Vector3(
			player.global_position.x,
			global_position.y,
			player.global_position.z
		),
		Vector3.UP
	)

	if global_position.distance_to(player.global_position) < 2.0:
		sumir()
		return

	var camera = player.get_node("Camera3D")

	var frente = -camera.global_transform.basis.z.normalized()

	var direcao = (
		global_position -
		camera.global_position
	).normalized()

	if frente.dot(direcao) > 0.97:

		tempo_olhando += delta

		if tempo_olhando >= 1.5:
			sumir()

	else:

		tempo_olhando = 0.0


func sumir():

	if desaparecendo:
		return

	desaparecendo = true

	visible = false

	if has_node("CollisionShape3D"):
		$CollisionShape3D.disabled = true

	if has_node("AudioStreamPlayer3D"):
		$AudioStreamPlayer3D.stop()

	await get_tree().create_timer(tempo_reaparecer).timeout

	reaparecer()

	tempo_reaparecer = max(
		TEMPO_MINIMO,
		tempo_reaparecer - REDUCAO
	)


func reaparecer():

	if player == null:
		return

	var camera = player.get_node("Camera3D")

	var tras = camera.global_transform.basis.z.normalized()
	var direita = camera.global_transform.basis.x.normalized()

	var pos = player.global_position

	pos += tras * randf_range(12.0,18.0)
	pos += direita * randf_range(-4.0,4.0)

	pos.y = player.global_position.y

	global_position = pos

	look_at(
		Vector3(
			player.global_position.x,
			global_position.y,
			player.global_position.z
		),
		Vector3.UP
	)

	visible = true

	if has_node("CollisionShape3D"):
		$CollisionShape3D.disabled = false

	if has_node("AudioStreamPlayer3D"):
		$AudioStreamPlayer3D.play()

	velocidade = min(
		velocidade + 0.4,
		7.0
	)

	tempo_olhando = 0.0
	desaparecendo = false
