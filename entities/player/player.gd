class_name Player extends CharacterBody2D
## The player script.
##
## The basic script for the player ship.

#region VARIABLES
@export var projectile_pool: ProjectilePool

# used to lock the y-position
@onready var y_position:float = self.position.y

var input_pos:Vector2 = self.position
var speed:int = 2000
#endregion

#region FUNCTIONS
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('fire'):
		projectile_pool.spawn(position)
		print('Player just fired a missile')

func _physics_process(delta: float) -> void:
	input_pos = get_viewport().get_mouse_position()
	# lock the y-position
	input_pos.y = y_position
	velocity = (input_pos - position) * speed * delta
	move_and_slide()
#endregion
