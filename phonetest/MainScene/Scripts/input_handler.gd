extends Node

@onready var PhoneUI = get_node("/root/MainScene/PhoneUI")
@onready var ExitMenuUi = get_node("/root/MainScene/ExitMenuUI")
@onready var OnScreenUI = get_node("/root/MainScene/ScreenUI")

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		if PhoneUI.find_child("BigPhone").visible:
			PhoneUI.find_child("BigPhone").visible = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			PhoneUI.find_child("SmallPhone").visible = true
		else:
			if ExitMenuUi.visible:
				ExitMenuUi.visible = false
				OnScreenUI.visible = true
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				ExitMenuUi.visible = true
				OnScreenUI.visible = false
	
