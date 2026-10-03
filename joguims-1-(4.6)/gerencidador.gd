extends Node

@onready var ambiente = $"../ambient"
@onready var respiracao = $"../SOM DE TENSAO"

func _ready():
	randomize()
	iniciar_eventos()

func iniciar_eventos():
	while true:
		await get_tree().create_timer(randf_range(90,240)).timeout
		evento_silencio()

func evento_silencio():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(ambiente, "volume_db", -80, 2.0)
	await tween.finished
	await get_tree().create_timer(10.0).timeout
	respiracao.play()
	await respiracao.finished
	var voltar = create_tween()
	voltar.set_parallel(true)
	voltar.tween_property(ambiente, "volume_db", 0, 2.5)
