extends Node3D

var jogador_perto := false
var coletada := false

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

	if coletada:
		return

	if jogador_perto and Input.is_action_just_pressed("interagir"):

		coletar()

func coletar():

	coletada = true

	GameManager.pecas += 1

	print(
		"Peças coletadas: ",
		GameManager.pecas,
		"/",
		GameManager.TOTAL_PECAS
	)

	queue_free()
