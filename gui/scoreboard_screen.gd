extends Control

## Sorts scores first based on score, then multiplier, then username
func score_sort(score1: ScoreEntry, score2: ScoreEntry)->bool:
	if score1.score > score2.score:
		return true
	elif score1.score < score2.score:
		return false
	else:
		if score1.multiplier > score2.multiplier:
			return true
		elif score1.multiplier < score2.multiplier:
			return false
		else:
			return score1.username[0] > score2.username[0]

## Populates the scoreboard with scores
func show_scoreboard(in_game: bool = true)->void:
	show()
	$Scores.text = "[color=#534582]" ## Sets text color
	var scores: Array[ScoreEntry] = Scoreboard.get_scores()
	if Scoreboard.current_score != null && in_game: ## If in game, also include current score
		scores.append(Scoreboard.current_score)
	scores.sort_custom(score_sort) ## Sort the scores
	var num: int = 0
	var current_score_index: int = -1
	for score in scores:
		if score == Scoreboard.current_score:
			current_score_index = num
			$Scores.text += "[color=#2e8b57]" ## Change text color if showing current score
		$Scores.text += str(num+1)+". "+score.username+": "+str(score.score)+"\n" ## Sets score text line
		if score == Scoreboard.current_score:
			$Scores.text += "[/color]" ## Revert color after if showing current score
		num += 1
		if num > 9: ## If top 10 are shown, enter this
			if Scoreboard.current_score != null && in_game && current_score_index == -1: ## Runs if in game and current score is not top 10
				while current_score_index < 0: ## Keep looping until current is found
					if scores[num] == Scoreboard.current_score:
						current_score_index = num
				if num != 10:
					$Scores.text += "...\n" ## If not 11th score, print this to show gap
				$Scores.text += "[color=#2e8b57]"
				$Scores.text += str(num+1)+". "+scores[num].username+": "+str(scores[num].score)+"\n"
			return
