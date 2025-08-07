extends Node3D

var bullet_scene: PackedScene = load("res://Turret/turret_bullet.tscn")
var closest_enemy

@onready var bullet_timer: Timer = $BulletTimer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


var enemy_path: Path3D:
	set(new_enemy_path):
		enemy_path = new_enemy_path

func _physics_process(_delta: float) -> void:
	var enemies = enemy_path.get_children()
	closest_enemy = enemies.back()
	for enemy in enemies:
		if enemy.is_in_group("Enemy"):
			if not closest_enemy:
				closest_enemy = enemy
			else:
				var dist_to_closest = abs(global_position - closest_enemy.global_position)
				var dist_to_enemy = abs(global_position - enemy.global_position)
				if dist_to_enemy < dist_to_closest:
					closest_enemy = enemy
	if closest_enemy.is_in_group("Enemy"):
		$TurretBase/TurretTop.look_at(closest_enemy.global_position)


func _on_timer_timeout() -> void:
	if closest_enemy and closest_enemy.is_in_group("Enemy"):
		var new_bullet = bullet_scene.instantiate()
		new_bullet.position = $TurretBase/TurretTop/FirePosition.global_position
		add_child(new_bullet)
		new_bullet.direction = closest_enemy.global_position - global_position
		animation_player.play("Fire")
