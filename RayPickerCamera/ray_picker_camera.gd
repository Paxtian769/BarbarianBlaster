extends Camera3D


@export var grid_map: GridMap
@export var turret_manager: Node3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bank_control: MarginContainer = $"../BankControl"


func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 100.0
	ray_cast_3d.force_raycast_update()
	if ray_cast_3d.is_colliding():
		var target_object = ray_cast_3d.get_collider()
		if target_object is GridMap:
			var collision_point = ray_cast_3d.get_collision_point()
			var cell = grid_map.local_to_map(collision_point)
			if grid_map.get_cell_item(cell) == 0:
				if bank_control.gold >= turret_manager.turret_cost:
					Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
					if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
						grid_map.set_cell_item(cell, 1)
						turret_manager.build_turret(grid_map.map_to_local(cell))
						bank_control.gold -= turret_manager.turret_cost
						Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
