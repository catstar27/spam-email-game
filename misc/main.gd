extends Node2D

@export var button_hover_sound: AudioStreamMP3 ## hover sound for buttons
@export var click: AudioStreamMP3 ## Click sound for buttons
@export var music: Array[AudioStreamMP3] ## Array holding all songs
var song_index: int = -1 ## Index of song playing

func _ready() -> void:
	if !FileAccess.file_exists("user://data.db"):
		DirAccess.copy_absolute("res://data.db", "user://data.db")
	music.shuffle()
	play_next_song()
	connect_buttons(self)

## Connects all button pressed signals to the play click button
func connect_buttons(node: Node)->void:
	for child in node.get_children():
		connect_buttons(child)
		if child is BaseButton:
			child.pressed.connect(play_click)
			child.mouse_entered.connect($HoverPlayer.play)

## Closes the game
func quit_game() -> void:
	get_tree().quit()

## Increments song index and plays the corresponding song
func play_next_song()->void:
	song_index = (song_index+1)%music.size()
	$AudioStreamPlayer.stream = music[song_index]
	$AudioStreamPlayer.play()

## Plays a click sound
func play_click()->void:
	var sfx: AudioStreamPlayer = AudioStreamPlayer.new()
	sfx.finished.connect(sfx.queue_free)
	sfx.stream = click
	add_child(sfx)
	sfx.play()
