extends Area3D

@export_file("*.tscn") var proxima_cena: String
var ativado := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Colidiu com:", body.name)

	if ativado:
		return

	if body.is_in_group("inicio"):
		get_tree().change_scene_to_file("res://inicio123.tscn")
	
