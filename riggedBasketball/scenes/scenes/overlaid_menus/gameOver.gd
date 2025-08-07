extends PauseMenu

@export var TitleLabel : RichTextLabel
@export var ScoreLabel : Label
@export var HighLabel : Label
@export var namePopup : AcceptDialog
@export var leaderboard : LeaderboardDisplay
var scoreText : String

signal updateLeaderboard
signal showLoading

func update(score:int, high:int, newHigh:bool):
	ScoreLabel.text = returnStringWithZeroes(score)
	HighLabel.text = returnStringWithZeroes(high)
	
	var playerName = Config.get_config(&'GameSettings',"playername","�")
	
	match newHigh:
		false:
			TitleLabel.text = "Game Over"
		
		true:
			TitleLabel.text = "[wave amp=50 freq=20][pulse color=yellow]NEW BEST"
			
	
	if playerName != "�":
		var savedHigh = await SilentWolf.Scores.get_top_score_by_player(playerName).sw_top_player_score_complete 
		
		if score > savedHigh:
			emit_signal("showLoading")
			#await SilentWolf.Scores.save_score(playerName, score).sw_save_score_complete
			push_warning("Uncomment this before export")
			emit_signal("updateLeaderboard")
	elif newHigh:
		namePopup.show()
		namePopup.score = score

func returnStringWithZeroes(num:int):
	if num < 10:
		return( "00" + str(num) )
	elif num < 100:
		return( "0" + str(num) )
	else:
		return ( str(num) )


func _on_name_popup_player_name_submitted(name: String) -> void:
	emit_signal("showLoading")
	
	var experimentation = await SilentWolf.Scores.get_top_score_by_player(name).sw_top_player_score_complete
	if experimentation.has("error"):
		Config.set_config(&'GameSettings',"playername",name)
		print("name saved, saving score")
		
		#await SilentWolf.Scores.save_score(name, namePopup.score).sw_save_score_complete
		push_warning("Uncomment this before export")
		emit_signal("updateLeaderboard")
	else:
		namePopup.show()
		namePopup.title = "Name already in use"
