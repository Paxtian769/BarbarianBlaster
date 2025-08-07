extends MarginContainer


@onready var label: Label = $GoldLabel

@export var starting_gold: int = 150


var gold: int:
	set(new_gold):
		gold = new_gold
		if gold < 0:
			gold = 0
		label.text = "Gold: " + str(gold)


func _ready() -> void:
	gold = starting_gold
