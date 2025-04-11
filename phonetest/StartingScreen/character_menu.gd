extends Node2D

@onready var PlayerName = $LineEdit
@onready var TextWarning = $warning


func _on_begin_game_pressed() -> void:
	if len(PlayerName.text) > 3:
		PlayerValues.PlayerName = PlayerName.text
		get_tree().change_scene_to_file("res://MainScene/node_3d.tscn")
	else:
		TextWarning.text = "Player Name Too Short"
		TextWarning.visible = true
