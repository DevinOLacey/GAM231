extends Node

var score = 0
@onready var score_lable: Label = $ScoreLable
@onready var slime: CharacterBody2D = $"../slime"


func add_point():
	score += 1
	if is_instance_valid(slime) and not slime.dead:
		slime.scale += Vector2(0.25, 0.5)
	else:
		slime = null
	
	if score < 13:
		score_lable.text = "You collected " + str(score) + " /13 coins."
	elif score == 13:
		score_lable.text = "Congratulations! You collected all the coins!"
