extends Node2D

func potion():
	if (Global.heroHealth + 25 > 100):
		Global.heroHealth = 100
	else:
		Global.heroHealth += 25
	Global.potions -= 1
	$FinalResult.text = $FinalResult.text + "The Hero used a potion! \n"
	$FinalResult.text = $FinalResult.text + "They have " + str(Global.potions) + " left. \n"

func chest():
	if (randi_range(1, 2) == 1):
		potion()

func playFloor(thisFloor):
	var rng = RandomNumberGenerator.new()
	Global.score = thisFloor[-2]
	#print(Global.score)
	var damage = (Global.score - Global.heroes[Global.floorCount - 3][0])
	Global.heroHealth -= damage
	if damage > 0:
		$FinalResult.text = $FinalResult.text + "The Hero lost " + str(damage) + " Health \n"
	#print(Global.heroHealth)
	Global.puzzleChallenge = thisFloor[-1]
	#print(Global.puzzleChallenge + Global.heroes[Global.floorCount - 3][1])
	if Global.puzzleChallenge > 0:
		Global.heroGaveUp = randi_range(1, 100) > (Global.puzzleChallenge + Global.heroes[Global.floorCount - 3][1])
		if Global.heroGaveUp:
			$FinalResult.text = $FinalResult.text + "The Hero gave up! \n"
		else:
			$FinalResult.text = $FinalResult.text + "The Hero solved the puzzle(s)! \n"
	#print(Global.puzzleChallenge)
	if (Global.heroHealth < 100) and (Global.potions > 0):
		if randi_range(1, 100) > Global.heroHealth:
			potion()

# Called when the node enters the scene tree for the first time.
func _ready():
	$FinalResult.visible = false
	$FinalResult.text = ""
	for i in Global.floorArray:
		#could be a two-player game instead of ai
		playFloor(i)
		if Global.heroHealth < 1 or Global.heroGaveUp == true:
			$FinalResult.visible = true
			$FinalResult.text = $FinalResult.text + "You win!"
			#give gold based on difficulty
			Global.currentGold += (Global.floorCount * 3000)
			break
	if Global.heroHealth > 0 and Global.heroGaveUp == false:
		$FinalResult.visible = true
		$FinalResult.text = $FinalResult.text + "You lose!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_pressed():
	Global.heroGaveUp == false
	Global.heroHealth = 100
	Global.bossPlaced = false
	Global.floorCount = 3
	Global.currentGold = Global.currentGold
	Global.cost = 0
	Global.currentFloor = 1
	get_tree().change_scene_to_file("res://Settings.tscn")
