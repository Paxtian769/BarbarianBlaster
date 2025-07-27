extends Area3D


func take_damage(damage: int) -> void:
	get_parent().take_damage(damage)
