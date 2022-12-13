tool
extends EditorPlugin
class_name AnimateToTimeline


const autoload_name = "ATTUtils"


var dock


func _enter_tree():
	dock = preload("res://addons/animate_to_timeline/xml_dock.tscn").instance()
	add_control_to_dock(DOCK_SLOT_RIGHT_BR, dock)
	add_autoload_singleton(autoload_name, "res://addons/animate_to_timeline/att_utils.gd")


func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()
	remove_autoload_singleton(autoload_name)
