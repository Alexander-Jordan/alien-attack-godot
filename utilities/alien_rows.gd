class_name AlienRows extends Node2D

#region VARIABLES
var rows: Array[AlienRow]
#endregion

#region FUNCTIONS
func _ready() -> void:
	GameManager.mode_changed.connect(func(mode: GameManager.Mode):
		match mode:
			GameManager.Mode.NEW:
				reset()
	)
	
	for child in get_children():
		if child is AlienRow:
			rows.append(child)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('dev_reset'):
		GameManager.mode = GameManager.Mode.NEW

func reset() -> void:
	for row in rows:
		await row.reset()
	GameManager.mode = GameManager.Mode.PLAYING
#endregion
