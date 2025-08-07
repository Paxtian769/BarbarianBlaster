extends Node

@export var game_length := 30.0
@export var spawn_time_curve: Curve
@export var enemy_health_curve: Curve

@onready var level_timer = $LevelTimer


signal end_game


func _ready():
	level_timer.start(game_length)

func game_progress_ratio() -> float:
	return 1.0 - (level_timer.time_left / game_length)

func get_spawn_time() -> float:
	return spawn_time_curve.sample(game_progress_ratio())

func get_health_value() -> int:
	return int(enemy_health_curve.sample(game_progress_ratio()))

func _on_level_timer_timeout():
	end_game.emit()
