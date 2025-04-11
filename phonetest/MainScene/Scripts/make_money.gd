extends Node2D

@onready var progressbar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if progressbar.value >= 100:
		PlayerValues.MoneyInBank += MoneyFromGov.AmountPerFill
		progressbar.value = 0
	else:
		progressbar.value += 10
