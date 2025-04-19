extends Resource
class_name ScoreEntry
## Represents the set of score information for one attempt

@export var username: String = "username" ## Name associated with score
@export var multiplier: int = 1 ## Multiplier for next question
@export var score: int = 0 ## Total Score
@export var strikes: int = 0 ## Number of incorrect answers
