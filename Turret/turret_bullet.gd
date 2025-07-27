extends Area3D


@export var speed: float = 30.0
var direction := Vector3.FORWARD

var despawn_timer := Timer.new()

const damage: int = 25

func _ready() -> void:
	add_child(despawn_timer)
	despawn_timer.one_shot = true
	despawn_timer.wait_time = 2.0
	despawn_timer.timeout.connect(_on_timer_timeout)
	despawn_timer.start()


func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * delta


func set_direction(new_direction: Vector3) -> void:
	direction = new_direction


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Enemy"):
		area.take_damage(damage)
		queue_free()
