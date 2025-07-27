extends Node3D

@export var max_health: int = 100
var health: int:
	set(new_health):
		health = new_health
		clamp(health, 0, max_health)
		health_label.text = str(health) + "/" + str(max_health)
		_set_label_color()
		if health < 1:
			get_tree().reload_current_scene()
	get:
		return health

@onready var health_label: Label3D = $HealthLabel

func _ready() -> void:
	health = max_health

func take_damage(damage: int) -> void:
	health -= damage

func _set_label_color():
	if health > max_health * 0.8:
		$HealthLabel.modulate = Color.GREEN
	elif health > max_health * 0.6:
		$HealthLabel.modulate = Color.YELLOW_GREEN
	elif health > max_health * 0.4:
		$HealthLabel.modulate = Color.YELLOW
	elif health > max_health * 0.2:
		$HealthLabel.modulate = Color.ORANGE
	else:
		$HealthLabel.modulate = Color.RED
