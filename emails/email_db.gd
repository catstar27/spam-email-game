extends Node

## Gets the list of emails from the database
func get_email_list()->Array[Email]:
	var db : SQLite = SQLite.new() ## To open the database
	db.path = "user://data.db"
	db.open_db()
	var emails: Array[Email] = []
	var result = db.query("SELECT sender, subject, body, is_spam, justification, false_justifications from questions")
	var results = db.query_result ## Holds all rows in the email table
	if result:
		for row in results: ## initializes each email as an in game question and adds them to the array
			var email = Email.new()
			email.sender = row["sender"]
			email.subject = row["subject"]
			email.body = row["body"]
			email.is_spam = row["is_spam"]
			email.justification = row["justification"]
			email.false_justifications = row["false_justifications"]
			emails.append(email)
	else:
		print("Query Failed")
	db.close_db()
	return emails ## Return array of all emails found
