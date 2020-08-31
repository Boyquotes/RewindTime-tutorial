extends KinematicBody2D

var speed = 100
var velocity = Vector2()

# Rewind
var recording = true
var rewinding = false
var pos = []
var rot = []
var memory = 250

func _process(delta: float) -> void:
	if recording:
		rotation = (get_global_mouse_position() - position).angle()
		
		velocity = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
		
		position += velocity * speed * delta
	
	if Input.is_action_pressed("space"):
		recording = false
		rewinding = true
	else:
		recording = true
		rewinding = false
	
	rewind()

func rewind():
	if recording:
		pos.append(position)
		rot.append(rotation)
		if pos.size() > memory:
			pos.remove(0)
			rot.remove(0)
		print(pos.size())
	elif rewinding:
		if pos.size() > 0:
			position = pos[pos.size() - 1]
			rotation = rot[rot.size() - 1]
			pos.remove(pos.size() - 1)
			rot.remove(rot.size() - 1)
		else:
			recording = true
			rewinding = false
		print(pos.size())




































