extends CanvasLayer

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			continuar()
		else:
			pausar()

func pausar():
	visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func continuar():
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _on_continue_pressed():
	continuar()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://control.tscn")

func _on_reset_pressed()-> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://node_3d.tscn")
