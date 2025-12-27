extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
var paused : bool = false ## Check whether menu is paused or not


func _ready():
	# ! The combat UI should _enter_tree() after the characters
	pass

func _process(_delta: float) -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("dev_query"):
		print("John position: %s" %  $JOHN.position)
		print("John global position: %s" %  $JOHN.global_position)
