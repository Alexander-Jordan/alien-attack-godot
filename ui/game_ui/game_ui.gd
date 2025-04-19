class_name GameUI extends Control

@export var texture_rects_lives: Array[TextureRect]

@onready var button_back: Button = $VBoxContainer/HBoxContainer/button_back
@onready var button_restart: Button = $VBoxContainer/HBoxContainer/button_restart
@onready var label_game_over: Label = $VBoxContainer/ui_end_screen/VBoxContainer/label_game_over
@onready var label_score: Label = $VBoxContainer/MarginContainer/label_score
@onready var ui_audio_player: UIAudioPlayer = $UIAudioPlayer

func _ready() -> void:
	button_restart.pressed.connect(func(): ui_audio_player.button_pressed(); restart())
	
	GameManager.lives_changed.connect(func(lives: int):
		if lives == 3:
			for texture_rect in texture_rects_lives:
				texture_rect.show()
		else:
			for lost_live in (3 - lives):
				texture_rects_lives[lost_live-1].hide()
	)
	GameManager.mode_changed.connect(func(mode: GameManager.Mode):
		match mode:
			GameManager.Mode.NEW, GameManager.Mode.RESET:
				label_game_over.hide()
			GameManager.Mode.OVER:
				label_game_over.show()
	)
	
	SaveSystem.stats.score_changed.connect(func(score: int):
		label_score.text = str(score)
	)

func restart():
	button_restart.release_focus()
	GameManager.mode = GameManager.Mode.NEW

func go_back():
	button_back.release_focus()
	GameManager.mode = GameManager.Mode.NEW
	get_tree().change_scene_to_file('res://ui/main_menu/main_menu.tscn')
