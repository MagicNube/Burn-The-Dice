class_name DiceRegistry
extends RefCounted

static func get_definition(type: String) -> DiceDefinition:
	var def = DiceDefinition.new()
	var geometry_list: Array[FaceGeometry] = []

	match type:

		"d6":
			geometry_list = [
				FaceGeometry.new(Vector3(0.0000, 0.0000, 0.7004), Vector2(0.1667, 0.8333), 90.00),
				FaceGeometry.new(Vector3(0.0000, 0.0000, -0.7004), Vector2(0.5000, 0.8333), 90.00),
				FaceGeometry.new(Vector3(0.0000, -0.7004, 0.0000), Vector2(0.1667, 0.5000), 90.00),
				FaceGeometry.new(Vector3(0.0000, 0.7004, 0.0000), Vector2(0.5000, 0.5000), -90.00),
				FaceGeometry.new(Vector3(0.7004, 0.0000, 0.0000), Vector2(0.1667, 0.1667), 90.00),
				FaceGeometry.new(Vector3(-0.7004, 0.0000, 0.0000), Vector2(0.5000, 0.1667), -180.00),
			]

		"d4":
			geometry_list = [
				FaceGeometry.new(Vector3(-0.3914, 0.0000, 0.1218), Vector2(0.1405, 0.7636), 150.71),
				FaceGeometry.new(Vector3(0.1957, -0.2946, 0.1218), Vector2(0.7249, 0.7342), -149.34),
				FaceGeometry.new(Vector3(0.0000, 0.0000, -0.3655), Vector2(0.1409, 0.2808), 36.71),
				FaceGeometry.new(Vector3(0.1957, 0.2946, 0.1218), Vector2(0.7139, 0.2361), -145.97),
			]

		"d8":
			geometry_list = [
				FaceGeometry.new(Vector3(-0.3454, -0.3454, -0.3454), Vector2(0.0992, 0.8333), -90.00),
				FaceGeometry.new(Vector3(0.3454, -0.3454, -0.3454), Vector2(0.3898, 0.8333), 150.00),
				FaceGeometry.new(Vector3(-0.3454, -0.3454, 0.3454), Vector2(0.0992, 0.5000), 30.00),
				FaceGeometry.new(Vector3(0.3454, -0.3454, 0.3454), Vector2(0.3898, 0.5000), 150.00),
				FaceGeometry.new(Vector3(-0.3454, 0.3454, -0.3454), Vector2(0.6804, 0.5000), 150.00),
				FaceGeometry.new(Vector3(0.3454, 0.3454, 0.3454), Vector2(0.0992, 0.1667), 30.00),
				FaceGeometry.new(Vector3(-0.3454, 0.3454, 0.3454), Vector2(0.3898, 0.1667), -90.00),
				FaceGeometry.new(Vector3(0.3454, 0.3454, -0.3454), Vector2(0.6804, 0.1667), 30.00),
			]

		"d10":
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
				FaceGeometry.new(Vector3(-0.1807, -0.5562, 0.3618), Vector2(0.4100, 0.1890), 90.00),
			]

	for i in range(geometry_list.size()):
		geometry_list[i].id = i

	def.geometry = geometry_list
	return def
