class_name DiceDefinition
extends Resource

@export var geometry: Array[FaceGeometry] = []

func get_winning_face_id(markers: Array[MarkerFace]) -> Array[int]:
	var highest = -INF
	var winner = -1
	
	var lowest = markers[0].global_position.y
	var lower = markers[0]
	
	for marker in markers:
		if marker.global_position.y > highest:
			highest = marker.global_position.y
			winner = marker.id
	
	# Temporal -> Comprobar opuestos 
		if marker.global_position.y < lowest:
			lowest = marker.global_position.y
			lower = marker.id
	
	return [winner, lower]
