extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var dotTexture = preload("res://Img/dot.png")

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func DrawDot(pos):
	if pos.x < 0 or pos.x > 512 or pos.y < 0 or pos.y > 512:
		return
#	var newDot = load("res://Dot.tscn").instance()
#	newDot.visible = true
#	newDot.position = pos
#	print("newDot")
	
	var dot = Sprite.new()
	add_child(dot)
	dot.set_texture(dotTexture)
	dot.set_scale(Vector2(0.3, 0.3))
	dot.set_position(pos)

func GetPossibleTurns(pos):
	print("Turns for: ")
	print(pos)
	var possiblePositions = Algo(pos)
	var MaybePossible = []
	for nn in $Board.get_children():
		for n in nn.get_children():
			if n.position in possiblePositions:
				MaybePossible.append(pos - n.position)
				possiblePositions.erase(n.position)
	for i in MaybePossible:
		print(i)
		possiblePositions.append(Vector2(pos.x - i.x*2, pos.y - i.y*2))
	for nn in $Board.get_children():
		for n in nn.get_children():
			if n.position in possiblePositions:
				possiblePositions.erase(n.position)
	for i in possiblePositions:
		DrawDot(i)
	
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