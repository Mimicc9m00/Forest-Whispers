extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")

var olhando := 0.0

func _process(delta):

	if player == null:
		return

	var camera = player.get_node("Camera3D")

	var forward = -camera.global_transform.basis.z.normalized()

	var dir = (
		global_position -
		camera.global_position
	).normalized()

	var dot = forward.dot(dir)

	if dot > 0.98:

		olhando += delta

	else:

		olhando = 0

	if olhando >= 10.0:
	
	

		desaparecer()
	look_at(player.global_position)
	rotation.x = 0
	rotation.z = 0
		
func desaparecer():

	$AudioStreamPlayer3D.play()

	visible = false

	var tween = create_tween()

	tween.tween_property(
		self,
		"scale",
		Vector3.ONE * 1.1,
		0.1
	)

	tween.tween_property(
		self,
		"scale",
		Vector3.ZERO,
		0.15
	)

	await tween.finished

	queue_free()
