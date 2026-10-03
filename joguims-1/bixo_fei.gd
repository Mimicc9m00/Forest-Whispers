extends CharacterBody3D

@export var velocidade := 40

var evento_iniciado := false
var player
var perseguindo = false

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	var dir = (player.global_position - global_position).normalized()
	if player == null:
		return
	if perseguindo:
		velocity.x = dir.x * velocidade
		velocity.z = dir.z * velocidade
		look_at(player.global_position)
		move_and_slide()

		if global_position.distance_to(player.global_position) < 2.0:
			queue_free()
	var camera = player.get_node("Camera3D")
	var forward = -camera.global_transform.basis.z.normalized()
	dir = (
		global_position -
		camera.global_position
	).normalized()
	var dot = forward.dot(dir)
	if dot > 0.95 and not evento_iniciado:
		evento_iniciado = true
		$AudioStreamPlayer3D.play()
		var sorteio = randi_range(0, 100)
		if sorteio < 30:
			queue_free()
		elif sorteio < 70:
			await get_tree().create_timer(1.5).timeout
			perseguindo = true
		else:
			await get_tree().create_timer(3.0).timeout
			queue_free()
