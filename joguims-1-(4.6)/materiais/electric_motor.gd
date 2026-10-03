extends Node3D

var coletado := false

func coletar():

	if coletado:
		return

	coletado = true

	GameManager.pecas += 1

	print(
		"Peças: ",
		GameManager.pecas,
		"/",
		GameManager.TOTAL_PECAS
	)

	queue_free()
