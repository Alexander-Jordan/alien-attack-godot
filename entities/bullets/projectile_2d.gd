class_name Projectile2D extends Spawnable2D

#region VARIABLES
@export var speed: int = 500

var can_move: bool = true
#endregion

#region FUNCTIONS
func _process(delta: float) -> void:
	if can_move:
		root_node.position += direction.normalized() * speed * delta
#endregion
