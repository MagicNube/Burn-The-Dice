extends Control

var mouse_position_x: float
var max_degrees: float = 180
var strength: float = 5.0

func _ready() -> void:
	mouse_position_x = get_global_mouse_position().x

func _process(delta: float) -> void:
	var new_mouse_position_x = get_global_mouse_position().x
	var velocity = new_mouse_position_x - mouse_position_x
	mouse_position_x = new_mouse_position_x
	
	var new_rotation_degrees = clamp(velocity * strength, -max_degrees, max_degrees)
	rotation_degrees = lerp(rotation_degrees, new_rotation_degrees, 15.0 * delta)
	
