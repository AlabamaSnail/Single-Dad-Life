extends Node


const HAPPINESS_DECAY_TIME := 300.0  # 5 minutes in seconds
var happiness_decay_rate := 100.0 / HAPPINESS_DECAY_TIME  # How much hunger drops per second

func _process(delta: float) -> void:
	if PlayerValues.Happiness > 0:
		PlayerValues.Happiness -= happiness_decay_rate * delta
		PlayerValues.Happiness = max(PlayerValues.Happiness, 0)  # Clamp to prevent going below 0
