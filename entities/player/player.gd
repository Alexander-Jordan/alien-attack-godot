class_name Player extends CharacterBody2D
## The player script.
##
## The basic script for the player ship.

#region VARIABLES
@export var bullet_spawner: Spawner2D

@onready var destructable_2d: Destructable2D = $Destructable2D
@onready var random_audio_player_2d: RandomAudioPlayer2D = $RandomAudioPlayer2D
# used to lock the y-position
@onready var y_position:float = self.position.y

var input_pos:Vector2 = self.position
var speed:int = 2000
#endregion

#region FUNCTIONS
func _physics_process(delta: float) -> void:
	input_pos = get_viewport().get_mouse_position()
	# lock the y-position
	input_pos.y = y_position
	velocity = (input_pos - position) * speed * delta
	move_and_slide()

func _ready() -> void:
	destructable_2d.destructed.connect(func():
		random_audio_player_2d.play_random_audio_and_await_finished(destructable_2d.audio_streams_destruct)
	)
	destructable_2d.destroyed.connect(func():
		self.visible = false
		random_audio_player_2d.play_random_audio_and_await_finished(destructable_2d.audio_streams_destroyed)
		GameManager.mode = GameManager.Mode.OVER
	)
	
	GameManager.mode_changed.connect(func(mode: GameManager.Mode):
		match mode:
			GameManager.Mode.NEW:
				self.visible = true
	)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('fire') and GameManager.mode == GameManager.Mode.PLAYING:
		bullet_spawner.spawn(Vector2(position.x, position.y - 5), Vector2(0, -1))
#endregion
