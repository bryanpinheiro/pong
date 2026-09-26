extends CharacterBody2D

var max_speed: float = 500
var speed: float = 50

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_up", "move_down")
	velocity.y = direction * speed
	move_and_slide()
	
	# delta é o tempo de um frame para outro
	
	if absf(direction) >= 0.1:
		speed = lerpf(speed, max_speed, 1 * delta)
	else:
		speed = lerpf(speed, 0, 50 * delta)


func _on_main_idle_started():
	set_physics_process(false)


func _on_main_ingame_started():
	set_physics_process(true)
