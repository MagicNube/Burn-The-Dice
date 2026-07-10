class_name D4Definition
extends DiceDefinition

func get_winning_face_id(markers: Array[MarkerFace]) -> int:
	var lowest = INF
	var winner = -1
	
	for marker in markers:
		if marker.global_position.y < lowest:
			lowest = marker.global_position.y
			winner = marker.id
			
	return winner
