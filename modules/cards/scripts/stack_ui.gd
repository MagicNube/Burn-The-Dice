extends Control
class_name StackUI

# Referencia al label del StackUI
@export var amountLabel: Label

# Funcion para actualizar el contador de la pila
func update_amount(new_amount: int) -> void:
	amountLabel.text = str(new_amount)
