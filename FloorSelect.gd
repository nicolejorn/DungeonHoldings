extends Control

#var floorCount = get_tree().get_node("Settings").get("floorCount")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var typed_event = event as InputEventKey
		var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		if key_typed.is_valid_int():
			if (int(key_typed)) > 0 and (int(key_typed)) <= Global.floorCount:
				Global.currentFloor = int(key_typed)
				$Label.text = "Floor: " + str(Global.currentFloor) + "/" + str(Global.floorCount) 
		elif key_typed == 'p':
			$Label.visible = false
			#finalizedFloors.emit(floorCount)
			get_tree().change_scene_to_file("res://Floor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.visible = true
	$Label.text = "Floor: " + "1"+ "/" + str(Global.floorCount) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
