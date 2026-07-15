extends HBoxContainer

# Referencia a la logica de la baraja
@export var deck_logic: Node

# Angulo base que se añade a las cartas
var base_angle: float = 5.0

# Conectamos señales de creacion de cartas y poner las cartas en abanico
func _ready() -> void:
	deck_logic.card_drawn.connect(on_card_drawn)
	child_order_changed.connect(recalculate_fan)

## Funcion para la señal card_drawn precarga una escena de tipo Card, la inicializa con los datos de la carta robada y la añade al arbol de la escena
func on_card_drawn(card_data: CardBlueprint) -> void:
	var new_card = preload("res://modules/cards/scenes/card.tscn").instantiate()
	new_card.setup(card_data)
	add_child(new_card)

## Funcion que calcula la inclinacion y posicion en y de las cartas de la mano para ponerlas en abanico
func recalculate_fan() -> void:
	# Obtenemos la referencia a las cartas y el total de cartas
	var cards = get_children()
	var total_cards = cards.size()
	# Comprobacion de division entre 0
	if total_cards == 0:
		return
	# Calculamos indice del centro
	var center_index = (total_cards - 1) / 2.0
	var vertical_drop = 5.0
	# Calculamos rotacion y posicion vertical por carta y lo asignamos a las variables de las cartas y reseteamos su transformacion
	for i in total_cards:
		var distance_from_center: float =  i - center_index
		cards[i].base_rotation = distance_from_center * base_angle
		cards[i].base_position_y = (distance_from_center * distance_from_center) * vertical_drop
		cards[i].reset_transform()
