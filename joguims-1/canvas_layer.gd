extends CanvasLayer

@onready var fundo = $ColorRect
@onready var texto = $RichTextLabel

func _ready():
	visible = false
	Global.interface_papel = self

func mostrar(mensagem):
	visible = true
	texto.text = mensagem

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	if visible and event.is_action_pressed("ui_cancel"):
		visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
