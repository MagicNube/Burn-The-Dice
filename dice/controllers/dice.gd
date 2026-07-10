extends RigidBody3D

@export var mesh_instance: MeshInstance3D
@export var sub_viewport: SubViewport
@export var face_controller: Control
@export var definition: DiceDefinition
@export var content: DiceContent

var _is_rolling: bool = false
var _markers: Array[MarkerFace] = []

func _ready() -> void:
	definition = DiceRegistry.get_definition("d6")
	content = DiceRegistry.create_single_value_content([2, 1, 4, 3, 5, 6])
	
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	
	if definition != null:
		for geo in definition.geometry:
			var marker = MarkerFace.new()
			marker.id = geo.id
			marker.position = Vector3(geo.center_local.x, geo.center_local.z, -geo.center_local.y)
			add_child(marker)
			_markers.append(marker)
			
	if definition != null and content != null:
		face_controller.setup_faces(definition, content)
		
	var dynamic_material = StandardMaterial3D.new()
	dynamic_material.roughness = 0.2
	dynamic_material.metallic = 0.0
	dynamic_material.albedo_texture = sub_viewport.get_texture()
	mesh_instance.set_surface_override_material(0, dynamic_material)
	
	sleeping_state_changed.connect(_on_sleeping_state_changed)

func _input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		roll(Vector3(randf_range(-2, 2), 10, randf_range(-2, 2)), Vector3(randf_range(-5, 5), randf_range(-5, 5), randf_range(-5, 5)))

func roll(impulse: Vector3, torque: Vector3) -> void:
	_is_rolling = true
	sleeping = false
	apply_central_impulse(impulse)
	apply_torque_impulse(torque)

func _on_sleeping_state_changed() -> void:
	if sleeping and _is_rolling:
		_is_rolling = false
		if definition == null or content == null: return
		
		var winner_id = definition.get_winning_face_id(_markers)
		if winner_id != -1 and winner_id < content.faces.size():
			var result = content.faces[winner_id].values
			print("🎲 Resultado ID ", winner_id, ": ", result)
