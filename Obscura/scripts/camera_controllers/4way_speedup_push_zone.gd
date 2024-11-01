# Stage 5: 4-way Speedup Push Zone
extends CameraControllerBase


@export var push_ratio := 0.5

@export var pushbox_top_left := -Vector2.ONE * 10.0
@export var pushbox_bottom_right := Vector2.ONE * 10.0
@export var speedup_zone_top_left := -Vector2.ONE * 5.0
@export var speedup_zone_bottom_right := Vector2.ONE * 5.0


func _process(delta: float) -> void:
	if !current:
		return

	var push_left := global_position.x + pushbox_top_left.x
	var push_right := global_position.x + pushbox_bottom_right.x
	var speedup_left := global_position.x + speedup_zone_top_left.x
	var speedup_right := global_position.x + speedup_zone_bottom_right.x

	var target_x := target.global_position.x
	if target_x <= push_left or target_x >= push_right:
		global_position.x += target.velocity.x * delta
	elif (target_x < speedup_left and signf(target.velocity.x) < 0) or (target_x > speedup_right and signf(target.velocity.z) > 0):
		global_position.x += target.velocity.x * push_ratio * delta

	var push_top := global_position.z + pushbox_top_left.y
	var push_bottom := global_position.z + pushbox_bottom_right.y
	var speedup_top := global_position.z + speedup_zone_top_left.y
	var speedup_bottom := global_position.z + speedup_zone_bottom_right.y

	var target_z := target.global_position.z
	if target_z <= push_top or target_z >= push_bottom:
		global_position.z += target.velocity.z * delta
	elif (target_z < speedup_top and signf(target.velocity.z) < 0) or (target_z > speedup_bottom and signf(target.velocity.z) > 0):
		global_position.z += target.velocity.z * push_ratio * delta

	if draw_camera_logic:
		draw_logic()
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))

	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_end()

	material = material.duplicate()
	material.albedo_color = Color.DIM_GRAY

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_end()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(mesh_instance)
	mesh_instance.global_basis = Basis.IDENTITY
	mesh_instance.global_position.y = target.global_position.y

	#mesh is freed after one update of _process
	get_tree().process_frame.connect(mesh_instance.queue_free)
