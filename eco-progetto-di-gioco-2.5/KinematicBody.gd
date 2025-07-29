extends CharacterBody3D
var walk_speed = 5.0
var run_speed = 2.0
var bike_speed = 9.0
var surf_speed = 0.0
var gravity_strength = 9.8
const GRID_SIZE = 1.0
var initial_position = Vector3.ZERO
var input_direction = Vector3.ZERO
var is_moving = false
var percent_moved_to_next_grid = 0.0
var ray_length = 1.5
var sub_ray_length = 0.7
var gravity = Vector3.DOWN
var bike_mode = false
var surf_mode = false
@onready var raycast = $RayCast
@onready var subraycast = $SubRayCast
@onready var gravityraycast = $GravityRayCast
@onready var climbraycast = $ClimbRayCast
@onready var climbraycast2 = $ClimbRayCast2
signal dialogue_started
signal roteate
signal recharge_lines
func _ready():
	initial_position = position
	raycast.enabled = true
	subraycast.enabled = true
	climbraycast.enabled = true
	gravityraycast.enabled = true

	
	
func _physics_process(delta):
	apply_gravity(delta)
	if is_moving:
		move(delta)
	else:
		process_player_input()
	if raycast.is_colliding():
		var collider =raycast.get_collider()
		if collider != null and Input.is_action_just_pressed("ui_check") and "StaticBody3D" in collider.name:
			emit_signal("dialogue_started")
			set_physics_process(false)
			raycast.enabled = false
			var collision_point = raycast.get_collision_point()
			if initial_position.x < collision_point.x:
				emit_signal("roteate")
				
	
	

	

	



func process_player_input():
	input_direction = Vector3.ZERO

		
	
	if Input.is_action_pressed("ui_right"):
		input_direction.z += 1
		raycast.set_target_position(Vector3(0, 0, 0.7))
		subraycast.set_target_position(Vector3(0, 0, 0.5))
		climbraycast.set_position(Vector3(0, 0.5, 0.7))
		climbraycast2.set_position(Vector3(0, 0, 0.7))
		raycast.force_raycast_update()
		subraycast.force_raycast_update()
		climbraycast.force_raycast_update()
		climbraycast2.force_raycast_update()
		if climbraycast.is_colliding() and not raycast.is_colliding():
			var collider = climbraycast.get_collider()
			var collision_point = climbraycast.get_collision_point()
			if "GridMap3" in collider.name:
				input_direction.y += collision_point.y -position.y +0.13
		if climbraycast2.is_colliding() and not climbraycast.is_colliding():
			var collider = climbraycast2.get_collider()
			var collision_point = climbraycast2.get_collision_point()
			if "GridMap3" in collider.name:
				input_direction.y = collision_point.y -position.y +0.13
	elif Input.is_action_pressed("ui_left"):
		input_direction.z -= 1
		raycast.set_target_position(Vector3(0, 0, -0.7))
		subraycast.set_target_position(Vector3(0, 0, -0.5))
		climbraycast.set_position(Vector3(0, 0.5, -0.7))
		climbraycast2.set_position(Vector3(0, 0, -0.7))
		raycast.force_raycast_update()
		subraycast.force_raycast_update()
		climbraycast.force_raycast_update()
		climbraycast2.force_raycast_update()
		if climbraycast.is_colliding() and not raycast.is_colliding():
			var collider = climbraycast.get_collider()
			var collision_point = climbraycast.get_collision_point()
			if "GridMap3" in collider.name:
				input_direction.y += collision_point.y -position.y +0.13
		if climbraycast2.is_colliding() and not climbraycast.is_colliding():
			var collider = climbraycast2.get_collider()
			var collision_point = climbraycast2.get_collision_point()
			if "GridMap3" in collider.name:
				input_direction.y = collision_point.y -position.y +0.13
	elif Input.is_action_pressed("ui_down"):
		input_direction.x -= 1
		raycast.set_target_position(Vector3(-0.7, 0, 0))
		subraycast.set_target_position(Vector3(-0.5, 0, 0))
		climbraycast.set_position(Vector3(-0.7, 0.5, 0))
		climbraycast2.set_position(Vector3(-0.7, 0, 0))
		raycast.force_raycast_update()
		subraycast.force_raycast_update()
		climbraycast.force_raycast_update()
		climbraycast2.force_raycast_update()
		if climbraycast.is_colliding() and not raycast.is_colliding():
			var collider = climbraycast.get_collider()
			var collision_point = climbraycast.get_collision_point()
			if "GridMap3" in collider.name:
				input_direction.y += collision_point.y -position.y +0.13
		if climbraycast2.is_colliding() and not climbraycast.is_colliding():
			var collider = climbraycast2.get_collider()
			var collision_point = climbraycast2.get_collision_point()
			if "GridMap3" in collider.name:
				input_direction.y = collision_point.y -position.y +0.13
	elif Input.is_action_pressed("ui_up"):
		input_direction.x += 1
		raycast.set_target_position(Vector3(0.7, 0, 0))
		subraycast.set_target_position(Vector3(0.5, 0, 0))
		climbraycast.set_position(Vector3(0.7, 0.5, 0))
		climbraycast2.set_position(Vector3(0.7, 0, 0))
		raycast.force_raycast_update()
		subraycast.force_raycast_update()
		climbraycast.force_raycast_update()
		climbraycast2.force_raycast_update()
		if climbraycast.is_colliding() and not raycast.is_colliding():
			var collider = climbraycast.get_collider()
			var collision_point = climbraycast.get_collision_point()
			if "GridMap3" in collider.name:
				input_direction.y += collision_point.y -position.y +0.13
		if climbraycast2.is_colliding() and not climbraycast.is_colliding():
			var collider = climbraycast2.get_collider()
			var collision_point = climbraycast2.get_collision_point()
			if "GridMap3" in collider.name:
				input_direction.y = collision_point.y -position.y +0.13
	
	input_direction = input_direction.normalized()  # Normalizza la direzione

	
	
	
	if input_direction != Vector3.ZERO:
		initial_position = position
		is_moving = true
		gravityraycast.force_raycast_update()

	if Input.is_action_just_pressed("ui_y"):
		print(global_transform.origin.y)
	if Input.is_action_just_pressed("ui_x"):
		print(global_transform.origin.x)
	if Input.is_action_just_pressed("ui_y"):
		print(global_transform.origin.y)
	


	
	if raycast.is_colliding() and is_moving:
		input_direction = Vector3.ZERO
		print("wall")
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
			$AudioStreamPlayer3D.play()
		
	if subraycast.is_colliding() and is_moving:
		var collider = subraycast.get_collider()
		if collider.name == "WaterGridMap" and not surf_mode:
			input_direction = Vector3.ZERO
			
	

	if subraycast.is_colliding():
		var collider = subraycast.get_collider()
		if collider.name == "WaterGridMap" and Input.is_action_just_pressed("ui_surf") and not surf_mode and not raycast.is_colliding():
			var collision_point = subraycast.get_collision_point()
			# Allinea la posizione del giocatore al centro della cella puntata
			position.x = round(collision_point.x / GRID_SIZE) * GRID_SIZE
			position.z = round(collision_point.z / GRID_SIZE) * GRID_SIZE
			surf_mode = true
			if bike_mode:
				bike_mode = false
			print("surf mode on")
			
		if "EarthGridMap" in collider.name and  surf_mode:
			input_direction = Vector3.ZERO
		if "EarthGridMap" in collider.name and Input.is_action_just_pressed("ui_surf") and surf_mode and not raycast.is_colliding():
			var collision_point = subraycast.get_collision_point()
			# Allinea la posizione del giocatore al centro della cella puntata
			position.x = round(collision_point.x / GRID_SIZE) * GRID_SIZE
			position.z = round(collision_point.z / GRID_SIZE) * GRID_SIZE
			surf_mode = false
			print("surf mode off")
			
	
	if Input.is_action_just_pressed("ui_bike") and not surf_mode:
		bike_mode = !bike_mode
	
	
	
