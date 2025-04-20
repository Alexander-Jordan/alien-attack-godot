class_name Ufo extends Node2D

@onready var destructable_2d: Destructable2D = $Destructable2D
@onready var random_audio_player_2d: RandomAudioPlayer2D = $RandomAudioPlayer2D
@onready var spawnable_2d: Spawnable2D = $Spawnable2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var speed: int = 100
var scores: Array[int] = [50, 100, 150, 200, 300]

func _process(delta: float) -> void:
	position += spawnable_2d.direction.normalized() * speed * delta

func _ready() -> void:
	destructable_2d.destructed.connect(func():
		random_audio_player_2d.play_random_audio_and_await_finished(destructable_2d.audio_streams_destruct)
	)
	destructable_2d.destroyed.connect(func():
		self.visible = false
		SaveSystem.stats.score += scores.pick_random()
		spawnable_2d.call_deferred('despawn', Vector2(-10, -10))
		await random_audio_player_2d.play_random_audio_and_await_finished(destructable_2d.audio_streams_destroyed)
		self.visible = true
	)
	
	GameManager.mode_changed.connect(func(mode: GameManager.Mode):
		match mode:
			GameManager.Mode.NEW, GameManager.Mode.RESET:
				reset()
	)
	
	visible_on_screen_notifier_2d.screen_exited.connect(func():
		spawnable_2d.call_deferred('despawn')
	)

func reset() -> void:
	spawnable_2d.despawn()
