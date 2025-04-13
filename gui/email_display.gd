extends Control
class_name EmailDisplay
## Displays and references an email

signal marked_spam
signal replied

@export var email: Email ## Email to display info for

func set_email(new_email: Email)->void:
	if new_email == null:
		return
	email = new_email
	%SenderLabel.text = "From: "+email.sender
	%SubjectLabel.text = "Subject: "+email.subject
	%Body.text = email.body

func _on_spam_button_pressed() -> void:
	marked_spam.emit()

func _on_reply_button_pressed() -> void:
	replied.emit()
