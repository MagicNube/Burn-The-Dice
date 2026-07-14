extends Node

signal card_drawn(card_data: CardBlueprint)
signal deck_size_changed(amount: int)
signal discards_size_changed(amount: int)

# Mano inicial temporal
@export var initial_hand: Array[CardBlueprint]

# Baraja, mano y descartes o cartas usadas
var deck: Array[CardBlueprint] = []
var hand: Array[CardBlueprint] = []
var discards: Array[CardBlueprint] = []

func _ready() -> void:
	# Llamamos con deferred para esperar a que toda la escena este cargada y no se emitan señales antes de tiempo
	call_deferred("init_combat")
	CombatBus.card_consumed.connect(use_card)
	
# Funcion para establecer la baraja como la inicial y mezclarla
func init_combat() -> void:
	deck = initial_hand.duplicate()
	# Este bucle es para hacer que cada carta sea unica aunque visualmente sean iguales con un ID unico
	for i in range(deck.size()):
		deck[i] = deck[i].duplicate()
	
	# Señal para actualizar contadores de pilas
	deck_size_changed.emit(deck.size())
	discards_size_changed.emit(discards.size())
	
	deck.shuffle()
	finish_turn()

# Funcion para la secuencia al finalizar turno
func finish_turn() -> void:
	# Comprobacion de las cartas a robar
	var cards_to_draw: int = 5 - hand.size()
	# Comprobacion de las cartas disponibles para robar
	var total_available_cards: int = deck.size() + discards.size()
	# Cartas reales para robar
	var real_cards_to_draw: int = min(cards_to_draw, total_available_cards)
	
	if real_cards_to_draw <= 0:
		return
	
	for i in real_cards_to_draw:
		if deck.size() == 0:
			restart_deck()
		var drawn_card = deck.pop_front()
		# Señal para actualizar contadores de pilas
		deck_size_changed.emit(deck.size())
		hand.push_front(drawn_card)
		# Señal para enviar informacion de la carta robada a la interfaz
		card_drawn.emit(drawn_card)
	

# Funcion para usar las cartas y mandarlas a la pila de descartes
func use_card(card_data: CardBlueprint):
	hand.erase(card_data)
	discards.append(card_data)
	# Señal para actualizar contadores de pilas
	discards_size_changed.emit(discards.size())

# Funcion para reinciar la baraja
func restart_deck() -> void:
	deck = discards.duplicate()
	for i in range(deck.size()):
		deck[i] = deck[i].duplicate()
	discards.clear()
	deck.shuffle()
	# Señales para actualizar contadores de pilas
	discards_size_changed.emit(0)
	deck_size_changed.emit(deck.size())
