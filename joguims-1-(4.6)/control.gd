extends Control



func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://inicio.tscn")


func _on_creditos_pressed() -> void:
	pass 


func _on_sair_pressed() -> void:
	get_tree().quit()
