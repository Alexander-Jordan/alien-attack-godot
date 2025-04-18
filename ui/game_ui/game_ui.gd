class_name GameUI extends Control

@onready var button_back: Button = $VBoxContainer/HBoxContainer/button_back
@onready var button_restart: Button = $VBoxContainer/HBoxContainer/button_restart
@onready var label_score: Label = $VBoxContainer/MarginContainer/label_score
@onready var ui_audio_player: UIAudioPlayer = $UIAudioPlayer
@onready var ui_end_screen: Control = $VBoxContainer/ui_end_screen

func _ready() -> void:
	button_restart.pressed.connect(func(): ui_audio_player.button_pressed(); restart())
	
	GameManager.mode_changed.connect(func(mode: GameManager.Mode):
		match mode:
			GameManager.Mode.NEW, GameManager.Mode.RESET:
				ui_end_screen.hide()
			GameManager.Mode.OVER:
				ui_end_screen.show()
	)

func restart():
	button_restart.release_focus()
	GameManager.mode = GameManager.Mode.NEW

func go_back():
	button_back.release_focus()
	GameManager.mode = GameManager.Mode.NEW
	get_tree().change_scene_to_file('res://ui/main_menu/main_menu.tscn')
