extends Node


const HUNGER_DECAY_TIME := 600.0  # 5 minutes in seconds
var hunger_decay_rate := 100.0 / HUNGER_DECAY_TIME  # How much hunger drops per second

func _process(delta: float) -> void:
	if PlayerValues.Hunger > 0:
		PlayerValues.Hunger -= hunger_decay_rate * delta
		PlayerValues.Hunger = max(PlayerValues.Hunger, 0)  # Clamp to prevent going below 0
