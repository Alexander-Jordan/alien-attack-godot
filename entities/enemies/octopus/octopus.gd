class_name Octopus extends CharacterBody2D

@onready var alien: Alien = $Alien

var speed: int = 100

func _ready() -> void:
	alien.root_node = self

func _physics_process(delta: float) -> void:
	velocity.x = (alien.step_distance.x * alien.direction) * speed * delta
	move_and_slide()
