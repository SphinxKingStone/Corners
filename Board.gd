extends TileMap

var selected = false
var playersTurn = true
var moving = false
var firstMove = true

signal moveFinished

func _ready():
	pass

func _process(delta):
	pass

func IsSelected():
	return selected

func SetSelected(value):
	selected = value
	
func IsMoving():
	return moving

func SetMoving(value):
	moving = value

func IsPlayersTurn():
	return playersTurn

func SetPlayersTurn(value):
	playersTurn = value
	emit_signal("moveFinished")
	if playersTurn:
		get_tree().root.find_node("Turn", true, false).text = "White's Turn"
	else:
		get_tree().root.find_node("Turn", true, false).text = "Black's Turn"

func MovePawn(NewPos):
	if playersTurn:
		$Player.MovePawn(NewPos)
	else:
		$Enemy.MovePawn(NewPos)

func DrawDot(pos):
	var dotScene = load("res://Dot.tscn")
	var dot = dotScene.instance()
	add_child(dot)
	dot.visible = true
	dot.position = pos
	dot.connect("clicked", self, "MovePawn")

func ClearDots():
	for i in get_children():
		if "Dot" in i.get_name():
			i.queue_free()


func _on_Enemy_MoveFinished():
#	firstMove = false
	SetPlayersTurn(true)


func _on_Player_MoveFinished():
#	firstMove = false
	SetPlayersTurn(false)
