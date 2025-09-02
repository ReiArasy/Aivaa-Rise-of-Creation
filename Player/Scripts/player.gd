extends Node2D

var move_speed: float = 100.0

func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# Langsung geser posisi node
	position += direction.normalized() * move_speed * delta
