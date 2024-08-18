extends Node2D

func playFloor(thisFloor):
	var rng = RandomNumberGenerator.new()
	Global.score = thisFloor[-2]
	#print(Global.score)
	Global.heroHealth -= (Global.score - Global.heroes[Global.floorCount - 3][0])
	#print(Global.heroHealth)
	Global.puzzleChallenge = thisFloor[-1]
	#print(Global.puzzleChallenge + Global.heroes[Global.floorCount - 3][1])
	Global.heroGaveUp = randi_range(1, 100) < (Global.puzzleChallenge + Global.heroes[Global.floorCount - 3][1])
	#print(Global.puzzleChallenge)

# Called when the node enters the scene tree for the first time.
func _ready():
	$FinalResult.visible = false
	for i in Global.floorArray:
		#could be a two-player game instead of ai
		playFloor(i)
		if Global.heroHealth < 1 or Global.heroGaveUp == true:
			$FinalResult.visible = true
			$FinalResult.text = "You win!"
			#give gold based on difficulty
			break
	if Global.heroHealth > 0 and Global.heroGaveUp == false:
		$FinalResult.visible = true
		$FinalResult.text = "You lose!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_pressed():
	Global.bossPlaced = false
	Global.floorCount = 3
	#Global.currentGold = 6000
	Global.cost = 0
	Global.currentFloor = 1
	get_tree().change_scene_to_file("res://Settings.tscn")
