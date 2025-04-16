class_name Crab extends Node2D
## The crab alien.

#region VARIABLES
## The alien component with various properties shared between alien types.
@onready var alien: Alien = $Alien
#endregion

#region FUNCTIONS
func _ready() -> void:
	alien.root_node = self
#endregion
