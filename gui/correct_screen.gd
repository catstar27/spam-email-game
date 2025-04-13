extends Control

signal next_screen

func _on_continue_button_pressed() -> void:
	next_screen.emit()
