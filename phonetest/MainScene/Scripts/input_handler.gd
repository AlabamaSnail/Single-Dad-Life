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
			PlayerValues.isMenuOpen = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			PhoneUI.find_child("SmallPhone").visible = true
		else:
			if ExitMenuUi.visible:
				ExitMenuUi.visible = false
				OnScreenUI.visible = true
				PlayerValues.isMenuOpen = false
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				if not PlayerValues.isMenuOpen:
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					PlayerValues.isMenuOpen = true
					ExitMenuUi.visible = true
					OnScreenUI.visible = false
		
