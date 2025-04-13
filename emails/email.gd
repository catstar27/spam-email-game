extends Resource
class_name Email
## Represents an email in the game, holding all data needed to form a question

const recipient: String = "help@anywhere.edu" ## Email of the recipient; always the same
@export var sender: String = "johnsmith@example.com" ## Email of the sender
@export var subject: String = "Subject" ## Subject of the email
@export_multiline var body: String = "Text goes here" ## Body of the email
@export var is_spam: bool = true ## Whether this is spam
@export var justification: String = "Justification here" ## Justification for whether this is spam
@export var false_justifications = "False Justification 1/False Justification 2/False Justification 3" ## False justifications separated by slashes
