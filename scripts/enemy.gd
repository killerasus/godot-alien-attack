extends Area2D

signal died

@export var speed = Vector2(200, 200)

func _physics_process(delta):
	global_position.x -= speed.x*delta


func die():
	emit_signal("died")
	queue_free()


func _on_body_entered(body): # only the player is a physics body
	die()
	body.take_damage()
