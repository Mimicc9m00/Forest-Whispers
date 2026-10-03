extends ColorRect

@onready var mat = material as ShaderMaterial
var t = 0.0

func _process(delta):
	t += delta
	mat.set_shader_parameter("time", t)
