extends Node2D

var color = 0 #0 - white 1 - black
const blackRect = Rect2(490, 0, 474, 680)
const whiteRect = Rect2(0, 0, 474, 680)

signal clicked(PawnName)
signal animationFinished

func _ready():
	color = 0
	SetColor(color)

func SetColor(value):
	if value == 0 || value == 1:
		color = value
	else:
		return "Invalid value. 0 for white, 1 for black"
	
	if color == 0:
		$Sprite.region_rect = whiteRect
	else:
		$Sprite.region_rect = blackRect

func _process(delta):
	pass
	
func MoveTo(newPos):
	$AnimationPlayer.current_animation = "Move"
	if get_node("/root/Game/Board").IsMoving():
		return
	$Tween.interpolate_property(self, "position", position, newPos, $AnimationPlayer.current_animation_length / 2, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	if not $Tween.is_active():
		$Tween.start()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.is_pressed():
			Clicked()


func Clicked():
	if get_node("/root/Game/Board").IsMoving():
		return
	emit_signal("clicked", name)
	#if not get_tree().get_root().find_node("Board", true, false).IsSelected(): #check if something selected
	#	Select()
	#else:
	#	UnSelect()
		
func Select():
	$Sprite.set_scale($Sprite.scale * 1.5)
	$Area2D/CollisionShape2D.set_scale($Area2D/CollisionShape2D.scale * 1.5)

func UnSelect():
	$Sprite.set_scale($Sprite.scale / 1.5)
	$Area2D/CollisionShape2D.set_scale($Area2D/CollisionShape2D.scale / 1.5)

func _on_Tween_tween_started(object, key):
	get_node("/root/Game/Board").SetMoving(true)

func _on_Tween_tween_completed(object, key):
	get_node("/root/Game/Board").SetMoving(false)
	emit_signal("animationFinished")
