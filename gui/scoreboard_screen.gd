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
			return score1.username > score2.username

## Populates the scoreboard with scores
func show_scoreboard(in_game: bool = true)->void:
	show()
	$Scores.text = ""
	var scores: Array[ScoreEntry] = Scoreboard.get_scores()
	if Scoreboard.current_score != null && in_game:
		scores.append(Scoreboard.current_score)
	scores.sort_custom(score_sort)
	var num: int = 0
	var current_score_index: int = -1
	for score in scores:
		if score == Scoreboard.current_score:
			current_score_index = num
		$Scores.text += str(num+1)+". "+score.username+": "+str(score.score)+"\n"
		num += 1
		if num > 10:
			if Scoreboard.current_score != null && in_game:
				$Scores.text += "...\n"
				while current_score_index < 0:
					if scores[num] == Scoreboard.current_score:
						current_score_index = num
				$Scores.text += str(num+1)+". "+scores[num].username+": "+str(scores[num].score)+"\n"
			return
