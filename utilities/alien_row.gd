class_name AlienRow extends Spawner2D

#region VARIABLES
@export var spawn_origin: Vector2 = Vector2.ZERO

var alien_amount: int = 11
var spacing: int = 20
#endregion

#region FUNCTIONS

func reset() -> void:
	var spawn_point: Vector2 = spawn_origin
	for alien in alien_amount:
		spawn(spawn_point)
		spawn_point.x += spacing
		await get_tree().create_timer(0.05).timeout
#endregion
