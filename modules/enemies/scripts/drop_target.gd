extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Funcion que detecta si el objeto soltado en el area es una carta
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Card

func _drop_data(at_position: Vector2, card: Variant) -> void:
	var data = card.card_data
	card.queue_free()
	CombatBus.card_consumed.emit(data)
