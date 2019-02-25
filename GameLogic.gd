extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var enemysStartPositions = []
var playersStartPositions = []
var TurnCount = 1

var winner = "none"

func _ready():
	$TurnCounter.text = $TurnCounter.text + str(TurnCount)
	for n in $Board/Enemy.get_children():
		enemysStartPositions.append(n.position)
	for n in $Board/Player.get_children():
		playersStartPositions.append(n.position)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func deleteDuplicates(arr):
	for i in range(arr.size()):
		for j in range(arr.size()):
			if arr[i] == arr[j] && i != j:
				arr.remove(j)

func GetNotInitialPossibleTurns(pos):
	var possiblePositions = Algo(pos)
	var maybePossible = []
	var onlyPossible = []
	for nn in $Board.get_children():
		for n in nn.get_children():
			if n.position in possiblePositions:
				maybePossible.append(pos - n.position)
				possiblePositions.erase(n.position)
	for i in maybePossible:
		onlyPossible.append(Vector2(pos.x - i.x*2, pos.y - i.y*2))
	for nn in $Board.get_children():
		for n in nn.get_children():
			if n.position in onlyPossible:
				onlyPossible.erase(n.position)
	var tmp = []
	for i in onlyPossible:
		if i.x < 0 or i.x > 512 or i.y < 0 or i.y > 512:
			tmp.append(i)
	for t in tmp:
		onlyPossible.erase(t)
	for i in onlyPossible:
		$Board.DrawDot(i)
	return onlyPossible.size() > 0

func GetInitialPossibleTurns(pos):
	var possiblePositions = []
	possiblePositions += Algo(pos)
	var maybePossible = []
	for nn in $Board.get_children():
		for n in nn.get_children():
			if n.position in possiblePositions:
				maybePossible.append(pos - n.position)
				possiblePositions.erase(n.position)
	for i in maybePossible:
		possiblePositions.append(Vector2(pos.x - i.x*2, pos.y - i.y*2))
	for nn in $Board.get_children():
		for n in nn.get_children():
			if n.position in possiblePositions:
				possiblePositions.erase(n.position)
	var tmp = []
	for i in possiblePositions:
		if i.x < 0 or i.x > 512 or i.y < 0 or i.y > 512:
			tmp.append(i)
	for t in tmp:
		possiblePositions.erase(t)
	for i in possiblePositions:
		$Board.DrawDot(i)
	return possiblePositions.size() > 0
	
func GetPossibleTurns(pos):
	if $Board.firstMove:
		return GetInitialPossibleTurns(pos)
	else:
		return GetNotInitialPossibleTurns(pos)
	
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

func isEnemyWon():
	for n in $Board/Enemy.get_children():
		if not n.position in playersStartPositions:
			return false
	return true
	
func isPlayerWon():
	for n in $Board/Player.get_children():
		if not n.position in enemysStartPositions:
			return false
	return true

func _on_Board_moveFinished():
	if isEnemyWon() or isPlayerWon():
		print(winner + " WON THE GAME!")
	$TurnCounter.text = ($TurnCounter.text.left($TurnCounter.text.length() - String(TurnCount).length()))
	TurnCount += 1
	$TurnCounter.text = $TurnCounter.text + str(TurnCount)