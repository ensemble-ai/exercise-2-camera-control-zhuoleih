# Stage 3 Position Lock and Lerp Smoothing
extends CameraControllerBase

const CROSS_SIZE = 5.0


@export_range(0.1, 0.4, 0.01) var follow_speed := 0.4
@export var catchup_speed := 50.0
@export var leash_distance := 10.0


func _process(delta: float) -> void:
	if !current:
		return

	assert(is_instance_valid(target))

	var target_pos := Vector2(target.global_position.x, target.global_position.z)
	var self_pos := Vector2(global_position.x, global_position.z)
	var distance := self_pos.distance_to(target_pos)

	if target.velocity.is_zero_approx():
		self_pos = self_pos.move_toward(target_pos, catchup_speed * delta)
	elif not is_equal_approx(distance, leash_distance) and distance < leash_distance:
		self_pos = self_pos.move_toward(target_pos, target.velocity.length() * follow_speed * delta)
		#self_pos = self_pos.move_toward(target_pos, 25 * delta)
	else:
		self_pos = target_pos + (self_pos - target_pos).normalized() * (leash_distance)

	global_position.x = self_pos.x
	global_position.z = self_pos.y

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

	const cross_extents := CROSS_SIZE * 0.5

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-cross_extents, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(cross_extents, 0, 0))
	immediate_mesh.surface_end()

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -cross_extents))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, cross_extents))
	immediate_mesh.surface_end()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(mesh_instance)
	mesh_instance.global_basis = Basis.IDENTITY
	mesh_instance.global_position.y = target.global_position.y

	## mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
