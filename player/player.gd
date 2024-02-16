extends CharacterBody2D

@export var acceleration = 512
@export var max_velocity = 64
@export var friction = 256
@export var gravity = 200
@export var jump_force = 128
@export var max_fall_velocity = 128


func _ready():
	pass


func _physics_process(delta):
	move(delta)


func is_moving(input_axis):
	return input_axis != 0


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, max_fall_velocity, gravity * delta )


func apply_acceleration(delta, input_axis):
	velocity.x = move_toward(velocity.x, input_axis * max_velocity, acceleration * delta)


func apply_friction(delta):
	velocity.x = move_toward(velocity.x, 0, friction * delta)


func jump_check():
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			jump(jump_force)


func jump(force):
	velocity.y = -force


func move(delta):
		
	apply_gravity(delta)
	
	var input_axis = Input.get_axis("move_left", "move_right")
	
	if is_moving(input_axis):
		apply_acceleration(delta, input_axis)
	else:
		apply_friction(delta)
	
	jump_check()
	
	move_and_slide()
