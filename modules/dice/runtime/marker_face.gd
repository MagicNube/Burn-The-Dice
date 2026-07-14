class_name MarkerFace
extends Marker3D

@export var id: int = 0
var local_normal: Vector3 = Vector3.ZERO

func get_world_normal() -> Vector3:
	return global_transform.basis * local_normal
