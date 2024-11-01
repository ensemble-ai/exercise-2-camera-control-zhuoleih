# Stage 1 Position Lock
extends CameraControllerBase

const CROSS_SIZE = 5.0

func _process(delta: float) -> void:
	if !current:
		return

	assert(is_instance_valid(target))
	global_position.x = target.global_position.x
	global_position.z = target.global_position.z

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
