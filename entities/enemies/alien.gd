class_name Alien extends Spawnable

#region VARIABLES
@onready var area_2d: Area2D = $Area2D

var can_move: bool = false
var speed: int = 100
var step_distance: Dictionary[String, int] = {
	'x': 10,
	'y': 10,
}
#endregion

#region FUNCTIONS
func _ready() -> void:
	GameManager.mode_changed.connect(func(mode: GameManager.Mode):
		match mode:
			GameManager.Mode.NEW:
				can_move = false
				despawn()
			GameManager.Mode.OVER:
				can_move = false
			GameManager.Mode.PLAYING:
				can_move = true
	)
	GameManager.alien_direction_changed.connect(func(_direction: GameManager.AlienDirection):
		root_node.position.y += step_distance.y
	)
	
	area_2d.body_entered.connect(func(body: Node2D):
		if body is StaticBody2D:
			if GameManager.last_static_body == body:
				return
			
			GameManager.last_static_body = body
			match GameManager.alien_direction:
				GameManager.AlienDirection.LEFT:
					GameManager.alien_direction = GameManager.AlienDirection.RIGHT
				GameManager.AlienDirection.RIGHT:
					GameManager.alien_direction = GameManager.AlienDirection.LEFT
	)
#endregion
