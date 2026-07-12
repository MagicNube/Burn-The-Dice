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
	draw_rect(Rect2(Vector2.ZERO, get_size()), Color.WHITE)
	
	if definition == null: return
	
	var font = custom_font if custom_font != null else ThemeDB.fallback_font
	var scaled_text_size = int(get_size().x * 0.15)
	
	for geo in definition.geometry:
		var fixed_uv = Vector2(geo.uv_center.x, 1.0 - geo.uv_center.y)
		var pixel_center = fixed_uv * get_size()
		var base_transform = Transform2D(deg_to_rad(-geo.rotation_deg), pixel_center)
		
		var text_to_draw = str(geo.id)
		var string_size = font.get_string_size(text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size)
		var ascent = font.get_ascent(scaled_text_size)
		var descent = font.get_descent(scaled_text_size)
		var text_offset = Vector2(-string_size.x / 2.0, (ascent - descent) / 2.0)
		
		draw_set_transform_matrix(base_transform)
		draw_string(font, text_offset, text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size, Color.BLACK)
				
	draw_set_transform_matrix(Transform2D.IDENTITY)

func _redraw() -> void:
	var canvas_size = get_size()
	draw_rect(Rect2(Vector2.ZERO, canvas_size), Color.WHITE)
	
	if definition == null or content == null: return
	
	var font = custom_font if custom_font != null else ThemeDB.fallback_font
	
	var actual_text_ratio = text_size_ratio
	if die_type == DieType.Type.D4:
		actual_text_ratio = text_size_ratio * 0.7 
		
	var scaled_text_size = int(canvas_size.x * actual_text_ratio)
	var total_faces = content.faces.size()
	
	for geo in definition.geometry:
		var geo_id = geo.id
		
		if geo_id >= 0 and geo_id < total_faces:
			var face_data = content.faces[geo_id]
			
			if not face_data.values.is_empty():
				var fixed_uv = Vector2(geo.uv_center.x, 1.0 - geo.uv_center.y)
				var pixel_center = fixed_uv * canvas_size
				
				var base_transform = Transform2D(deg_to_rad(-geo.rotation_deg), pixel_center)
				
				if die_type == DieType.Type.D4:
					var radius = canvas_size.x * 0.05 
					
					var d4_indices: Array[int] = []
					for j in range(4):
						if j != geo_id:
							d4_indices.append(j)
					
					for i in range(3):
						var safe_index = d4_indices[i] % total_faces
						var text_to_draw = content.faces[safe_index].values[0]
						var string_size = font.get_string_size(text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size)
						var ascent = font.get_ascent(scaled_text_size)
						var descent = font.get_descent(scaled_text_size)
						var text_offset = Vector2(-string_size.x / 2.0, (ascent - descent) / 2.0)
						
						var angle = (i * (PI * 2.0 / 3.0)) - (PI / 2.0) 
						var pos_offset = Vector2(cos(angle), sin(angle)) * radius
						var text_rot = angle + (PI / 2.0)
						
						var local_transform = Transform2D(text_rot, pos_offset)
						draw_set_transform_matrix(base_transform * local_transform)
						draw_string(font, text_offset, text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size, Color.BLACK)
				else:
					var text_to_draw = face_data.values[0]
					var string_size = font.get_string_size(text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size)
					var ascent = font.get_ascent(scaled_text_size)
					var descent = font.get_descent(scaled_text_size)
					var text_offset = Vector2(-string_size.x / 2.0, (ascent - descent) / 2.0)
					
					draw_set_transform_matrix(base_transform)
					draw_string(font, text_offset, text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size, Color.BLACK)
				
	draw_set_transform_matrix(Transform2D.IDENTITY)
