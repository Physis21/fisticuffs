class_name TestStage extends Node2D

@onready var combat_ui = $CanvasLayer/CombatUi
@onready var pause_menu = $CanvasLayer/PauseMenu
var paused : bool = false ## Check whether menu is paused or not
var players_group

func _ready():
	# ! The combat UI should _enter_tree() after the characters
	players_group = get_tree().get_nodes_in_group("Players")
	for player : fightChar in players_group:
		player.health_update.connect(combat_ui.set_health)
		player.health = player.MAXHEALTH

func _process(_delta: float) -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("dev_query"):
		print("John position: %s" %  $JOHN.position)
		print("John global position: %s" %  $JOHN.global_position)

## For signal debugging purposes
func _print_signal(id, max_health, old_health, new_health):
	print(id, max_health, old_health, new_health)
	
