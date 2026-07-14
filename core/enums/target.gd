class_name Target

# Enumeracion para indicar el objetivo de las cartas
enum Type

{
	SINGLE_ENEMY, # Carta a enemigo individual
	ALL_ENEMIES,  # Carta a todos los enemigos
	PLAYER,       # Carta para jugador
	NONE          # Carta que se juega en cualquier sitio (Ej: Robar carta, Gota Fria)
}
