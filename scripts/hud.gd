extends Control

@onready var score_label = $Score
@onready var lives_left = $Lives

func set_score_label(new_score):
	score_label.text = "Score: " + str(new_score)

func set_lives_label(new_lives):
	lives_left.text = str(new_lives)
