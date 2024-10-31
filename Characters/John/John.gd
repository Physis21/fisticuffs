extends CharacterBody2D

# from fox stats

# Ground Variables

# Air Variables
var fastfall = false
var jump_squat = 5
var lag_frames = 0
var landing_frames = 0

# Onready Variables
@onready var GroundL = $Raycasts/GroundL
@onready var GroundR = $Raycasts/GroundR

# JOHN's main attributes
const WALKSPEED = 200.0
const DASHSPEED = 390
const GRAVITY = 1800
const JUMPFORCE = 500
const MAXJUMPFORCE = 1000
const MAXAIRSPEED = 300
const AIR_ACCEL = 25
const FALLSPEED = 60
const FALLINGSPEED = 900
const MAXFALLSPEED = 900
const TRACTION = 200

@onready var state = $State

var frame = 0
func updateframes(delta):
	frame += 1

func turn(direction):
	# flipped compared to tutorial because his fox faces left
	var dir = 0
	if direction:  # face right
		dir = +1
		$Sprite.position.x = -7
	else:  # face left
		dir = -1
		$Sprite.position.x = 7
	$Sprite.set_flip_h(direction)

func _frame():
	frame = 0

# called when the node enters the scene_tree for the first time
func _ready():
	pass

func _physics_process(delta):
	$Frames.text = str(frame)
