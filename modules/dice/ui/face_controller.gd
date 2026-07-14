extends Control

@export var custom_font: Font
var definition: DiceDefinition
var content: DiceContent
var die_type: DieType.Type
var text_size_ratio: float = 0.15 

func setup_faces(def: DiceDefinition, cont: DiceContent, p_type: DieType.Type) -> void:
	definition = def
	content = cont
	die_type = p_type
	queue_redraw()

func _draw() -> void:
	var canvas_size = get_size()
	draw_rect(Rect2(Vector2.ZERO, canvas_size), Color.WHITE)
	
	if definition == null or content == null: return
	
	var font = custom_font if custom_font != null else ThemeDB.fallback_font
	var actual_text_ratio = text_size_ratio
	
	if die_type == DieType.Type.D4:
		actual_text_ratio = text_size_ratio * 0.5 
		
	var scaled_text_size = int(canvas_size.x * actual_text_ratio)
	var total_faces = content.faces.size()
	
	for geo in definition.geometry:
		var geo_id = geo.id
		
		if geo_id >= 0 and geo_id < total_faces:
			var face_data = content.faces[geo_id]
			
			if not face_data.values.is_empty():
				if die_type == DieType.Type.D4 and geo.uv_vertices.size() == 3:
					var a_uv = Vector2(geo.uv_vertices[0].x, 1.0 - geo.uv_vertices[0].y) * canvas_size
					var b_uv = Vector2(geo.uv_vertices[1].x, 1.0 - geo.uv_vertices[1].y) * canvas_size
					var c_uv = Vector2(geo.uv_vertices[2].x, 1.0 - geo.uv_vertices[2].y) * canvas_size
					
					var centroid = (a_uv + b_uv + c_uv) / 3.0
					var lerp_factor = 0.65
					
					var pos_a = centroid.lerp(a_uv, lerp_factor)
					var pos_b = centroid.lerp(b_uv, lerp_factor)
					var pos_c = centroid.lerp(c_uv, lerp_factor)
					
					var indices = D4Layout.LAYOUT[geo_id]
					var positions = [pos_a, pos_b, pos_c]
					var rotations = [
						(a_uv - centroid).angle() + (PI / 2.0),
						(b_uv - centroid).angle() + (PI / 2.0),
						(c_uv - centroid).angle() + (PI / 2.0)
					]
					
					for i in range(3):
						var safe_index = indices[i] % total_faces
						var text_to_draw = content.faces[safe_index].values[0]
						
						var string_size = font.get_string_size(text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size)
						var ascent = font.get_ascent(scaled_text_size)
						var descent = font.get_descent(scaled_text_size)
						var text_offset = Vector2(-string_size.x / 2.0, (ascent - descent) / 2.0)
						
						var transform = Transform2D(rotations[i], positions[i])
						draw_set_transform_matrix(transform)
						draw_string(font, text_offset, text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size, Color.BLACK)
				else:
					var fixed_uv = Vector2(geo.uv_center.x, 1.0 - geo.uv_center.y)
					var pixel_center = fixed_uv * canvas_size
					var base_transform = Transform2D(deg_to_rad(-geo.rotation_deg), pixel_center)
					
					var text_to_draw = face_data.values[0]
					var string_size = font.get_string_size(text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size)
					var ascent = font.get_ascent(scaled_text_size)
					var descent = font.get_descent(scaled_text_size)
					var text_offset = Vector2(-string_size.x / 2.0, (ascent - descent) / 2.0)
					
					draw_set_transform_matrix(base_transform)
					draw_string(font, text_offset, text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size, Color.BLACK)
					
	draw_set_transform_matrix(Transform2D.IDENTITY)
