class_name Destructable2D extends Area2D
## A simple component to make anything a destructable.

#region VARIABLES
## The maximum, or default, amount of health.
@export_range(1, 10) var health_max: int = 1
## To play audio when hit.
@export var audio_stream_player_2d: AudioStreamPlayer2D

## Amount of health before being destroyed.
var health: int = health_max:
	set(h):
		health = h if h >= 0 else 0
		if health <= 0:
			destroyed.emit()
			health = health_max # reset
#endregion

#region SIGNALS
## Emitted when destroyed.
signal destroyed
#endregion

#region FUNCTIONS
## Called by a destructor to make this destructable take damage.
## Returns the destruct amount left in the destructor.
func destruct(amount: int = health, audio_stream: AudioStream = null) -> int:
	var amount_left = amount - health
	health -= amount
	if audio_stream != null and audio_stream_player_2d != null:
		audio_stream_player_2d.stream = audio_stream
		audio_stream_player_2d.play()
	
	return amount_left if amount_left >= 0 else 0
#endregion
