extends Node3D

@onready var interactLabel = $Label3D


func _ready():
	interactLabel.visible = false



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "CharacterBody3D":
		interactLabel.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "CharacterBody3D":
		interactLabel.visible = false
