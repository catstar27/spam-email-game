extends Control

signal start
signal tutorial
signal leaderboard
signal quit

func _on_start_button_pressed() -> void:
	start.emit()

func _on_tutorial_button_pressed() -> void:
	tutorial.emit()

func _on_leaderboard_button_pressed() -> void:
	leaderboard.emit()

func _on_quit_button_pressed() -> void:
	quit.emit()
