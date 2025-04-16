class_name AlienRow extends Node2D

#region VARIABLES
@export var alien_scene: PackedScene
@export var spawn_origin: Vector2 = Vector2.ZERO

var alien_amount: int = 11
var alien_pool: Array[Alien]
var spacing: int = 20
#endregion

#region FUNCTIONS
func get_alien_from_node(node: Node) -> Alien:
	if node is Alien: return node
	for child in node.get_children(true):
		if child is Alien: return child
	return null

func add_node_and_get_alien() -> Alien:
	var alien: Alien = alien_pool.pop_front()
	if alien == null:
		var node: Node = alien_scene.instantiate()
		alien = get_alien_from_node(node)
		if alien == null:
			return null
		
		add_child(node)
		alien.despawned.connect(func(_new_position: Vector2): alien_pool.append(alien))
	
	return alien

func reset() -> void:
	var spawn_point: Vector2 = spawn_origin
	for alien in alien_amount:
		spawn(spawn_point)
		spawn_point.x += spacing
		await get_tree().create_timer(0.05).timeout

func spawn(spawn_point: Vector2) -> void:
	var alien: Alien = add_node_and_get_alien()
	if alien == null:
		return
	
	alien.spawn(spawn_point)
#endregion
