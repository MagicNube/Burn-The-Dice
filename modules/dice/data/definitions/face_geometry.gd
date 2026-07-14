class_name FaceGeometry
extends Resource

@export var id: int 
@export var uv_center: Vector2
@export var rotation_deg: float
@export var center_local: Vector3
@export var local_normal: Vector3
@export var uv_vertices: PackedVector2Array

func _init(center: Vector3, uv: Vector2, rot: float, normal: Vector3 = Vector3.ZERO,  uvs: PackedVector2Array = PackedVector2Array()) -> void:
	center_local = center
	uv_center = uv
	rotation_deg = rot
	local_normal = normal
	uv_vertices = uvs
