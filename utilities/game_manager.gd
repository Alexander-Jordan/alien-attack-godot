class_name GameManagerGlobal extends Node
## The global Game Manager.
##
## This should be added as a global script.

#region ENUMS
## Possible alien directions.
enum AlienDirection {
	LEFT = -1,
	RIGHT = 1,
}
## Possible game modes.
enum Mode {
	NEW,
	PLAYING,
	OVER,
}
#endregion

#region VARIABLES
## The current alien direction.
var alien_direction: AlienDirection = AlienDirection.RIGHT:
	set(ad):
		if !AlienDirection.values().has(ad) or ad == alien_direction:
			return
		alien_direction = ad
		alien_direction_changed.emit(alien_direction)
## The current game mode.
var mode: Mode = Mode.OVER:
	set(m):
		if !Mode.values().has(m) or m == mode:
			return
		mode = m
		mode_changed.emit(mode)
#endregion

#region SIGNALS
## Will be emitted when the alien direction has changed.
signal alien_direction_changed(direction: AlienDirection)
## Will be emitted when the game mode has changed.
signal mode_changed(mode: Mode)
#endregion
