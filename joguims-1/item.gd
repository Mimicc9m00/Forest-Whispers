extends Node3D

var jogador_perto = false

func _ready():
	$Area3D.body_entered.connect(_ao_entrar)
	$Area3D.body_exited.connect(_ao_sair)

func _ao_entrar(body):
	if body.is_in_group("player"):
		jogador_perto = true

func _ao_sair(body):
	if body.is_in_group("player"):
		jogador_perto = false

func _process(delta):
	if jogador_perto and Input.is_action_just_pressed("interagir"):
		coletar()

func coletar():
	print("Item coletado!")
	queue_free() # apaga o item da cena
