extends Control
class_name GUI

var emails: Array[Email]
var email_index: int = 0
var strikes: int = 0
var prev_screen_extra_credit: bool = false ## Whether the previous screen was extra credit

signal quit

func next_email()->void:
	email_index += 1
	if email_index >= emails.size():
		$GameWon.show()
	else:
		$EmailDisplay.set_email(emails[email_index])
		$EmailDisplay.show()

func _on_main_menu_leaderboard() -> void:
	$ScoreboardScreen.show()

func _on_main_menu_start() -> void:
	$MainMenu.hide()
	emails = EmailDb.get_email_list()
	email_index = 0
	strikes = 0
	$EmailDisplay.set_email(emails[email_index])
	$EmailDisplay.show()

func quit_game() -> void:
	quit.emit()

func start_tutorial() -> void:
	pass

func _on_email_display_marked_spam() -> void:
	$EmailDisplay.hide()
	if emails[email_index].is_spam:
		$CorrectScreen.show()
	else:
		strikes += 1
		$IncorrectScreen.set_email(emails[email_index])
		$IncorrectScreen.show()

func _on_email_display_replied() -> void:
	$EmailDisplay.hide()
	if !emails[email_index].is_spam:
		$CorrectScreen.show()
	else:
		strikes += 1
		$IncorrectScreen.set_email(emails[email_index])
		$IncorrectScreen.show()

func _on_incorrect_screen_next_screen() -> void:
	$IncorrectScreen.hide()
	if strikes >= 3:
		$GameOver.show()
	else:
		$ScoreboardScreen.show()
		await $ScoreboardScreen.hidden
		next_email()

func _on_correct_screen_next_screen() -> void:
	$CorrectScreen.hide()
	if prev_screen_extra_credit:
		prev_screen_extra_credit = false
		$ScoreboardScreen.show()
		await $ScoreboardScreen.hidden
		next_email()
	elif emails[email_index].is_spam:
		$ExtraCredit.set_email(emails[email_index])
		$ExtraCredit.show()
	else:
		$ScoreboardScreen.show()
		await $ScoreboardScreen.hidden
		next_email()

func _on_extra_credit_correct() -> void:
	$ExtraCredit.hide()
	prev_screen_extra_credit = true
	$CorrectScreen.show()

func _on_extra_credit_incorrect() -> void:
	$ExtraCredit.hide()
	$IncorrectScreen.set_email(emails[email_index], true)
	$IncorrectScreen.show()

func _on_game_over_go_to_menu() -> void:
	$GameOver.hide()
	$MainMenu.show()

func _on_game_won_go_to_menu() -> void:
	$GameWon.hide()
	$MainMenu.show()
