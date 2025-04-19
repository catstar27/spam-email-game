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
	$Scores.text = "[color=#534582]"
	var scores: Array[ScoreEntry] = Scoreboard.get_scores()
	if Scoreboard.current_score != null && in_game:
		scores.append(Scoreboard.current_score)
	scores.sort_custom(score_sort)
	var num: int = 0
	var current_score_index: int = -1
	for score in scores:
		if score == Scoreboard.current_score:
			current_score_index = num
			$Scores.text += "[color=#2e8b57]"
		$Scores.text += str(num+1)+". "+score.username+": "+str(score.score)+"\n"
		if score == Scoreboard.current_score:
			$Scores.text += "[/color]"
		num += 1
		if num > 9:
			if Scoreboard.current_score != null && in_game && current_score_index == -1:
				while current_score_index < 0:
					if scores[num] == Scoreboard.current_score:
						current_score_index = num
				if num != 10:
					$Scores.text += "...\n"
				$Scores.text += "[color=#2e8b57]"
				$Scores.text += str(num+1)+". "+scores[num].username+": "+str(scores[num].score)+"\n"
			return
