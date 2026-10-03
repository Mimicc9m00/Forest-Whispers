extends Node3D


@onready var som = $AudioStreamPlayer3D

func _ready():
	som.play()

func _process(delta):
	if not som.playing:
		som.play()
