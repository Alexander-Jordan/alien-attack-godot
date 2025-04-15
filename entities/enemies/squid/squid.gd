class_name Squid extends Node2D
## The squid alien.

#region VARIABLES
## The alien component with various properties shared between alien types.
@onready var alien: Alien = $Alien
#endregion

#region FUNCTIONS
func _ready() -> void:
	alien.root_node = self
#endregion
