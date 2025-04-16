class_name Bullet extends Node2D

@onready var destructor_2d: Destructor2D = $Destructor2D
@onready var projectile_2d: Projectile2D = $Projectile2D
@onready var random_audio_player_2d: RandomAudioPlayer2D = $RandomAudioPlayer2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	destructor_2d.destructed.connect(func():
		random_audio_player_2d.play_random_audio_and_await_finished(destructor_2d.audio_streams_destruct)
	)
	destructor_2d.destroyed.connect(func():
		projectile_2d.can_move = false
		sprite_2d.visible = false
		await random_audio_player_2d.play_random_audio_and_await_finished(destructor_2d.audio_streams_destroyed)
		projectile_2d.call_deferred('despawn')
	)
	projectile_2d.spawned.connect(func(_spawn_point: Vector2):
		projectile_2d.can_move = true
		sprite_2d.visible = true
	)
	visible_on_screen_notifier_2d.screen_exited.connect(func(): projectile_2d.call_deferred('despawn'))
