extends Node

var current_score: ScoreEntry

signal score_updated

## Starts recording a new score
func new_score(username: String)->void:
	current_score = ScoreEntry.new()
	current_score.username = username

## Increments score based on the correctness and type of the question
func answer_given(is_correct: bool, is_extra_credit: bool = false)->void:
	if is_correct:
		if !is_extra_credit:
			current_score.score += 100*current_score.multiplier
		current_score.multiplier += 1
	elif !is_correct && !is_extra_credit:
		current_score.strikes += 1
		current_score.multiplier = 1
	score_updated.emit()

## Writes the given score into the database
func write_score(entry: ScoreEntry)->void:
	var db : SQLite = SQLite.new()
	db.path = "user://data.db"
	db.open_db()
	var dict = {"username" = entry.username, "score" = entry.score, "multiplier" = entry.multiplier}
	var result = db.insert_row("scoring", dict)
	if !result:
		print("Insert Failed")

## Gets the scores from the database
func get_scores()->Array[ScoreEntry]:
	var db : SQLite = SQLite.new()
	db.path = "user://data.db"
	db.open_db()
	var scores: Array[ScoreEntry] = []
	var result = db.query("SELECT username, score, multiplier from scoring")
	var results = db.query_result
	if result:
		for row in results:
			var score = ScoreEntry.new()
			score.username = row["username"]
			score.score = row["score"]
			score.multiplier = row["multiplier"]
			scores.append(score)
	else:
		print("Query Failed")
	db.close_db()
	return scores
