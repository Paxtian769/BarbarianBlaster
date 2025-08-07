extends CanvasLayer

@onready var star_1 = $CenterContainer/PanelContainer/VBoxContainer/StarHBoxContainer/Star1TextureRect
@onready var star_2 = $CenterContainer/PanelContainer/VBoxContainer/StarHBoxContainer/Star2TextureRect
@onready var star_3 = $CenterContainer/PanelContainer/VBoxContainer/StarHBoxContainer/Star3TextureRect

@export var base: Node3D
@export var bank: MarginContainer


func victory() -> void:
	visible = true
	if base.max_health == base.health:
		star_2.modulate = Color.WHITE
	if bank.gold > 150:
		star_3.modulate = Color.WHITE

func _on_retry_button_pressed():
	get_tree().reload_current_scene()

func _on_quit_button_pressed():
	get_tree().quit()
