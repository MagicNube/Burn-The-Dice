class_name DiceDefinition
extends Resource

@export var geometry: Array[FaceGeometry] = []

func get_winning_face_id(markers: Array[MarkerFace]) -> int:
	var highest = -INF
	var winner = -1

	for marker in markers:
		print(
		"ID:", marker.id,
		" Pos:", marker.global_position
	)
		if marker.global_position.y > highest:
			highest = marker.global_position.y
			winner = marker.id
	
	return winner
