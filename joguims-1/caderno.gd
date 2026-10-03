extends Node3D

@export var numero_papel := 1

var jogador_perto := false
var coletado := false

func _ready():
	$Area3D.body_entered.connect(_entrou)
	$Area3D.body_exited.connect(_saiu)

func _entrou(body):
	if body.is_in_group("player"):
		jogador_perto = true

func _saiu(body):
	if body.is_in_group("player"):
		jogador_perto = false

func _process(_delta):
	if coletado:
		return
	if jogador_perto and Input.is_action_just_pressed("interagir"):
		coletar()

func coletar():

	coletado = true

	GameManager.coletar_pagina()

	Global.papel_atual = self

	Global.interface_papel.mostrar(numero_papel)

	visible = false
	$Area3D.monitoring = false
