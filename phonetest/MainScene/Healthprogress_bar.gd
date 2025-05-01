extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = PlayerValues.Health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.value = PlayerValues.Health
