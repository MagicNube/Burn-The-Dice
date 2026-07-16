extends Control
class_name CombatMain

# Para controlar las fases de los turnos, por ver
enum TurnState {
	PLAYER_TURN,
	ENEMY_TURN,
	DICE_ROLLING,
	RESOLUTION
}

@export var dice_scene : PackedScene
@export var cards_scene: PackedScene
@export var ui_scene : PackedScene
@export var enemy_scene : PackedScene
@export var player_scene : PackedScene

# Si están en la misma escena es más recomendable
@onready var dice_zone_spot : Control = $DiceZoneSpot
@onready var cards_spot : Control = $CardsSpot
@onready var player_spot : Control = $PlayerSpot
@onready var enemy_spot : Control = $EnemySpot
@onready var ui_spot : Control = $UISpot
@onready var combat_ui : Control = $"."

var dice_instance : Node
var cards_instance: Node
var ui_instance : Node
var enemy_instance : Node
var player_instance : Node

var current_turn_state : TurnState = TurnState.PLAYER_TURN

func _ready() -> void:
	_initialize()
	print("CombatMain:", size)
	print("Background:", $Background.size)
	print($Background.texture.get_size())

func _initialize() -> void:
	if dice_scene:
		dice_instance = dice_scene.instantiate()
		dice_zone_spot.add_child(dice_instance)
		
	if cards_scene:
		cards_instance = cards_scene.instantiate()
		cards_spot.add_child(cards_instance)
		
	if enemy_scene:
		enemy_instance = enemy_scene.instantiate()
		enemy_spot.add_child(enemy_instance)
		
	if player_scene:
		player_instance = player_scene.instantiate()
		player_spot.add_child(player_instance)
		
	if ui_scene:
		ui_instance = ui_scene.instantiate()
		ui_spot.add_child(ui_instance)

func _change_turn(new_state: TurnState) -> void:
	current_turn_state = new_state
	match new_state: 
		TurnState.PLAYER_TURN:
			_handle_player_turn()
		TurnState.ENEMY_TURN:
			_handle_enemy_turn()
		TurnState.DICE_ROLLING:
			_handle_dice_rolling()
		TurnState.RESOLUTION:
			_handle_resolution()

func _handle_player_turn() -> void:
	pass

func _handle_dice_rolling() -> void:
	pass
	
func _handle_enemy_turn() -> void:
	pass
	
func _handle_resolution() -> void:
	pass
