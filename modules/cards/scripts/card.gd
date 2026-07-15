class_name Card
extends Control

@export var visual_texture: TextureRect

# Datos de la carta
var data: CardBlueprint

func _ready() -> void:
	pass

# Funcion para inicializar la carta
func setup(card_data: CardBlueprint) -> void:
	data = card_data
	visual_texture.texture = card_data.image 

func _get_drag_data(at_position: Vector2) -> Variant:
	# Creamos el wrapper vacío para el centro del ratón
	var preview_wrapper = Control.new()
	
	# Creamos la textura fantasma y la configuramos igual que la original
	var preview = TextureRect.new()
	preview.texture = data.image
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	preview.size = visual_texture.size 
	
	# La desplazamos para que el ratón quede en el medio
	preview.position = -preview.size / 2.0
	
	# Lo empaquetamos todo
	preview_wrapper.add_child(preview)
	set_drag_preview(preview_wrapper)
	
	# Volvemos translúcida la carta original en la mano
	modulate = Color(1, 1, 1, 0.5)
	
	return self

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		modulate = Color(1, 1, 1, 1)
