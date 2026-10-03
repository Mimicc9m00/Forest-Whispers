extends Node3D

@export var cena_na_mao: PackedScene
var jogador_perto = false

func _ready():
	$Area3D.body_entered.connect(_ao_entrar)
	$Area3D.body_exited.connect(_ao_sair)
	add_to_group("lanterna")

func _ao_entrar(body):
	if body.is_in_group("player"):
		jogador_perto = true

func _ao_sair(body):
	if body.is_in_group("player"):
		jogador_perto = false

func _process(_delta):
	if jogador_perto and Input.is_action_just_pressed("interagir"):
		
		coletar()

func coletar():
	var jogador = get_tree().get_first_node_in_group("player")
	if jogador:
		jogador.equipar_lanterna()

	queue_free()
	
