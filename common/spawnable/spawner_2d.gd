class_name Spawner2D extends Node2D

#region VARIABLES
@export var spawnable_scene: PackedScene

var spawnable_pool: Array[Spawnable2D] = []
#endregion

#region FUNCTIONS
## Get spawnable component from node.
func get_spawnable_from_node(node: Node) -> Spawnable2D:
	if node is Spawnable2D: return node
	for child in node.get_children(true):
		if child is Spawnable2D: return child
	return null

## Tries to add the provided scene as a node to the scene tree, and return a spawnable.
func add_node_and_get_spawnable() -> Spawnable2D:
	var spawnable: Spawnable2D = spawnable_pool.pop_front()
	if spawnable == null:
		var node: Node = spawnable_scene.instantiate()
		spawnable = get_spawnable_from_node(node)
		if spawnable == null:
			return null
		
		add_child(node)
		spawnable.despawned.connect(func(_new_position: Vector2): spawnable_pool.append(spawnable))
	
	return spawnable

## Spawn the specific spawnable assigned to this spawner.
func spawn(spawn_point: Vector2) -> void:
	var spawnable: Spawnable2D = add_node_and_get_spawnable()
	if spawnable == null:
		return
	
	spawnable.spawn(spawn_point)
#endregion
