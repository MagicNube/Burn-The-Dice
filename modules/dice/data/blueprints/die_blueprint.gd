class_name DieBlueprint
extends Resource

@export var die_name: String

@export var die_type: DieType.Type:
	set(value):
		die_type = value
		if not is_rigged:
			faces = _default_faces()
		notify_property_list_changed()

@export var element: Element.Type

@export var is_combustible: bool = true:
	set(value):
		is_combustible = value
		if not value:
			special_effect = ""
		notify_property_list_changed()

@export_multiline var special_effect: String 

@export var is_rigged: bool = false:
	set(value):
		is_rigged = value
		if value and faces.is_empty():
			faces = _default_faces()
		notify_property_list_changed()

@export var faces: Array[String]

func get_faces() -> Array[String]:
	if is_rigged:
		return faces
	return _default_faces()

func _default_faces() -> Array[String]:
	var result: Array[String] = []
	var count: int = 0
	
	match die_type:
		DieType.Type.D4:
			count = 4
		DieType.Type.D6:
			count = 6
		DieType.Type.D8:
			count = 8
		DieType.Type.D10:
			count = 10
			
	for i in count:
		result.append(str(i + 1))
		
	return result

func _validate_property(property: Dictionary) -> void:
	if property.name == "special_effect" and not is_combustible:
		property.usage = PROPERTY_USAGE_NO_EDITOR
		
	if property.name == "faces" and not is_rigged:
		property.usage = PROPERTY_USAGE_NO_EDITOR
