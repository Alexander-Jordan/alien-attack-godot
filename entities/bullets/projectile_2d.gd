class_name Projectile2D extends Spawnable2D

#region VARIABLES
@export var direction: Vector2 = Vector2(0, -1)
@export var speed: int = 500
#endregion

#region FUNCTIONS
func _process(delta: float) -> void:
	root_node.position += direction.normalized() * speed * delta
#endregion
