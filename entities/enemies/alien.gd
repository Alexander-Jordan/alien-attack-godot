class_name Alien extends Spawnable2D

#region VARIABLES
@export var projectile_spawner: Spawner2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var area_2d_left: Area2D = $Area2D_left
@onready var area_2d_right: Area2D = $Area2D_right
@onready var destructable_2d: Destructable2D = $"../Destructable2D"
@onready var random_audio_player_2d: RandomAudioPlayer2D = $"../RandomAudioPlayer2D"
@onready var ray_cast_2d: RayCast2D = $"../RayCast2D"

var can_move: bool = false
var step_distance: Dictionary[String, int] = {
	'x': 10,
	'y': 10,
}
var fire_min: float = 1.0
var fire_max: float = 20.0
var fire_cool_down: float = randf_range(fire_min, fire_max)
#endregion

#region FUNCTIONS
func _ready() -> void:
	GameManager.mode_changed.connect(func(mode: GameManager.Mode):
		match mode:
			GameManager.Mode.NEW, GameManager.Mode.RESET, GameManager.Mode.OVER:
				can_move = false
			GameManager.Mode.PLAYING:
				can_move = true
	)
	GameManager.alien_direction_changed.connect(func(_direction: GameManager.AlienDirection):
		root_node.position.y += step_distance.y
	)
	
	area_2d_left.body_entered.connect(func(body: Node2D):
		if body is StaticBody2D:
			GameManager.alien_direction = GameManager.AlienDirection.RIGHT
	)
	area_2d_right.body_entered.connect(func(body: Node2D):
		if body is StaticBody2D:
			GameManager.alien_direction = GameManager.AlienDirection.LEFT
	)
	
	destructable_2d.destructed.connect(func():
		random_audio_player_2d.play_random_audio_and_await_finished(destructable_2d.audio_streams_destruct)
	)
	destructable_2d.destroyed.connect(func():
		can_move = false
		animated_sprite_2d.visible = false
		GameManager.speed += (GameManager.speed / 55) * 3
		await random_audio_player_2d.play_random_audio_and_await_finished(destructable_2d.audio_streams_destroyed)
		call_deferred('despawn')
		GameManager.aliens_left -= 1
	)
	
	spawned.connect(func(_new_position: Vector2):
		animated_sprite_2d.visible = true
	)

func _process(delta: float) -> void:
	if can_move:
		root_node.position.x += (step_distance.x * GameManager.alien_direction) * GameManager.speed * delta
		
		if projectile_spawner == null:
			return
		
		fire_cool_down -= delta
		if fire_cool_down <= 0 and !ray_cast_2d.is_colliding():
			projectile_spawner.spawn(Vector2(root_node.position.x, root_node.position.y + 10), Vector2(0, 1))
			fire_cool_down = randf_range(fire_min, fire_max)
#endregion
