class_name CardInstance
extends RefCounted
# Clase que envuelve un CardBlueprint con un id unico
var id: String
var blueprint: CardBlueprint

# Espacio para posibles modificadores (damage_modifier, cost_modifier)

func _init(card_blueprint: CardBlueprint) -> void:
	blueprint = card_blueprint
	id = "card_" + str(get_instance_id())
