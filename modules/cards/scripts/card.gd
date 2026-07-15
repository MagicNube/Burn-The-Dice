class_name Card
extends Control

@export var visual_texture: TextureRect

# Datos de la carta
var card_data: CardBlueprint
# Variables de la posicion y rotacion en abanico
var base_rotation: float = 0.0
var base_position_y: float = 0.0
# Variable para las animaciones de las cartas
var tween: Tween

func _ready() -> void:
	# Conexiones para señales de raton al entrar en una carta y al salir
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

## Inicializa la carta con sus datos y actualiza su aspecto visual.
func setup(data: CardBlueprint) -> void:
	card_data = data
	visual_texture.texture = card_data.image 

## Funcion para carta fantasma al agarrar una carta de la baraja
## Devuelve la referencia a Card
func _get_drag_data(at_position: Vector2) -> Variant:
	# Reseteamos transformacion de abanico
	reset_transform()
	
	# Creamos el wrapper vacío para el centro del ratón y asignamos script de balanceo
	var preview_wrapper = Control.new()
	preview_wrapper.set_script(preload("res://modules/cards/scripts/drag_preview.gd"))
	
	# Creamos la textura fantasma y la configuramos igual que la original
	var preview = TextureRect.new()
	preview.texture = card_data.image
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	preview.size = visual_texture.size 
	
	# La desplazamos para que el ratón quede en el medio
	preview.position = -preview.size / 2.0
	
	# Lo empaquetamos todo
	preview_wrapper.add_child(preview)
	set_drag_preview(preview_wrapper)
	
	# Hacemos transparente la carta original
	modulate = Color(1, 1, 1, 0)
	
	return self

## Funcion que resetea la transformacion que tenga la carta
func reset_transform() -> void:
	visual_texture.z_index = 0
	
	# Comprobamos si hay animacion existente y la matamos
	if tween && tween.is_valid():
		tween.kill()
	
	# Creamos nueva animacion y la configuramos
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(visual_texture, "rotation_degrees", base_rotation, 0.2)
	tween.tween_property(visual_texture, "position:y", base_position_y, 0.2)
	tween.tween_property(visual_texture, "scale", Vector2(1, 1), 0.2)

## Funcion para animacion hover de la carta en la mano
func _on_mouse_entered() -> void:
	visual_texture.z_index = 10
	
	# Comprobamos si hay animacion existente y la matamos
	if tween && tween.is_valid():
		tween.kill()
	
	# Creamos nueva animacion y la configuramos
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(visual_texture, "rotation_degrees", 0.0, 0.15)
	tween.tween_property(visual_texture, "position:y", base_position_y - 60, 0.15)
	tween.tween_property(visual_texture, "scale", Vector2(1.2, 1.2), 0.15)
	
## Funcion para desactivar la animacion hover
func _on_mouse_exited() -> void:
	reset_transform()

## Funcion que comprueba si se ha dejado de agarrar la carta y devuelve el aspecto visual a la carta original
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		modulate = Color(1, 1, 1, 1)
