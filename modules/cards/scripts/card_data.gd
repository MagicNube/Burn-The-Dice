class_name CardData
extends Resource

# Datos de las cartas
@export var name: String
@export var effect_description: String
@export var elemental_cost: int
@export var neutral_cost: int
@export var element: Element.Type
# Por ahora sera la carta en si en el futuro unicamente la imagen de la carta
@export var image: Texture2D
