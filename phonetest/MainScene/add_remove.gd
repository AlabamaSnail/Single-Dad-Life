extends Node2D

@onready var AmountLabel = $Amount
@onready var MoneyError = $MoneyError

var amount = 0  # Local amount the player is trying to deposit/withdraw

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_amount_label()

# Updates the Amount label with the current amount, always showing $ and defaulting to $0 if no amount
func update_amount_label() -> void:
	AmountLabel.text = "$" + str(amount)  # Simply ensure $ is always displayed, no padding needed

# Add amounts based on button press
func _on_1_pressed() -> void:
	add_amount(1)

func _on_10_pressed() -> void:
	add_amount(10)

func _on_50_pressed() -> void:
	add_amount(50)

func _on_100_pressed() -> void:
	add_amount(100)

func _on_1000_pressed() -> void:
	add_amount(1000)

func _on_5000_pressed() -> void:
	add_amount(5000)

func _on_all_pressed() -> void:
	add_amount(min(PlayerValues.PlayerCash + PlayerValues.MoneyInBank, PlayerValues.PlayerCash + PlayerValues.MoneyInBank))  # Add money from both cash and bank

# Adds amount to the transaction if the player has enough funds in either bank or cash in hand
func add_amount(value: int) -> void:
	if value + amount <= (PlayerValues.PlayerCash + PlayerValues.MoneyInBank):  # Check if the player can afford the amount, considering both cash and bank
		amount += value
		update_amount_label()
	else:
		show_error()

# Resets the amount to 0
func _on_reset_pressed() -> void:
	amount = 0
	update_amount_label()

# Handle deposit action
func _on_deposit_pressed() -> void:
	if amount > 0 and amount <= PlayerValues.PlayerCash:  # Check if the player has enough money in hand to deposit
		PlayerValues.MoneyInBank += amount
		PlayerValues.PlayerCash -= amount
		amount = 0
		update_amount_label()
	else:
		show_error()

# Handle withdraw action
func _on_withdraw_pressed() -> void:
	if amount > 0 and amount <= PlayerValues.MoneyInBank:  # Check if the player has enough money in the bank to withdraw
		PlayerValues.MoneyInBank -= amount
		PlayerValues.PlayerCash += amount
		amount = 0
		update_amount_label()
	else:
		show_error()

# Show an error message if there's insufficient funds
func show_error() -> void:
	MoneyError.visible = true
	await get_tree().create_timer(3.0).timeout
	MoneyError.visible = false
