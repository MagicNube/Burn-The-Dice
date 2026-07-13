extends Control

# Referencias a las pilas de cartas
@export var draw_stack_ui: StackUI
@export var discard_stack_ui: StackUI

# Referencia a la logica de baraja
@export var deck_logic: Node

func _ready() -> void:
	# Conectamos las señales para editar la cantidad de cartas
	deck_logic.deck_size_changed.connect(draw_stack_ui.update_amount)
	deck_logic.discards_size_changed.connect(discard_stack_ui.update_amount)
