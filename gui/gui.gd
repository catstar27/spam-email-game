extends Control
class_name GUI

var prev_screen_extra_credit: bool = false ## Whether the previous screen was extra credit

signal quit ## When emitted, the game closes

func _ready() -> void:
	Scoreboard.score_updated.connect(set_score_label)

## Connected to the main menu start button. Gets email list and initializes game state
func start_game(username: String) -> void:
	Scoreboard.new_score(username)
	var emails: Array[Email] = EmailDb.get_email_list()
	emails.shuffle()
	$EmailDisplay.email_list = emails
	$EmailDisplay.index = -1
	$EmailDisplay.next_email()
	$ColorRect/ScoreLabel.show()

func quit_game() -> void:
	quit.emit()

## Shows the scoreboard and waits for it to close before emitting the given signal
func show_scoreboard(next_signal: Signal)->void:
	$ScoreboardScreen.show_scoreboard()
	await $ScoreboardScreen.hidden
	next_signal.emit()

## Sets the score label text by accessing the current score
func set_score_label()->void:
	var score: ScoreEntry = Scoreboard.current_score
	$ColorRect/ScoreLabel.text = "Score:\n"+str(score.score)+"\nMultiplier:\nx"+str(score.multiplier)+"\n"+"Strikes:\n"
	for i in range(0, score.strikes):
		$ColorRect/ScoreLabel.text += "X"

func save_score()->void:
	Scoreboard.write_score(Scoreboard.current_score)
