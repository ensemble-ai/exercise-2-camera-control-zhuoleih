# Stage 2 Auto Scroll
extends CameraControllerBase


@export var top_left := Vector2(-10.0, -10.0)
@export var bottom_right := Vector2(10.0, 10.0)
@export var autoscroll_speed := Vector3.RIGHT * 2.0:
	set(v):
		autoscroll_speed = v
		autoscroll_speed.y = 0

func _process(delta: float) -> void:
	if !current:
		return

	translate(autoscroll_speed * delta)

	var right := global_position.x + bottom_right.x
	var left := global_position.x + top_left.x
	var top := global_position.z + top_left.y
	var bottom := global_position.z + bottom_right.y

	if target.global_position.x > right:
		target.global_position.x = right
	if target.global_position.x < left:
		target.global_position.x = left
	if target.global_position.z > bottom:
		target.global_position.z = bottom
	if target.global_position.z < top:
		target.global_position.z = top

	#if is_zero_approx(autoscroll_speed.x):
		#if target.global_position.x > right:
			#target.global_position.x = right
		#
		#if target.global_position.x < left:
			#target.global_position.x = left
	#else:
		#if autoscroll_speed.x < 0:
			#var behind_pos_x := global_position.x + bottom_right.x
			#if target.global_position.x > behind_pos_x:
				#target.global_position.x = behind_pos_x
		#else:
			#var behind_pos_x := global_position.x + top_left.x
			#if target.global_position.x < behind_pos_x:
				#target.global_position.x = behind_pos_x
#
	#if is_zero_approx(autoscroll_speed.z):
		#if target.global_position.z > bottom:
			#target.global_position.z = bottom
		#if target.global_position.z < top:
			#target.global_position.z = top
	#else:
		#if autoscroll_speed.z < 0:
			#if target.global_position.z > bottom:
				#target.global_position.z = bottom
		#else:
			#if target.global_position.z < top:
				#target.global_position.z = top

	if draw_camera_logic:
		draw_logic()

	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	material.cull_mode = BaseMaterial3D.CULL_DISABLED

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))
	immediate_mesh.surface_end()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(mesh_instance)
	mesh_instance.global_basis = Basis.IDENTITY
	mesh_instance.global_position.y = target.global_position.y

	## mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
