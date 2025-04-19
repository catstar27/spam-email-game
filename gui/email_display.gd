extends Control
class_name EmailDisplay
## Displays and references an email

signal answered(email: Email, correct: bool) ## Emitted when answered, passing the email and correctness of the answer
signal all_answered ## Emitted when all emails have been replied/marked

var email_list: Array[Email] ## List of emails
var index: int = -1 ## Index in email list
@export var email: Email ## Email to display info for

## Increments the index of the email list, checks if it has reached the end, and updates display if not
func next_email()->void:
	index += 1
	if index >= email_list.size():
		all_answered.emit()
		hide()
		return
	email = email_list[index]
	%SenderLabel.text = "From: "+email.sender
	%SubjectLabel.text = "Subject: "+email.subject
	%Body.text = email.body
	show()

func _on_spam_button_pressed() -> void:
	hide()
	answered.emit(email_list[index], email_list[index].is_spam)

func _on_reply_button_pressed() -> void:
	hide()
	answered.emit(email_list[index], !email_list[index].is_spam)
