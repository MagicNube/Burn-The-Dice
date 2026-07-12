class_name FaceGeometry
extends Resource

@export var id: int 
@export var uv_center: Vector2
@export var rotation_deg: float
@export var center_local: Vector3

func _init(center: Vector3, uv: Vector2, rot: float) -> void:
	center_local = center
	uv_center = uv
	rotation_deg = rot
