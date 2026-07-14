extends RigidBody3D

@export var mesh_instance: MeshInstance3D
@export var sub_viewport: SubViewport
@export var face_controller: Control
@export var definition: DiceDefinition
@export var content: DiceContent

var _is_rolling: bool = false
var _markers: Array[MarkerFace] = []

func _ready() -> void:
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	sleeping_state_changed.connect(_on_sleeping_state_changed)

func initialize(blueprint: DieBlueprint) -> void:
	var die_type: DieType.Type = blueprint.die_type
	definition = DiceRegistry.get_definition(die_type)
	content = DiceRegistry.create_single_value_content(blueprint.get_faces())
	
	if definition != null:
		for geo in definition.geometry:
			var marker = MarkerFace.new()
			marker.id = geo.id
			marker.position = Vector3(geo.center_local.x, geo.center_local.z, -geo.center_local.y)
			marker.local_normal = Vector3(geo.local_normal.x, geo.local_normal.z, -geo.local_normal.y).normalized()
			
			var debug_mesh = MeshInstance3D.new()
			var sphere = SphereMesh.new()
			sphere.radius = 0.25
			sphere.height = 0.1
			debug_mesh.mesh = sphere
			
			var material := StandardMaterial3D.new()
			match geo.id:
				0:
					material.albedo_color = Color.RED
				1:
					material.albedo_color = Color.BLUE
				2:
					material.albedo_color = Color.GREEN
				3:
					material.albedo_color = Color.YELLOW
					
			debug_mesh.material_override = material
			marker.add_child(debug_mesh)
			add_child(marker)
			_markers.append(marker)
			
	if definition != null and content != null:
		face_controller.setup_faces(definition, content, die_type)
		
	var dynamic_material = StandardMaterial3D.new()
	dynamic_material.roughness = 0.2
	dynamic_material.metallic = 0.0
	dynamic_material.albedo_texture = sub_viewport.get_texture()
	mesh_instance.set_surface_override_material(0, dynamic_material)

func _input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		roll(Vector3(randf_range(-5, 5), 5, randf_range(-5, 5)), Vector3(randf_range(-15, 15), randf_range(-15, 15), randf_range(-15, 15)))

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
