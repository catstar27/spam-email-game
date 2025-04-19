extends Control

var email: Email
signal extra_credit_answered(email: Email, correct: bool, extra_credit: bool) ## Emits information for the answer screen

## Sets the justifications to match the proper email
func set_email(new_email: Email)->void:
	email = new_email
	var justification_buttons: Array[Node] = %Justifications.get_children().duplicate()
	justification_buttons.shuffle()
	justification_buttons[0].text = email.justification
	var false_justifications: PackedStringArray = email.false_justifications.split("/", true, 3)
	for i in range(1,justification_buttons.size()):
		justification_buttons[i].text = false_justifications[i-1]
	show()

## Emit the answered signal with proper parameters
func _on_justification_1_pressed() -> void:
	if %Justification1.text == email.justification:
		extra_credit_answered.emit(email, true, true)
	else:
		extra_credit_answered.emit(email, false, true)
	hide()

func _on_justification_2_pressed() -> void:
	if %Justification2.text == email.justification:
		extra_credit_answered.emit(email, true, true)
	else:
		extra_credit_answered.emit(email, false, true)
	hide()

func _on_justification_3_pressed() -> void:
	if %Justification3.text == email.justification:
		extra_credit_answered.emit(email, true, true)
	else:
		extra_credit_answered.emit(email, false, true)
	hide()

func _on_justification_4_pressed() -> void:
	if %Justification4.text == email.justification:
		extra_credit_answered.emit(email, true, true)
	else:
		extra_credit_answered.emit(email, false, true)
	hide()
