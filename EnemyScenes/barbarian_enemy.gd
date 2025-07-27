extends PathFollow3D


@export var speed: float = 5.0
@export var max_health: int = 50
var health: int

@onready var base = get_tree().get_first_node_in_group("Base")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bank_control: MarginContainer = $"../../BankControl"
var gold_value: int = 15

func _ready():
	health = max_health


func _process(delta: float) -> void:
	progress += speed * delta
	
	if progress_ratio == 1.0:
		base.take_damage(20)
		queue_free()


func take_damage(damage: int) -> void:
	health -= damage
	animation_player.play("Hit")
	if health <= 0:
		bank_control.gold += gold_value
		queue_free()
