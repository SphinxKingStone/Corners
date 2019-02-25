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


func PawnClicked(PawnName):
	if get_parent().PlayersTurn():
		return
	if selectedPawn != "none" and selectedPawn == PawnName:
		find_node(selectedPawn, true, false).UnSelect()
		get_parent().SetSelected(false)
		selectedPawn = "none"
		return
	if selectedPawn != "none":
		find_node(selectedPawn, true, false).UnSelect()
	find_node(PawnName, true, false).Select()
	selectedPawn = PawnName
	get_parent().SetSelected(true)