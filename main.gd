extends Node2D

enum Mode {SETTINGS, FLOOR_SELECT, FLOOR}
var m = Mode.SETTINGS
var floorCount = 3
var startingGold = 4000
var cost = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#create list size of floorCount
	#$currentFloor.hide()
	if m == Mode.FLOOR:
		$currentFloor.hide()
	else:
		$currentFloor.show()

#func show_current_floor():
	#$currentFloor.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
