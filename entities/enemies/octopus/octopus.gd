class_name Octopus extends CharacterBody2D
## The octopus alien.

#region VARIABLES
## The alien component with various properties shared between alien types.
@onready var alien: Alien = $Alien
#endregion

#region FUNCTIONS
func _ready() -> void:
	alien.root_node = self

func _physics_process(delta: float) -> void:
	if alien.can_move:
		velocity.x = (alien.step_distance.x * GameManager.alien_direction) * alien.speed * delta
		move_and_slide()
#endregion
