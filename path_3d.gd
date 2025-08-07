extends Path3D

var barbarian_enemy_scene: PackedScene = load("res://EnemyScenes/barbarian_enemy.tscn")


@onready var difficulty_manager = $"../DifficultyManager"
@onready var spawn_timer = $SpawnTimer
@onready var victory_layer = $"../VictoryLayer"



func _ready():
	difficulty_manager.end_game.connect(_on_end_game)

func _spawn_new_enemy() -> void:
	var new_barbarian_enemy = barbarian_enemy_scene.instantiate()
	add_child(new_barbarian_enemy)
	new_barbarian_enemy.set_max_health(difficulty_manager.get_health_value())
	new_barbarian_enemy.tree_exited.connect(_enemy_defeated)
	spawn_timer.start(difficulty_manager.get_spawn_time())

func _on_end_game() -> void:
	spawn_timer.stop()

func _enemy_defeated() -> void:
	if spawn_timer.is_stopped():
		for child in get_children():
			if child is PathFollow3D:
				return
		victory_layer.victory()
