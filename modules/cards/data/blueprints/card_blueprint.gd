class_name CardBlueprint
extends Resource

# Datos de las cartas
@export var name: String
@export var element: Element.Type
@export var elemental_cost: int
@export var neutral_cost: int
@export var rarity: Rarity.Type
@export var target: Target.Type
@export var effect_description: String
@export var hits: int = 1
@export var base_damage: int
# TODO: Falta por añadir estados u efectos que pueda aplicar o consumir la carta (Ej: Quemado, Debilidad, Mojado)
# Por ahora sera la carta en si en el futuro unicamente la imagen de la carta
@export var image: Texture2D
