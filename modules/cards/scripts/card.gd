extends TextureRect

# Datos de la carta
var data: CardData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(card_data: CardData) -> void:
	texture = card_data.image
