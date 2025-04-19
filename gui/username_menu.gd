extends Control

signal username_entered(username: String)

func check_name()->void:
	if $UsernameEntry.text != "":
		hide()
		username_entered.emit($UsernameEntry.text)
		$UsernameEntry.text = ""
	else:
		$VBoxContainer/WarningLabel.show()
