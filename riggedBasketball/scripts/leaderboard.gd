extends Node

func _ready() -> void:
  SilentWolf.configure({
	"api_key": "40wQNTTuEb3fbYrc6OyznatbY39WFD0g9uvQPT2G",
	"game_id": "riggedbasketball",
	"log_level": 1
  })

  SilentWolf.configure_scores({
	"open_scene_on_close": "res://scenes/MainPage.tscn"
  })
