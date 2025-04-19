extends Control

const INCORRECT_COLOR = "#9b111e"
const CORRECT_COLOR = "#2e8b57"

var current_email: Email = null ## Email currently being shown
var current_correct: bool = false ## If the current question was correctly answered
var current_extra_credit: bool = false ## If the current question was extra credit

signal start_extra_credit(email: Email)
signal game_over
signal next_question
signal show_scoreboard(next_signal)

## Sets the labels based on answer type and correctness
func set_email(email: Email, correct: bool, extra_credit: bool = false)->void:
	current_email = email
	current_correct = correct
	current_extra_credit = extra_credit
	Scoreboard.answer_given(correct, extra_credit)
	%JustificationLabel.hide()
	if correct:
		$Title.text = "[b][color="+CORRECT_COLOR+"]Correct!"
		%AnswerLabel.label_settings.font_color = Color.from_string(CORRECT_COLOR, Color.DARK_GREEN)
		%AnswerLabel.text = "Good Job!"
	else:
		$Title.text = "[b][color="+INCORRECT_COLOR+"]Incorrect!"
		%AnswerLabel.label_settings.font_color = Color.from_string(INCORRECT_COLOR, Color.DARK_RED)
		%JustificationLabel.label_settings.font_color = Color.from_string(INCORRECT_COLOR, Color.DARK_RED)
		if extra_credit:
			%AnswerLabel.text = "Correct Justification:"
			%JustificationLabel.text = email.justification
			%JustificationLabel.show()
		else:
			%AnswerLabel.text = "The email is "
			if !email.is_spam:
				%AnswerLabel.text += "not "
			%AnswerLabel.text += "spam!"
			%JustificationLabel.text = email.justification
	show()

func _on_continue_button_pressed() -> void:
	hide()
	if current_correct && current_email.is_spam && !current_extra_credit:
		start_extra_credit.emit(current_email)
	elif !current_correct && Scoreboard.current_score.strikes >= 3:
		game_over.emit()
	else:
		show_scoreboard.emit(next_question)
