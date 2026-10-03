extends CanvasLayer

@onready var som = $AudioStreamPlayer
@onready var papel1 = $texto1
@onready var papel2 = $texto2
@onready var papel3 = $texto3
@onready var papel4 = $texto4
@onready var papel5 = $texto5
@onready var papel6 = $texto6
@onready var papel7 = $texto7

var pode_fechar := false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.interface_papel = self
	esconder_todos()

func mostrar(numero):
	esconder_todos()
	match numero:
		1:
			papel1.visible = true
		2:
			papel2.visible = true
		3:
			papel3.visible = true
		4:
			papel4.visible = true
		5:
			papel5.visible = true
		6:
			papel6.visible = true
		7:
			papel7.visible = true
	som.play()
	get_tree().paused = true
	pode_fechar = false
	await get_tree().create_timer(0.2, true).timeout
	pode_fechar = true
	
func esconder():
	esconder_todos()
	get_tree().paused = false
	if Global.papel_atual:
		Global.papel_atual.queue_free()
		Global.papel_atual = null

func esconder_todos():
	papel1.visible = false
	papel2.visible = false
	papel3.visible = false
	papel4.visible = false
	papel5.visible = false
	papel6.visible = false
	papel7.visible = false
	

func _input(event):
	if not pode_fechar:
		return
	if not algum_papel_aberto():
		return
	if event.is_action_pressed("interagir") \
	or event.is_action_pressed("ui_cancel"):
		esconder()

func algum_papel_aberto():
	return papel1.visible \
	or papel2.visible \
	or papel3.visible \
	or papel4.visible \
	or papel5.visible \
	or papel6.visible \
	or papel7.visible
