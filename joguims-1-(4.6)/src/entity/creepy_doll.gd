extends Node3D

@onready var camera = get_viewport().get_camera_3d()

var visto = false
var tempo_visto = 0.0

func _process(delta):
	if not camera:
		return

	
	var pos = global_transform.origin
	var dir = (pos - camera.global_transform.origin).normalized()

	var dot = camera.global_transform.basis.z.dot(dir)

	
	if dot < -0.3:
		
		var space = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(
			camera.global_transform.origin,
			pos
		)

		var result = space.intersect_ray(query)

		if result and result.collider == self:
			visto = true

	if visto:
		tempo_visto += delta

		if tempo_visto >= 1.0:
			queue_free()
