extends Node3D

@onready var som: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	randomize()
	loop_sons()

func loop_sons():
	while true:
		await get_tree().create_timer(randf_range(20.0, 40.0)).timeout

		som.pitch_scale = randf_range(0.9, 1.1)
		som.volume_db = randf_range(-2.0, 0.0)

		som.play()
