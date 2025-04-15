class_name AlienRows extends Node2D

func _ready() -> void:
	for child in get_children():
		if child is AlienRow:
			await child.reset()
