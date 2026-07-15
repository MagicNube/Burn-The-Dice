extends Control

# Variable para el maximo de rotación en grados
var MAX_DEGREES: float = 180

# Variable para almacenar la posicion en x del raton del frame anterior
var mouse_position_x: float
# Variable para aplicar fuerza a la velocidad del raton
var strength: float = 5.0

func _ready() -> void:
	# Guardamos la posicion inicial del raton en x
	mouse_position_x = get_global_mouse_position().x

func _process(delta: float) -> void:
	# Obtenemos la nueva posicion en x del raton
	var new_mouse_position_x = get_global_mouse_position().x
	# Calculamos la velocidad
	var velocity = new_mouse_position_x - mouse_position_x
	# Guardamos la nueva posicion del raton durante este fram
	mouse_position_x = new_mouse_position_x
	
	# Calculamos la rotacion comprobando que se mantiene dentro del rango definido
	var new_rotation_degrees = clamp(velocity * strength, -MAX_DEGREES, MAX_DEGREES)
	# Asignamos a la rotacion de la carta de forma progresiva con lerp
	rotation_degrees = lerp(rotation_degrees, new_rotation_degrees, 15.0 * delta)
	
