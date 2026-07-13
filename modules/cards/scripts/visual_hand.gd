extends HBoxContainer

# Referencia a la logica de la baraja
@export var deck_logic: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck_logic.card_drawn.connect(on_card_drawn)

# Funcion para la señal card_drawn precarga una escena de tipo Card, 
# la inicializa con los datos de la carta robada y la añade al arbol de la escena
func on_card_drawn(card_data: CardData) -> void:
	var new_card = preload("res://modules/cards/scenes/card.tscn").instantiate()
	new_card.setup(card_data)
	add_child(new_card)
