extends Node3D

@onready var interactLabel = $Label3D
@onready var talkingmenu = $Talking

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if interactLabel.visible:
			talkingmenu.visible = true
			interactLabel.visible = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else: 
			talkingmenu.visible = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "CharacterBody3D":

		interactLabel.visible = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "CharacterBody3D":
		interactLabel.visible = false
		talkingmenu.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
