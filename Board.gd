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
