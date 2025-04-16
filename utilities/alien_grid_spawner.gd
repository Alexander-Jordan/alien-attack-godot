class_name AlienGridSpawner extends Node2D

#region VARIABLES
@export var grid_origin: Vector2 = Vector2(25, 150)
@export var projectile_spawner: Spawner2D
@export var spacing: Vector2 = Vector2(20, 25)

var aliens_per_spawner: int = 11
var spawners: Array[Spawner2D]
#endregion

#region FUNCTIONS
func _ready() -> void:
	GameManager.mode_changed.connect(func(mode: GameManager.Mode):
		match mode:
			GameManager.Mode.NEW:
				reset()
	)
	
	for child in get_children():
		if child is Spawner2D:
			spawners.append(child)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('dev_reset'):
		GameManager.mode = GameManager.Mode.NEW

func reset() -> void:
	var spawn_point: Vector2 = grid_origin
	for spawner in spawners:
		for alien in aliens_per_spawner:
			var spawnable: Spawnable2D = spawner.spawn(spawn_point)
			if spawnable is Alien:
				spawnable.projectile_spawner = projectile_spawner
			spawn_point.x += spacing.x
			await get_tree().create_timer(0.05).timeout
		spawn_point = Vector2(grid_origin.x, spawn_point.y - spacing.y)
	GameManager.mode = GameManager.Mode.PLAYING
#endregion
