class_name Alien extends Node2D

#region VARIABLES
@onready var area_2d: Area2D = $Area2D

var direction: AlienRow.Direction = AlienRow.Direction.RIGHT:
	set(d):
		if !AlienRow.Direction.values().has(d):
			return
		direction = d
var step_distance: Dictionary[String, int] = {
	'x': 10,
	'y': 10,
}
## The root node of this game node.
var root_node: Node2D = self
## Has this spawnable been spawned?
var is_spawned: bool = false :
	set(s):
		if s == is_spawned:
			return
		is_spawned = s
#endregion

#region SIGNALS
## Emitted when spawned.
signal spawned(spawn_point: Vector2, target_node: Node2D)
## Emitted when despawned.
signal despawned(new_position: Vector2)
signal move_down
#endregion

#region FUNCTIONS
func _ready() -> void:
	area_2d.body_entered.connect(func(body: Node2D):
		if body is StaticBody2D:
			move_down.emit()
	)

func change_direction(new_direction: int) -> void:
	direction = new_direction
	root_node.position.y += step_distance.y

## Used to spawn the spawnable.
func spawn(spawn_point: Vector2 = Vector2.ZERO) -> void:
	if is_spawned:
		return
	
	root_node.visible = true
	root_node.process_mode = ProcessMode.PROCESS_MODE_INHERIT
	root_node.position = spawn_point
	is_spawned = true

## Used to despawn/disable the spawnable.
func despawn(new_position: Vector2 = Vector2.ZERO) -> void:
	if !is_spawned:
		return
	
	root_node.visible = false
	root_node.process_mode = ProcessMode.PROCESS_MODE_DISABLED
	root_node.position = new_position
	is_spawned = false
	despawned.emit(new_position)
#endregion
