extends Node3D

@onready var sol = $DirectionalLight3D

@export var energia_min := 0.0
@export var energia_max := 1.0
@export var duracao_dia := 240
@onready var ambiente = $"../WorldEnvironment"


var tempo := 0.0

func _process(delta):
	
	tempo += delta / duracao_dia * TAU

	var base = (sin(tempo) + 1.0) / 2.0

	var t = pow(base, 2.0)

	sol.light_energy = lerp(energia_min, energia_max, t)

	if sol.light_energy <= 0.01:
		sol.light_color = Color.BLACK
	else:
		sol.light_color = Color(1.0, 0.95, 0.8)


	
	
