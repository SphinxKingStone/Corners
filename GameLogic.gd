extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func GetPossibleTurns(pos):
	var possiblePositions = Algo(pos)
	var MaybePossible = []
	for nn in $Board.get_children():
		for n in nn.get_children():
			if n.position in possiblePositions:
				MaybePossible.append(pos - n.position)
				possiblePositions.erase(n.position)
	for i in MaybePossible:
		possiblePositions.append(Vector2(pos.x - i.x*2, pos.y - i.y*2))
	for nn in $Board.get_children():
		for n in nn.get_children():
			if n.position in possiblePositions:
				possiblePositions.erase(n.position)
	for i in possiblePositions:
		$Board.DrawDot(i)
	
func Algo(pos):
	var possiblePositions = [
	Vector2(pos.x - 64, pos.y)
	,Vector2(pos.x - 64, pos.y + 64)
	,Vector2(pos.x - 64, pos.y - 64)
	,Vector2(pos.x + 64, pos.y)
	,Vector2(pos.x + 64, pos.y + 64)
	,Vector2(pos.x + 64, pos.y - 64)
	,Vector2(pos.x, pos.y + 64)
	,Vector2(pos.x, pos.y - 64) 
	]
	return possiblePositions