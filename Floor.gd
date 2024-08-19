extends Node2D
var intro = "(Row)(Column)(Letter) Options:
	- Chest (c): Motivate your victims.
	- Key (k) Give heroes a hope spot.
	- Puzzle (p#) Make the hero give up. Higher # = more effective.
	- Boss (b) Place it wisely! You only get one.
	- Enemies (e#) Put # of enemies in a room."
	# Set a starter value for each position
#var floorGrid = []

func validNumber(inputtedNumber):
	return (int(inputtedNumber) > 0) and (Global.maxEnemiesAndPuzzles >= int(inputtedNumber))

func createNewRooms():
	Global.score = 0
	Global.puzzleChallenge = 0
	Global.floorGrid = []
	for i in Global.floor_width:
		Global.floorGrid.append([])
		for j in Global.floor_height:
			Global.floorGrid[i].append('x')
	$FloorMap.text = Global.currentGoldString + "
	x12345
	1" + str(Global.floorGrid[0]) + "\n2" + str(Global.floorGrid[1]) + "\n3" + str(Global.floorGrid[2]) + "\n4" + str(Global.floorGrid[3]) + "\n5" + str(Global.floorGrid[4])
	$Updates.text = intro

# Called when the node enters the scene tree for the first time.
func _ready():
	createNewRooms()
	#Maybe a way to put multiple objects in a room


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.currentGoldString = "Current Gold: " + str(Global.currentGold) + "\n"
	$FloorMap.text = Global.currentGoldString + "
	x12345
	1" + str(Global.floorGrid[0]) + "\n2" + str(Global.floorGrid[1]) + "\n3" + str(Global.floorGrid[2]) + "\n4" + str(Global.floorGrid[3]) + "\n5" + str(Global.floorGrid[4])


func _on_line_edit_text_submitted(new_text):
	var row
	var column
	if(new_text.substr(0,1).is_valid_int()):
		row = (int(new_text.substr(0,1)) -1)
	if(new_text.substr(1,1).is_valid_int()):
		column = (int(new_text.substr(1,1)) -1)
	if(new_text.substr(2,1).to_lower() == 'c'):
		if Global.currentGold < 200:
			$Updates.text = intro + "You don't have enough gold!"
		else:
			Global.floorGrid[int(row)][int(column)] = 'c'
			Global.currentGold -= 200
			Global.heroes[Global.floorCount - 3][1] += 10
			if Global.heroes[Global.floorCount - 3][0] > 0:
				Global.heroes[Global.floorCount - 3][0] -= 5
	if(new_text.substr(2,1).to_lower() == 'k'):
		if Global.currentGold < 200:
			$Updates.text = intro + "You don't have enough gold!"
		else:
			Global.floorGrid[int(row)][int(column)] = 'k'
			Global.currentGold -= 200
			if Global.heroes[Global.floorCount - 3][0] > 0:
				Global.heroes[Global.floorCount - 3][0] -= 2
	if(new_text.substr(2,1).to_lower() == 'e'):
		if(new_text.substr(3,1).is_valid_int() and validNumber(new_text.substr(3,1))): # and validNumber(new_text.substr(3,1))
			if Global.currentGold < (100 * int(new_text.substr(3,1))):
				$Updates.text = intro + "You don't have enough gold!"
			else:
				Global.floorGrid[int(row)][int(column)] = new_text.substr(3,1)
				Global.score += (10 * int(new_text.substr(3,1)))
				Global.currentGold -= (100 * int(new_text.substr(3,1)))
	if(new_text.substr(2,1).to_lower() == 'p'):
		if(new_text.substr(3,1).is_valid_int() and validNumber(new_text.substr(3,1))):
			if Global.currentGold < (200 * int(new_text.substr(3,1))):
				$Updates.text = intro + "You don't have enough gold!"
			else:
				Global.floorGrid[int(row)][int(column)] = new_text.substr(3,1)
				Global.puzzleChallenge += int(new_text.substr(3,1))
				Global.currentGold -= (200 * int(new_text.substr(3,1)))
	if(new_text.substr(2,1).to_lower() == 'b') and (not Global.bossPlaced):
			if Global.currentGold < 500:
				$Updates.text = intro + "You don't have enough gold!"
			else:
				Global.floorGrid[int(row)][int(column)] = 'b'
				Global.score += 50
				Global.bossPlaced = true
				Global.currentGold -= 500
	#$Updates.text = intro + ""


func _on_done_pressed():
	Global.floorArray[Global.currentFloor - 1] = Global.floorGrid
	Global.floorArray[Global.currentFloor - 1].append(Global.score)
	Global.floorArray[Global.currentFloor - 1].append(Global.puzzleChallenge)
	if(Global.currentFloor != Global.floorCount):
		Global.currentFloor += 1
		createNewRooms()
	else:
		#print(Global.floorArray)
		get_tree().change_scene_to_file("res://Results.tscn")
