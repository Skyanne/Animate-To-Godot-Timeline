tool
extends Control


export (NodePath) var animation_player

var animation_player_name: String = "AnimationPlayer"

var crop_buffer: Rect2 = Rect2(0, 0, 0, 0)
var fps: int = 24

func _on_XML_pressed():
	$FileDialog.popup_centered()
	return

func _on_AnimationPlayerInput_text_changed():
	animation_player_name = $VBoxContainer/HBoxContainer2/AnimationPlayerInput.text


func _on_FileDialog_file_selected(path):
	var animations = ATTUtils.atlas_xml_to_timelines(path, crop_buffer, fps)
	
	# Get current animation player
	var animation_player: AnimationPlayer
	var scene_root = get_tree().get_edited_scene_root()
	if scene_root is AnimationPlayer and animation_player_name == scene_root.name:
		animation_player = scene_root
	else:
		animation_player = scene_root.get_node(animation_player_name)

	for animation in animations:
		animation_player.add_animation(animation.name, animation.data)


func _on_CropBufferLeft_value_changed(value):
	crop_buffer.position.x = value


func _on_CropBufferUp_value_changed(value):
	crop_buffer.position.y = value


func _on_CropBufferRight_value_changed(value):
	crop_buffer.size.x = value


func _on_CropBufferDown_value_changed(value):
	crop_buffer.size.y = value


func _on_FPS_value_changed(value):
	fps = value
