extends Node3D

@onready var interactLabel = self.get_parent().find_child("Label3D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "CharacterBody3D":
		interactLabel.visible = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "CharacterBody3D":
		interactLabel.visible = false
