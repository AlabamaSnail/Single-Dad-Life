extends Node2D


func _on_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	self.visible = false
	
