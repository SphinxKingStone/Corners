extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var selectedPawn = "none"

func _ready():
	for pawn in get_children():
		pawn.SetColor(1)
		pawn.connect("clicked", self, "PawnClicked")

func _process(delta):
	pass

func getSelectedPawnNode(PawnNodeName):
	return find_node(PawnNodeName, true, false)

func PawnClicked(PawnName):
	#check for turn
	if get_parent().PlayersTurn():
		return
		
	#select or unselect pawn
	if selectedPawn != "none" and selectedPawn == PawnName:
		getSelectedPawnNode(selectedPawn).UnSelect()
		get_parent().SetSelected(false)
		selectedPawn = "none"
		return #exit if we unselected
	if selectedPawn != "none":
		getSelectedPawnNode(selectedPawn).UnSelect()
	find_node(PawnName, true, false).Select()
	selectedPawn = PawnName
	get_parent().SetSelected(true)
	
	#highlight possible moves
	get_parent().GetPossibleTurns(getSelectedPawnNode(selectedPawn).position)