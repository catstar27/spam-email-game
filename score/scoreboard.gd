extends Node

var current_score: ScoreEntry

func new_score(username: String)->void:
	current_score = ScoreEntry.new()
	current_score.username = username

func answer_given(is_correct: bool, is_extra_credit: bool = false)->void:
	if is_correct:
		current_score.multiplier += 1
		if !is_extra_credit:
			current_score.score += 100*current_score.multiplier
	elif !is_correct && !is_extra_credit:
		current_score.multiplier = 0

## TODO
func get_scores()->Array[ScoreEntry]:
	return []