func apply_gravity(delta):
	gravityraycast.force_raycast_update()
	if position.y > -100 and not gravityraycast.is_colliding():  # Presupponendo che l'altezza del terreno sia 0
		position.y += gravity.y * delta * 9 # Gravitazione continua verso il basso
	else:
		var collision_point = gravityraycast.get_collision_point()
		var collider = gravityraycast.get_collider()
		position.y = collision_point.y +0.13




	
func move(delta):
		percent_moved_to_next_grid += walk_speed * delta
		if percent_moved_to_next_grid >= 1.0:
			position.x = round(initial_position.x + (GRID_SIZE * input_direction.x))
			position.z = round(initial_position.z + (GRID_SIZE * input_direction.z))
			position.y = initial_position.y + (GRID_SIZE * input_direction.y)
			percent_moved_to_next_grid = 0.0
			is_moving = false
		else:
			position.x = initial_position.x + (GRID_SIZE * input_direction.x * percent_moved_to_next_grid) 
			position.z = initial_position.z + (GRID_SIZE * input_direction.z * percent_moved_to_next_grid)
			position.y = initial_position.y + (GRID_SIZE * input_direction.y * percent_moved_to_next_grid)
		if Input.is_action_pressed("ui_run") and is_moving and not bike_mode and not surf_mode:
			percent_moved_to_next_grid += run_speed * delta
		if bike_mode and is_moving:
			percent_moved_to_next_grid += bike_speed * delta
		if surf_mode and is_moving:
			percent_moved_to_next_grid += surf_speed * delta
			
			
			
func _on_TextBox_dialogue_finished():
	set_physics_process(true)
	raycast.enabled = true
	
