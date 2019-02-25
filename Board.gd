extends TileMap

var selected = false
var playersTurn = true

func _ready():
	pass

func _process(delta):
	pass

func IsSelected():
	return selected

func SetSelected(value):
	selected = value

func PlayersTurn():
	return playersTurn

func SetPlayersTurn(value):
	playersTurn = value
	if playersTurn:
		get_tree().root.find_node("Turn", true, false).text = "Whites's Turn"
	else:
		get_tree().root.find_node("Turn", true, false).text = "Black's Turn"

func MovePawn(NewPos):
	if playersTurn:
		$Player.MovePawn(NewPos)
	else:
		$Enemy.MovePawn(NewPos)

func DrawDot(pos):
	if pos.x < 0 or pos.x > 512 or pos.y < 0 or pos.y > 512:
		return
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
