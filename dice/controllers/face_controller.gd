extends Control

@export var custom_font: Font
var definition: DiceDefinition
var content: DiceContent
var text_size_ratio: float = 0.15 

func setup_faces(def: DiceDefinition, cont: DiceContent) -> void:
	definition = def
	content = cont
	queue_redraw() 

func _draw() -> void:
	print ("PINTANDO")
	var canvas_size = get_size()
	draw_rect(Rect2(Vector2.ZERO, canvas_size), Color.WHITE)
	
	if definition == null or content == null: return
	
	var font = custom_font if custom_font != null else ThemeDB.fallback_font
	var scaled_text_size = int(canvas_size.x * text_size_ratio)
	
	for geo in definition.geometry:
		var geo_id = geo.id
		
		if geo_id >= 0 and geo_id < content.faces.size():
			var face_data = content.faces[geo_id]
			
			if not face_data.values.is_empty():
				var pixel_center = geo.uv_center * canvas_size
				var transform = Transform2D(deg_to_rad(geo.rotation_deg), pixel_center)
				
				draw_set_transform_matrix(transform)
				
				var text_to_draw = face_data.values[0]
				var string_size = font.get_string_size(text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size)
				var ascent = font.get_ascent(scaled_text_size)
				var descent = font.get_descent(scaled_text_size)
				var offset = Vector2(-string_size.x / 2.0, (ascent - descent) / 2.0)
				
				draw_string(font, offset, text_to_draw, HORIZONTAL_ALIGNMENT_CENTER, -1, scaled_text_size, Color.BLACK)
				
	draw_set_transform_matrix(Transform2D.IDENTITY)
