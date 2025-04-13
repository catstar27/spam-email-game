extends Control

signal next_screen

func set_email(email: Email, extra_credit: bool = false)->void:
	if extra_credit:
		%AnswerLabel.text = "Correct Justification:"
		%JustificationLabel.text = email.justification
	elif email.is_spam:
		%AnswerLabel.text = "The email is spam!"
		%JustificationLabel.text = email.justification
	else:
		%AnswerLabel.text = "The email is probably not spam!"

func _on_continue_button_pressed() -> void:
	next_screen.emit()
