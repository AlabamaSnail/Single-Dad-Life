extends Node2D

@onready var HomePage = $HomePage
@onready var MoneyPage = $MakingMoneyPage
@onready var BankingPage = $BankingPage
@onready var websiteUrl = get_node("/root/MainScene/PhoneUI/BigPhone/TopBar/WebsiteURL")

func _on_making_money_button_pressed() -> void:
	MoneyPage.visible = true
	HomePage.visible = false
	BankingPage.visible = false
	websiteUrl.text = "https://www.LiveOffTheGovernment.com/" + str(PlayerValues.PlayerName) + "/Single-Dad-Life"


func _on_banking_button_pressed() -> void:
	MoneyPage.visible = false
	HomePage.visible = false
	BankingPage.visible = true
	websiteUrl.text = "https://www.LocalUnflawedBanking.com/" + str(PlayerValues.PlayerName) + "/Single-Dad-Life"
