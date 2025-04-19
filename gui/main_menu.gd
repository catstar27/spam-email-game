extends Control

signal start
signal tutorial
signal leaderboard(in_game: bool)
signal quit

func _on_start_button_pressed() -> void:
	hide()
	start.emit()

func _on_tutorial_button_pressed() -> void:
	tutorial.emit()

func _on_leaderboard_button_pressed() -> void:
	leaderboard.emit(false)

func _on_quit_button_pressed() -> void:
	quit.emit()
