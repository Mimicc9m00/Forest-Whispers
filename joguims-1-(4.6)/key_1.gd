extends Node3D

func _ready():
	$Area3D.body_entered.connect(_coletar)

func _coletar(body):

	if body.is_in_group("player"):

		Global.tem_chave = true

		$AudioStreamPlayer3D.play()

		visible = false

		$Area3D.monitoring = false

		await $AudioStreamPlayer3D.finished

		queue_free()
