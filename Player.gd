extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var GRAVITY = 10 #membuat variabel gravity di set ke 10
var velocity  = Vector2()
export var Limit_falling_speed = 15
export var move_speed = 5
export var JUMP_POWER = 8
var jump_pressed
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	
func _fixed_process(delta):
	var movement = Vector2(0, velocity.y+GRAVITY*delta)
	#input key horizontal, axis
	var left_input = Input.is_action_pressed("left")
	var right_input = Input.is_action_pressed("right")
	var jump_input = Input.is_action_pressed("jump")
	
	if right_input:
		movement.x = move_speed# variabel sing mbuk set
	elif left_input: #else if
		movement.x = -move_speed
	elif jump_input:
		movement.y = -JUMP_POWER
		jump_pressed = true
	elif jump_input&&!jump_pressed:
		jump_pressed = false
	
	
	
	
	
	
	
	velocity = movement
	if velocity.y > Limit_falling_speed:
		velocity.y = Limit_falling_speed
	var whatsleftofmovement
	whatsleftofmovement = move(velocity)
	if is_colliding():
		var normal = get_collision_normal()
		whatsleftofmovement = normal.slide(whatsleftofmovement)#collision handling
		velocity = normal.slide(velocity)
		move(whatsleftofmovement)
		

