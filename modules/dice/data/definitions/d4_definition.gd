class_name D4Definition
extends DiceDefinition

func get_winning_face_id(markers: Array[MarkerFace]) -> int:
	var best_dot = -INF
	var winner = -1
	
	for marker in markers:
		var world_normal = marker.get_world_normal()
		var dot = world_normal.dot(Vector3.DOWN)
		
		if dot > best_dot:
			best_dot = dot
			winner = marker.id
			
	return winner
