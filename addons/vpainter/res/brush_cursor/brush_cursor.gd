@tool
extends MeshInstance3D


var plugin:EditorPlugin
var user_input
var raycast

func _ready() -> void:
	hide()
	await get_tree().create_timer(0.1).timeout

	plugin.edit_mode_changed.connect(on_edit_mode_changed)
	user_input = plugin.user_input
	raycast = plugin.raycast
	user_input.mouse_moved.connect(on_mouse_moved)

func on_mouse_moved() -> void:
	position = raycast.hit_position
	if raycast.is_hit and !visible:
		show()
	elif !raycast.is_hit and visible:
		hide()


func on_edit_mode_changed(value:bool) -> void:
	if value:
		show()
	else:
		hide()


func on_brush_size_changed(value:float) -> void:
	value = clamp(value, 0, 10)
	scale = Vector3.ONE * value


func on_brush_opacity_changed(value:float) -> void:
	value = clamp(value, 0, 1)
	material_override.set("shader_parameter/max_opacicty", value)

