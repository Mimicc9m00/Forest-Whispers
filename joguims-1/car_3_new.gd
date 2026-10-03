extends Node3D

@export_file("*.tscn")
var cena_final := "res://final.tscn"

var jogador_perto := false

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

	if !jogador_perto:
		return

	if Input.is_action_just_pressed("interagir"):

		if GameManager.pecas >= GameManager.TOTAL_PECAS:

			print("Carro ligado!")

			get_tree().change_scene_to_file(cena_final)

		else:

			print(
				"Faltam ",
				GameManager.TOTAL_PECAS - GameManager.pecas,
				" peças."
			)
