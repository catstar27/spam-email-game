extends Control

signal go_to_menu
signal quit

func _on_menu_button_pressed() -> void:
	hide()
	go_to_menu.emit()

func _on_quit_button_pressed() -> void:
	quit.emit()
