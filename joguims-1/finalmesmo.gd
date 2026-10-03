extends Control

func _ready():
	await get_tree().create_timer(2.0).timeout
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://control.tscn")
