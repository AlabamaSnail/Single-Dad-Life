extends Node2D

@onready var StartingMenu = $StartingMenu
@onready var CharacterMenu = $CharacterMenu
@onready var OptionsMenu = $OptionsMenu


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		StartingMenu.visible = true
		if OptionsMenu.visible == true:
			OptionsMenu.visible = false
		if CharacterMenu.visible == true:
			CharacterMenu.visible = false


func _on_start_button_pressed() -> void:
	StartingMenu.visible =  false
	CharacterMenu.visible = true


func _on_quit_game_button_pressed() -> void:
	get_tree().quit()


func _on_options_button_pressed() -> void:
	StartingMenu.visible =  false
	OptionsMenu.visible = true
