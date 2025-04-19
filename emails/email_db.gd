extends Node

func get_email_list()->Array[Email]:
	var db : SQLite = SQLite.new()	
	db.path = "res://data.db"
	db.open_db()
	var emails: Array[Email] = []
	var result = db.query("SELECT sender, subject, body, is_spam, justification, false_justifications from questions")
	var results = db.query_result
	if result:
		for row in results:
			var email = Email.new()
			email.sender = row["sender"]
			email.subject = row["subject"]
			email.body = row["body"]		
			email.is_spam = row["is_spam"]
			email.justification = row["justification"]
			email.false_justifications = row["false_justifications"]
			print(email)
			emails.append(email)
	else:
		print("Query Failed")
	db.close_db()
	return emails
