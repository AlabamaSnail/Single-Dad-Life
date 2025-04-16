extends Node3D

@onready var interactLabel = $Label3D
@onready var talkingMenu = $Talking
@onready var npcText = $Talking/Panel/NPCText
@onready var optionsContainer = $Talking/Panel/VBoxContainer

var jsonData = {}
var currentDialog = {}
var dialogPath = []
var visitedPaths = {}
var currentDialogueFile = "res://NPCs/Dylan/dialogues/dialogue1.json"  # Default path

func _ready():
	load_dialogue(currentDialogueFile)
	talkingMenu.visible = false

func load_dialogue(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		jsonData = JSON.parse_string(file.get_as_text())
		currentDialog = jsonData
		dialogPath.clear()
		file.close()
	else:
		push_error("Could not load dialogue from: " + path)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and interactLabel.visible:
		_show_dialog()
		interactLabel.visible = false
		PlayerValues.isMenuOpen = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "CharacterBody3D":
		interactLabel.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "CharacterBody3D":
		interactLabel.visible = false
		talkingMenu.visible = false
		PlayerValues.isMenuOpen = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _show_dialog():
	talkingMenu.visible = true
	npcText.text = currentDialog.get("npc", "")

	# Clear old buttons
	for child in optionsContainer.get_children():
		child.queue_free()

	var responses = currentDialog.get("responses", [])

	for response in responses:
		var path_id = _get_path_id(response["text"])
		var btn = Button.new()
		btn.text = response["text"]

		if visitedPaths.has(path_id):
			btn.modulate = Color(0.6, 0.6, 0.6)  # Gray out visited buttons

		btn.connect("pressed", Callable(self, "_on_response_selected").bind(response, path_id))
		optionsContainer.add_child(btn)

	if responses.size() > 0 and responses.size() == _count_visited(responses):
		var restartBtn = Button.new()
		restartBtn.text = "Restart Conversation"
		restartBtn.connect("pressed", Callable(self, "_restart_conversation"))
		optionsContainer.add_child(restartBtn)

	var leaveBtn = Button.new()
	leaveBtn.text = "Leave"
	leaveBtn.connect("pressed", Callable(self, "_leave_conversation"))
	optionsContainer.add_child(leaveBtn)

func _on_response_selected(response, path_id):
	visitedPaths[path_id] = true
	dialogPath.append(response)
	currentDialog = response
	_show_dialog()

func _leave_conversation():
	talkingMenu.visible = false
	PlayerValues.isMenuOpen = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _restart_conversation():
	for response in currentDialog.get("responses", []):
		var path_id = _get_path_id(response["text"])
		visitedPaths.erase(path_id)

	_show_dialog()

func _get_path_id(text: String) -> String:
	var path = ""
	for step in dialogPath:
		path += step.get("text", "") + "->"
	path += text
	return path.sha256_text()

func _count_visited(responses: Array) -> int:
	var count = 0
	for r in responses:
		var path_id = _get_path_id(r["text"])
		if visitedPaths.has(path_id):
			count += 1
	return count

func change_dialogue_stage(stage: int):
	currentDialogueFile = "res://dialogues/dialogue%d.json" % stage
	load_dialogue(currentDialogueFile)
