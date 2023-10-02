extends Node

@export_node_path var label_path : NodePath
var label :
	get:
		return get_node(label_path)
