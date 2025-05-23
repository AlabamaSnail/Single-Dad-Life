extends Node2D

@onready var smallPhoneUI = $SmallPhone 
@onready var BigPhoneUI = $BigPhone

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_phone") and not PlayerValues.isMenuOpen:
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			PlayerValues.isMenuOpen = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			PlayerValues.isMenuOpen = true
		_change_visible()
func _on_button_pressed() -> void:
	if not PlayerValues.isMenuOpen:
		_change_visible()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		PlayerValues.isMenuOpen = true
func _on_close_button_pressed() -> void:
	_change_visible()
	get_node("/root/MainScene/PhoneUI/BigPhone/TopBar/WebsiteURL").text = "https://www.Single-Dad-Life.com/" + str(PlayerValues.PlayerName)
	get_node("/root/MainScene/PhoneUI/BigPhone/Pages/MakingMoneyPage").visible = false
	get_node("/root/MainScene/PhoneUI/BigPhone/Pages/BankingPage").visible = false
	get_node("/root/MainScene/PhoneUI/BigPhone/Pages/HomePage").visible = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	PlayerValues.isMenuOpen = false
	
	
func _change_visible() -> void:
	smallPhoneUI.visible = !smallPhoneUI.visible  
	BigPhoneUI.visible = !BigPhoneUI.visible  
