class_name Card
extends Control

# Variables de las partes de la carta
@export var visuals: Control
@export var background: TextureRect
@export var image: TextureRect
@export var effect_description: RichTextLabel
@export var card_name: Label
@export var element_icon: TextureRect
@export var elemental_cost: RichTextLabel

# Datos de la carta
var card_instance: CardInstance
# Variables de la posicion y rotacion en abanico
var base_rotation: float = 0.0
var base_position_y: float = 0.0
# Variable para las animaciones de las cartas
var tween: Tween

func _ready() -> void:
	pivot_offset = size / 2.0
	visuals.pivot_offset = size / 2.0
	
	# Conexiones para señales de raton al entrar en una carta y al salir
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

## Inicializa la carta con sus datos y actualiza su aspecto visual.
func setup(new_instance: CardInstance) -> void:
	card_instance = new_instance
	image.texture = card_instance.blueprint.image
	card_name.text = card_instance.blueprint.name
	effect_description.text = card_instance.blueprint.effect_description
	# NOTA: Ahora lee del blueprint. Si en el futuro se añade current_cost al CardInstance 
	# para que las cartas cambien de coste, hay que cambiar esto a: card_instance.current_cost
	elemental_cost.text = str(card_instance.blueprint.elemental_cost)
	
	match card_instance.blueprint.element:
		Element.Type.FIRE:
			background.texture = preload("res://modules/cards/assets/artwork/FireCard.png")
			element_icon.texture = preload("res://modules/cards/assets/artwork/FlameIcon.png")
		Element.Type.WATER:
			background.texture = preload("res://modules/cards/assets/artwork/WaterCard.png")
			element_icon.texture = preload("res://modules/cards/assets/artwork/WaterIcon.png")

## Funcion para carta fantasma al agarrar una carta de la baraja
## Devuelve la referencia a Card
func _get_drag_data(at_position: Vector2) -> Variant:
	# Reseteamos transformacion de abanico
	reset_transform()
	
	# Creamos el wrapper vacío para el centro del ratón y asignamos script de balanceo
	var preview_wrapper = Control.new()
	preview_wrapper.set_script(preload("res://modules/cards/scripts/drag_preview.gd"))
	
	# Creamos la textura fantasma y la configuramos igual que la original
	var preview = visuals.duplicate()
	preview.rotation = 0
	preview.scale = Vector2(1, 1)
	
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
	visuals.z_index = 0
	
	# Comprobamos si hay animacion existente y la matamos
	if tween && tween.is_valid():
		tween.kill()
	
	# Creamos nueva animacion y la configuramos
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(visuals, "rotation_degrees", base_rotation, 0.2)
	tween.tween_property(visuals, "position:y", base_position_y, 0.2)
	tween.tween_property(visuals, "scale", Vector2(1, 1), 0.2)

## Funcion para animacion hover de la carta en la mano
func _on_mouse_entered() -> void:
	visuals.z_index = 10
	
	# Comprobamos si hay animacion existente y la matamos
	if tween && tween.is_valid():
		tween.kill()
	
	# Creamos nueva animacion y la configuramos
	tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(visuals, "rotation_degrees", 0.0, 0.15)
	tween.tween_property(visuals, "position:y", base_position_y - 60, 0.15)
	tween.tween_property(visuals, "scale", Vector2(1.2, 1.2), 0.15)
	
## Funcion para desactivar la animacion hover
func _on_mouse_exited() -> void:
	reset_transform()

## Funcion que comprueba si se ha dejado de agarrar la carta y devuelve el aspecto visual a la carta original
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		modulate = Color(1, 1, 1, 1)
