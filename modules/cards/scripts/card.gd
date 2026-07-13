class_name Card
extends TextureRect

# Datos de la carta
var data: CardData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(card_data: CardData) -> void:
	data = card_data
	texture = card_data.image

func _get_drag_data(at_position: Vector2) -> Variant:
	# Creamos envoltorio de la carta para que se centre al cursor al agarrar
	var preview_wrapper = Control.new()
	
	# Creamos carta fantasma mientras se agarra la carta con configuración igual a la real
	var preview = TextureRect.new()
	preview.texture = data.image
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	preview.size = Vector2(120.0, 180.0)
	
	# Centramos en el cursor
	preview.position = -preview.size / 2.0
	
	# Añadimos la carta fantasma al envoltorio
	preview_wrapper.add_child(preview)
	
	# Mostramos el envoltorio con la carta fantasma, asi la carta se vera centrada en el raton
	set_drag_preview(preview_wrapper)
	
	# Hacemos la carta original translucida
	modulate = Color(1, 1, 1, 0.5)
	
	# Devolvemos los datos reales
	return self

# Funcion que recibe automaticamente todas las señales de la carta
# Comprueba si la notificacion es que la carta se ha soltado y en ese caso restaura la opacidad original
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		modulate = Color(1, 1, 1, 1)
