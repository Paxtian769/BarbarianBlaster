extends Path3D

var barbarian_enemy_scene: PackedScene = load("res://EnemyScenes/barbarian_enemy.tscn")
var enemy_spawns: int = 14

func _spawn_new_enemy():
	if enemy_spawns > 0:
		var new_barbarian_enemy = barbarian_enemy_scene.instantiate()
		add_child(new_barbarian_enemy)
		enemy_spawns -= 1
