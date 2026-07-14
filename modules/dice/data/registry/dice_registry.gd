class_name DiceRegistry
extends RefCounted


static func get_definition(type: DieType.Type) -> DiceDefinition:
	var def : DiceDefinition
	if type == DieType.Type.D4:
		def = D4Definition.new()
	else:
		def = DiceDefinition.new()
	var geometry_list: Array[FaceGeometry] = []
	
	match type:
		DieType.Type.D6:
			geometry_list = [
				FaceGeometry.new(Vector3(0.0000, 0.0000, 0.7004), Vector2(0.1667, 0.8333), 90.00),
				FaceGeometry.new(Vector3(0.0000, 0.0000, -0.7004), Vector2(0.5000, 0.8333), 90.00),
				FaceGeometry.new(Vector3(0.0000, -0.7004, 0.0000), Vector2(0.1667, 0.5000), 90.00),
				FaceGeometry.new(Vector3(0.0000, 0.7004, 0.0000), Vector2(0.5000, 0.5000), -90.00),
				FaceGeometry.new(Vector3(0.7004, 0.0000, 0.0000), Vector2(0.1667, 0.1667), 90.00),
				FaceGeometry.new(Vector3(-0.7004, 0.0000, 0.0000), Vector2(0.5000, 0.1667), -180.00)
			]
		DieType.Type.D4:
			geometry_list = [
				FaceGeometry.new(Vector3(0.1957, 0.2946, 0.1218), Vector2.ZERO, 0.0, Vector3(0.4219, 0.8409, 0.3389), PackedVector2Array([Vector2(0.8595, 0.5016), Vector2(0.4226, 0.2066), Vector2(0.8595, -0.0000)])),
				FaceGeometry.new(Vector3(-0.3914, 0.0000, 0.1218), Vector2.ZERO, 0.0, Vector3(-0.9280, 0.0000, 0.3727), PackedVector2Array([Vector2(0.0000, 1.0000), Vector2(-0.0000, 0.5272), Vector2(0.4215, 0.7636)])),
				FaceGeometry.new(Vector3(0.1957, -0.2946, 0.1218), Vector2.ZERO, 0.0, Vector3(0.4219, -0.8409, 0.3389), PackedVector2Array([Vector2(0.8761, 0.9849), Vector2(0.4226, 0.7161), Vector2(0.8761, 0.5016)])),
				FaceGeometry.new(Vector3(0.0000, 0.0000, -0.3655), Vector2.ZERO, 0.0, Vector3(0.0000, 0.0000, -1.0000), PackedVector2Array([Vector2(0.0000, 0.5272), Vector2(-0.0000, 0.0000), Vector2(0.4226, 0.3151)]))
			]
		DieType.Type.D8:
			geometry_list = [
				FaceGeometry.new(Vector3(-0.3454, -0.3454, -0.3454), Vector2(0.0992, 0.8333), -90.00),
				FaceGeometry.new(Vector3(0.3454, -0.3454, -0.3454), Vector2(0.3898, 0.8333), 150.00),
				FaceGeometry.new(Vector3(-0.3454, -0.3454, 0.3454), Vector2(0.0992, 0.5000), 30.00),
				FaceGeometry.new(Vector3(0.3454, -0.3454, 0.3454), Vector2(0.3898, 0.5000), 150.00),
				FaceGeometry.new(Vector3(-0.3454, 0.3454, -0.3454), Vector2(0.6804, 0.5000), 150.00),
				FaceGeometry.new(Vector3(0.3454, 0.3454, 0.3454), Vector2(0.0992, 0.1667), 30.00),
				FaceGeometry.new(Vector3(-0.3454, 0.3454, 0.3454), Vector2(0.3898, 0.1667), -90.00),
				FaceGeometry.new(Vector3(0.3454, 0.3454, -0.3454), Vector2(0.6804, 0.1667), 30.00)
			]
		DieType.Type.D10:
			geometry_list = [
				FaceGeometry.new(Vector3(-0.4733, -0.3438, -0.3618), Vector2(0.6651, 0.8498), 121.70),
				FaceGeometry.new(Vector3(0.4733, -0.3438, 0.3618), Vector2(0.1341, 0.7627), 26.58),
				FaceGeometry.new(Vector3(-0.4732, 0.3438, -0.3618), Vector2(0.5611, 0.7138), 153.42),
				FaceGeometry.new(Vector3(0.4732, 0.3438, 0.3618), Vector2(0.2381, 0.6267), 58.30),
				FaceGeometry.new(Vector3(0.1807, -0.5562, -0.3618), Vector2(0.5900, 0.3112), -90.00),
				FaceGeometry.new(Vector3(0.1807, 0.5562, -0.3618), Vector2(0.9100, 0.3112), 90.00),
				FaceGeometry.new(Vector3(-0.5850, 0.0000, 0.3618), Vector2(0.2500, 0.2501), 58.31),
				FaceGeometry.new(Vector3(0.5850, 0.0000, -0.3618), Vector2(0.7500, 0.2501), -121.69),
				FaceGeometry.new(Vector3(-0.1807, 0.5562, 0.3618), Vector2(0.0900, 0.1890), -90.00),
				FaceGeometry.new(Vector3(-0.1807, -0.5562, 0.3618), Vector2(0.4100, 0.1890), 90.00)
			]

	for i in range(geometry_list.size()):
		geometry_list[i].id = i
		
	def.geometry = geometry_list
	return def


## Crea las caras del dado. Índices 0,1 / 2-3 / 4-5 son las caras opuestas
static func create_single_value_content(values: Array) -> DiceContent:
	var content = DiceContent.new()
	for val in values:
		var face_arr: Array[String] = []
		face_arr.append(str(val))
		var face_content = FaceContent.new(face_arr)
		content.faces.append(face_content)
	return content
