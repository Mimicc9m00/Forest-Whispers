extends Node3D

var jogador_perto := false
var aberta := false

func _ready():

	$Area3D.body_entered.connect(_entrou)
	$Area3D.body_exited.connect(_saiu)

func _entrou(body):

	if body.is_in_group("player"):
		jogador_perto = true

func _saiu(body):

	if body.is_in_group("player"):
		jogador_perto = false

func _process(delta):

	if aberta:
		return

	if jogador_perto and Input.is_action_just_pressed("interagir"):

		if Global.tem_chave:
			queue_free()
			

func abrir_porta():

	aberta = true

	$AudioStreamPlayer3D.play()

	$AnimationPlayer.play("abrir")
