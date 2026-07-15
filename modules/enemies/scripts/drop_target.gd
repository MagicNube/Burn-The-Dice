extends Control

# Funcion que detecta si el objeto soltado en el area es una carta
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Card

func _drop_data(at_position: Vector2, card: Variant) -> void:
	# Obtenemos datos de la carta, la eliminamos y mandamos señal para que se elimine de la logica de mazo
	var instance_to_consume: CardInstance = card.card_instance
	card.queue_free()
	CombatBus.card_consumed.emit(instance_to_consume)
