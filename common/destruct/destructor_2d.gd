class_name Destructor2D extends Destructable2D
## The destructor component.
##
## This will bring destruction to destructables.
## It's also a destructable itself to remove it when finished.

#region VARIABLES
## The audio streams to choose from when hitting a destructable.
@export var audio_streams: Array[AudioStream] = []
## Should this destructor always be destroyed on the first hit?[br]
## Default behavior is to keep the destructor alive until health is 0.[br]
## Setting this to true will override this default behavior.
@export var destroy_on_first_hit: bool = false
#endregion

#region FUNCTIONS
func _ready() -> void:
	area_entered.connect(func(area: Area2D):
		if area is Destructable2D:
			var new_health = area.destruct(health, get_random_audio())
			health = 0 if destroy_on_first_hit else new_health
	)

## Pick a random audio stream.
func get_random_audio() -> AudioStream:
	if audio_streams.is_empty():
		return null
	return audio_streams.pick_random()
#endregion
