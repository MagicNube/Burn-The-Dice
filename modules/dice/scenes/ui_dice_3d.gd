extends Control
class_name Ui3Dice

signal ui_dice_clicked(dice_type_index: int, ui_node: Node)

@export var visual_dice_scenes: Array[PackedScene]
@export var current_dice_type: int = 0

@onready var viewport: SubViewport = $SubViewport
@onready var dice_pivot: Node3D = $SubViewport/DicePivot
@onready var click_button: Button = $ClickButton

var current_model_instance: Node3D

func _ready() -> void:
	_setup_button()
	set_dice_type(current_dice_type)

func _setup_button() -> void:
	if click_button != null:
		click_button.pressed.connect(_on_button_pressed)

func set_dice_type(type_index: int) -> void:
	current_dice_type = type_index
	
	if current_model_instance != null:
		current_model_instance.queue_free()
		current_model_instance = null
		
	if type_index >= 0 and type_index < visual_dice_scenes.size():
		var scene_to_spawn: PackedScene = visual_dice_scenes[type_index]
		if scene_to_spawn != null:
			current_model_instance = scene_to_spawn.instantiate()
			dice_pivot.add_child(current_model_instance)

func get_current_dice_type() -> int:
	return current_dice_type

func _on_button_pressed() -> void:
	print ("boton pulsao")
	emit_signal("ui_dice_clicked", current_dice_type, self)
