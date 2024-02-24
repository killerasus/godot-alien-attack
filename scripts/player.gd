extends CharacterBody2D

@export var thrust_speed : Vector2 = Vector2(250, 250)
@export var lives : int = 3
var rocket_scene = preload("res://scenes/rocket.tscn")
@onready var rocket_container = $RocketContainer #same as get_node("RocketContainer")
@onready var rocket_fired_sound = $RocketFired
@onready var rocket_timeout = $RocketTimeout

signal took_damage

func shoot() :
	var rocket_instance = rocket_scene.instantiate()
	rocket_instance.global_position = Vector2(global_position.x + 80, global_position.y)
	rocket_container.add_child(rocket_instance)
	rocket_fired_sound.play()
	rocket_timeout.start()

func _process(_delta):
	if Input.is_action_just_pressed("fire") and rocket_timeout.is_stopped() :
		shoot()

func _physics_process(_delta):
	velocity = Vector2(0,0)
	
	if Input.is_action_pressed("move_up") :
		velocity.y = -thrust_speed.y
	elif Input.is_action_pressed("move_down") :
		velocity.y = thrust_speed.y
	if Input.is_action_pressed("move_right") :
		velocity.x = thrust_speed.x
	elif Input.is_action_pressed("move_left") :
		velocity.x = -thrust_speed.x
	
	move_and_slide()
	
	var limits = get_viewport_rect().size
	global_position = global_position.clamp(Vector2(0,0), limits)
	
func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
