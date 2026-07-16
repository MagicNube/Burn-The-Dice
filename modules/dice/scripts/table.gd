extends Node3D

@export var dice_pool: Array[DieBlueprint] = []

@export var d4_scene: PackedScene
@export var d6_scene: PackedScene
@export var d8_scene: PackedScene
@export var d10_scene: PackedScene

@export var spawn_height: float = 3.0
@export var impulse_min: Vector3 = Vector3(-2.0, 3.0, -2.0)
@export var impulse_max: Vector3 = Vector3(2.0, 6.0, 2.0)
@export var torque_min: Vector3 = Vector3(-4.0, -4.0, -4.0)
@export var torque_max: Vector3 = Vector3(4.0, 4.0, 4.0)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		roll_dice()

func roll_dice() -> void:
	if dice_pool.is_empty():
		return
		
	
	var random_blueprint = dice_pool[0]
	var selected_scene: PackedScene
	
	match random_blueprint.die_type:
		DieType.Type.D4:
			selected_scene = d4_scene
		DieType.Type.D6: 
			selected_scene = d6_scene
		DieType.Type.D8:
			selected_scene = d8_scene
		DieType.Type.D10:
			selected_scene = d10_scene
			
	if not selected_scene:
		return
	
	var new_dice = selected_scene.instantiate() as RigidBody3D
	add_child(new_dice)
	
	new_dice.global_position = Vector3(randf_range(-1.0, 1.0), spawn_height, randf_range(-1.0, 1.0))
	
	new_dice.initialize(random_blueprint)
	
	var random_impulse = Vector3(
		randf_range(impulse_min.x, impulse_max.x),
		randf_range(impulse_min.y, impulse_max.y),
		randf_range(impulse_min.z, impulse_max.z)
	)
	
	var random_torque = Vector3(
		randf_range(torque_min.x, torque_max.x),
		randf_range(torque_min.y, torque_max.y),
		randf_range(torque_min.z, torque_max.z)
	)
	
	new_dice.roll(random_impulse, random_torque)
