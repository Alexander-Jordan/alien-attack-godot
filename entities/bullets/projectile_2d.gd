class_name Projectile2D extends Spawnable2D

#region VARIABLES
@export var direction: Vector2 = Vector2(0, -1)
@export var speed: int = 500

var can_move: bool = true
#endregion

#region FUNCTIONS
func _process(delta: float) -> void:
	if can_move:
		root_node.position += direction.normalized() * speed * delta
#endregion
