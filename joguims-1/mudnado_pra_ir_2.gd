extends Area3D

@onready var som = $"../AudioStreamPlayer2"
@export_file("*.tscn") var proxima_cena: String
var ativado := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Colidiu com:", body.name)

	if ativado:
		return
	var node = body

	while node != null:
		if node.is_in_group("inicio"):
			som.play()
			return
		node = node.get_parent()

	if body.is_in_group("inicio"):
		ativado = true
		Global.cena_anterior = get_tree().current_scene.scene_file_path
		som.play()
