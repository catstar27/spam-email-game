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

func write_score(entry: ScoreEntry)->void:
	var db : SQLite = SQLite.new()
	db.path = "res://data.db"
	db.open_db()
	var dict = {"username" = entry.username, "score" = entry.score, "multiplier" = entry.multiplier}
	var result = db.insert_row("scoring", dict)
	if !result:
		print("Insert Failed")
		

func get_scores()->Array[ScoreEntry]:
	var db : SQLite = SQLite.new()
	db.path = "res://data.db"
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
