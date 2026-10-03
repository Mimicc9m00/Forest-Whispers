extends Area3D

@export_file("*.tscn") var proxima_cena: String
@onready var som: AudioStreamPlayer = $AudioStreamPlayer

var ativado := false
var som_tocado := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Colidiu com:", body.name)


	if body.is_in_group("player") and not som_tocado:
		som.play()
		som_tocado = true

	if ativado:
		return

	
	var node = body
	while node != null:
		if node.is_in_group("arvore"):
			node.queue_free()
			return
		node = node.get_parent()


	if body.is_in_group("ponte"):
		ativado = true
		Global.cena_anterior = get_tree().current_scene.scene_file_path
		queue_free()
