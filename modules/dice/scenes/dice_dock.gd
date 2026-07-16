extends HBoxContainer
class_name DiceDock

signal dice_selected(dice_node: Node)

@export var placeholder_scene: PackedScene
@export var min_slots: int = 3
@export var max_slots: int = 5

var active_dice: Array[Node] = []

func _ready() -> void:
	alignment = BoxContainer.ALIGNMENT_CENTER
	_refresh_dock()

func add_dice(dice_node: Node) -> void:
	if active_dice.size() >= max_slots:
		return
		
	active_dice.append(dice_node)
	
	if dice_node.has_signal("pressed"):
		dice_node.connect("pressed", Callable(self, "_on_dice_clicked").bind(dice_node))
		
	_refresh_dock()

func remove_dice(dice_node: Node) -> void:
	if dice_node in active_dice:
		active_dice.erase(dice_node)
		_refresh_dock()

func clear_all_dice() -> void:
	active_dice.clear()
	_refresh_dock()

func get_active_dice() -> Array[Node]:
	return active_dice

func _refresh_dock() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()
		
	var dice_count: int = active_dice.size()
	var total_slots: int = max(min_slots, dice_count)
	
	for i in range(total_slots):
		if i < dice_count:
			var dice: Node = active_dice[i]
			if dice.get_parent() != null:
				dice.get_parent().remove_child(dice)
			add_child(dice)
		else:
			if placeholder_scene != null:
				var placeholder: Node = placeholder_scene.instantiate()
				add_child(placeholder)

func _on_dice_clicked(dice_node: Node) -> void:
	emit_signal("dice_selected", dice_node)
