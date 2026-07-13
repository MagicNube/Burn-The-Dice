extends Node

signal card_drawn(card_data: CardData)

# Mano inicial temporal
@export var initialHand: Array[CardData]

# Baraja, mano y descartes o cartas usadas
var deck: Array[CardData] = []
var hand: Array[CardData] = []
var discards: Array[CardData] = []

func _ready() -> void:
	init_combat()
	
# Funcion para establecer la baraja como la inicial y mezclarla
func init_combat() -> void:
	deck = initialHand.duplicate()
	deck.shuffle()

# Funcion para la secuencia al finalizar turno
func finish_turn() -> void:
	# Comprobacion de las cartas a robar
	var cardsToDraw: int = 5 - hand.size()
	if cardsToDraw == 0:
		return
	
	for i in cardsToDraw:
		if deck.size() == 0:
			restart_deck()
		var drawn_card = deck.pop_front()
		hand.push_front(drawn_card)
		# Señal para enviar informacion de la carta robada a la interfaz
		card_drawn.emit(drawn_card)
	

# Funcion para reinciar la baraja
func restart_deck() -> void:
	deck = discards.duplicate()
	discards.clear()
	deck.shuffle()
	
	
