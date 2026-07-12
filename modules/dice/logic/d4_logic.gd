class_name D4Logic
extends RefCounted

static func build_face_map(bottom_face: int, face_count: int) -> Dictionary:
	var visible: Array[int] = []

	for i in range(face_count):
		if i != bottom_face:
			visible.append(i)

	return {
		visible[0]: [bottom_face, visible[1], visible[2]],
		visible[1]: [bottom_face, visible[2], visible[0]],
		visible[2]: [bottom_face, visible[0], visible[1]]
	}
