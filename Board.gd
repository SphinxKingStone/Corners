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