extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var camera := get_parent() as CameraControllerBase
	if not is_instance_valid(camera) or not camera.current or not camera.draw_camera_logic:
		hide()
		return
	else:
		show()
		text = str(get_parent().name)
		text += "\n"
		text += str(round((get_parent() as Node3D).global_position))
		text += "\n"
		text += str(round((get_parent().target as Vessel).global_position))
		text += "\n"
		text += str(round( 1.0 / _delta ))
		text += "\n"
		text += str(Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
			).limit_length(1.0))
	
