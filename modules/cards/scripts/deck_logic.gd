extends Node

signal card_drawn(card: CardInstance)
signal deck_size_changed(amount: int)
signal discards_size_changed(amount: int)

# Mano inicial temporal
@export var initial_deck: Array[CardBlueprint]

# Baraja, mano y descartes o cartas usadas guardan CardInstance
var deck_stack: Array[CardInstance] = []
var hand: Array[CardInstance] = []
var discard_stack: Array[CardInstance] = []

func _ready() -> void:
	# Llamamos con deferred para esperar a que toda la escena este cargada y no se emitan señales antes de tiempo
	call_deferred("init_combat")
	CombatBus.card_consumed.connect(use_card)
	
# Funcion para establecer la baraja como la inicial y mezclarla
func init_combat() -> void:
	for blueprint: CardBlueprint in initial_deck:
		var new_card_instance: CardInstance = CardInstance.new(blueprint)
		print(new_card_instance.id)
		deck_stack.append(new_card_instance)
	
	# Señal para actualizar contadores de pilas
	deck_size_changed.emit(deck_stack.size())
	discards_size_changed.emit(discard_stack.size())
	
	deck_stack.shuffle()
	finish_turn()

# Funcion para la secuencia al finalizar turno
func finish_turn() -> void:
	# Comprobacion de las cartas a robar
	var cards_to_draw: int = 5 - hand.size()
	# Comprobacion de las cartas disponibles para robar
	var total_available_cards: int = deck_stack.size() + discard_stack.size()
	# Cartas reales para robar
	var real_cards_to_draw: int = min(cards_to_draw, total_available_cards)
	
	if real_cards_to_draw <= 0:
		return
	
	for i in real_cards_to_draw:
		if deck_stack.size() == 0:
			restart_deck()
		var drawn_card: CardInstance = deck_stack.pop_front()
		# Señal para actualizar contadores de pilas
		deck_size_changed.emit(deck_stack.size())
		hand.push_front(drawn_card)
		# Señal para enviar informacion de la carta robada a la interfaz
		card_drawn.emit(drawn_card)
		print("Señal carta ", i)
	

# Funcion para usar las cartas y mandarlas a la pila de descartes
func use_card(card: CardInstance):
	hand.erase(card)
	discard_stack.append(card)
	# Señal para actualizar contadores de pilas
	discards_size_changed.emit(discard_stack.size())

# Funcion para reinciar la baraja
func restart_deck() -> void:
	deck_stack.append_array(discard_stack)
	discard_stack.clear()
	deck_stack.shuffle()
	# Señales para actualizar contadores de pilas
	discards_size_changed.emit(0)
	deck_size_changed.emit(deck_stack.size())
