class_name MainMenu extends Control

@onready var button_exit: Button = $VBoxContainer/VBoxContainer/button_exit
@onready var button_start: Button = $VBoxContainer/VBoxContainer/button_start
@onready var checkbox_music: CheckBox = $VBoxContainer/HBoxContainer/checkbox_music
@onready var checkbox_sfx: CheckBox = $VBoxContainer/HBoxContainer/checkbox_sfx
@onready var ui_audio_player: UIAudioPlayer = $UIAudioPlayer

var sfx_bus_index: int
var music_bus_index: int

func _ready() -> void:
	music_bus_index = AudioServer.get_bus_index('music')
	sfx_bus_index = AudioServer.get_bus_index('sfx')
	
	button_start.pressed.connect(func(): await ui_audio_player.button_pressed(); start())
	button_exit.pressed.connect(func(): await ui_audio_player.button_pressed(); get_tree().quit())
	checkbox_music.toggled.connect(toggle_music)
	checkbox_sfx.toggled.connect(toggle_sfx)
	
	AudioServer.set_bus_mute(music_bus_index, !SaveSystem.settings.audio.music)
	AudioServer.set_bus_mute(sfx_bus_index, !SaveSystem.settings.audio.sfx)
	
	checkbox_music.set_pressed_no_signal(!AudioServer.is_bus_mute(music_bus_index))
	checkbox_sfx.set_pressed_no_signal(!AudioServer.is_bus_mute(sfx_bus_index))

func start():
	get_tree().change_scene_to_file('res://stages/main.tscn')

func toggle_music(is_on:bool):
	ui_audio_player.button_pressed()
	AudioServer.set_bus_mute(music_bus_index, !is_on)
	SaveSystem.settings.audio.music = is_on
	SaveSystem.save_settings()

func toggle_sfx(is_on:bool):
	ui_audio_player.button_pressed()
	AudioServer.set_bus_mute(sfx_bus_index, !is_on)
	SaveSystem.settings.audio.sfx = is_on
	SaveSystem.save_settings()
