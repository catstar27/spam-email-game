extends Control

signal username_entered(username: String)

## If the text entry is empty, show a warning. Otherwise emit the signal with the text
func check_name()->void:
	if $UsernameEntry.text != "":
		hide()
		username_entered.emit($UsernameEntry.text)
		$UsernameEntry.text = ""
	else:
		$VBoxContainer/WarningLabel.show()
