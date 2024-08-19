extends Control

#signal finalizedFloors(count)

func startGame():
	#m = Mode.FLOOR_SELECT
	Global.currentGold -= Global.cost
	$Label.visible = false
	Global.floorArray.resize(Global.floorCount)
	Global.floorArray.fill(false)
	#finalizedFloors.emit(floorCount)
	Global.currentFloor = 1
	get_tree().change_scene_to_file("res://Floor.tscn")
	#get_tree().change_scene_to_file("res://FloorSelect.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		if key_typed.is_valid_int():
			if (int(key_typed)) > 2 and (int(key_typed)) < 6: #might make range smaller
				Global.floorCount = int(key_typed)
				Global.cost = Global.floorCount * 300
				$Label.text = Global.currentGoldString + "Floor count: " + str(Global.floorCount) + " Cost: " + str(Global.cost)
		elif key_typed == 'p' and Global.currentGold >= Global.cost:
			startGame()

func generateHero(strength):
	Global.heroes[strength].append(strength * 5)
	Global.heroes[strength].append(strength * 20)
	Global.heroes[strength].append(strength)
	#The % chance they give up = 100 - (persistence + difficulty)

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(Global.maxEnemiesAndPuzzles)
	Global.currentGoldString = "Current Gold: " + str(Global.currentGold) + "\n"
	Global.heroes = [] #might be better as 1d array
	for i in 3:
		Global.heroes.append([])
		generateHero(i)
	#print(Global.heroes)
	$Label.visible = true
	Global.cost = Global.floorCount * 300
	$Label.text = Global.currentGoldString + "Floor count: " + str(Global.floorCount) + " Cost: " + str(Global.cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.currentGoldString = "Current Gold: " + str(Global.currentGold) + "\n"
	Global.def = Global.heroes[Global.floorCount - 3][0]
	Global.per = Global.heroes[Global.floorCount - 3][1]
	Global.potions = Global.heroes[Global.floorCount - 3][2]
	$PlayerStats.text = "Defense: " + str(Global.def) + " Persistence: " + str(Global.per) + " Potions: " + str(Global.potions)
	#str(Global.heroes[Global.floorCount - 3])


func _on_more_enemies_pressed():
	if (Global.currentGold > 10000):
		Global.currentGold -= 10000
		Global.maxEnemiesAndPuzzles += 1


func _on_start_pressed():
	startGame()
