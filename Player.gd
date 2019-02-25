extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var selectedPawn = "none"

signal MoveFinished

func _ready():
	for pawn in get_children():
		pawn.SetColor(0)
		pawn.connect("clicked", self, "PawnClicked")

func _process(delta):
	pass

func getPawnNode(PawnNodeName):
	return find_node(PawnNodeName, true, false)

func PawnClicked(PawnName):
	#check for turn
	if not get_parent().IsPlayersTurn():
		return
		
	#select or unselect pawn
	if selectedPawn != "none" and selectedPawn == PawnName:
		getPawnNode(selectedPawn).UnSelect()
		get_parent().SetSelected(false)
		selectedPawn = "none"
		get_node("/root/Game/Board").ClearDots()
		return #exit if we unselected
	if selectedPawn != "none":
		getPawnNode(selectedPawn).UnSelect()
		get_node("/root/Game/Board").ClearDots()
	find_node(PawnName, true, false).Select()
	selectedPawn = PawnName
	get_parent().SetSelected(true)
	
	#highlight possible moves
	get_node("/root/Game").GetPossibleTurns(getPawnNode(selectedPawn).position)
	

func MovePawn(NewPos):
	var pawn = getPawnNode(selectedPawn)
	pawn.MoveTo(NewPos)
	emit_signal("MoveFinished")
	
	selectedPawn = "none"
	pawn.UnSelect()
	get_parent().SetSelected(false)
	get_node("/root/Game/Board").ClearDots()