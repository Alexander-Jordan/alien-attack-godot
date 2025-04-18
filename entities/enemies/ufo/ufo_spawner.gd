class_name UfoSpawner extends Spawner2D

@onready var timer: Timer = $Timer

var spawn_points: Array[Vector2] = [Vector2(-10, 125), Vector2(314, 125)]
var directions: Array[Vector2] = [Vector2(1, 0), Vector2(-1, 0)]
var timer_min: float = 10.0
var timer_max: float = 30.0

func _ready() -> void:
	GameManager.mode_changed.connect(func(mode: GameManager.Mode):
		match mode:
			GameManager.Mode.PLAYING:
				reset_timer()
			GameManager.Mode.NEW, GameManager.Mode.RESET, GameManager.Mode.OVER:
				timer.stop()
	)
	
	timer.timeout.connect(spawn_ufo)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('dev_ufo') and GameManager.mode == GameManager.Mode.PLAYING:
		spawn_ufo()

func spawn_ufo() -> void:
	var random_index: int = randi_range(0, 1)
	spawn(spawn_points[random_index], directions[random_index])
	reset_timer()

func reset_timer() -> void:
	timer.start(randf_range(timer_min, timer_max))
