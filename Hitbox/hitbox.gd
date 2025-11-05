extends Area2D

@export var width = 300
@export var height = 400
@export var damage = 50
@onready var angle = 0
@onready var angle_flipper = 0  # default value
@onready var base_kb = 100
@export var kb_scaling = 2
@export var duration = 1500
@export var hitlag_modifier = 1
@export var type = 'normal'
@onready var hitbox = get_node("HitboxShape")
@onready var parentState = get_parent().selfState
var framez = 0.0
var player_list = []  # list of player characters this hitbox cannot collide with
var knockbackVal

const degToRad = PI / 180

func set_parameters(w,h,dam,dur,a,af,bk,t,p,hit,parent=get_parent()):
	self.position = Vector2(0,0)
	player_list.append(parent)
	player_list.append(self)  # just in case
	width = w
	height = h
	damage = dam
	duration = dur
	angle = a
	angle_flipper = af
	base_kb = bk
	type = t
	hitlag_modifier = hit
	self.position = p
	update_extents()
	self.body_entered.connect(Hitbox_collide) # Manual connecting
	set_physics_process(true)
	pass
	
func Hitbox_collide(body):
	if !(body in player_list):
		player_list.append(body)
		var charstate
		charstate = body.get_node("StateMachine")
		weight = body.weight
		body.health -= damage
		knockbackVal = knockback(body.percentage, damage, weight, kb_scaling, base_kb, 1)
		apply_angle_flipper(body)
		body.knockback = knockbackVal
		body.hitstun = getHitstun(knockbackVal/0.3)
		get_parent().connected = true
		body._frame()
		charstate.state = charstate.states.HITSTUN
		
	
func update_extents():
	hitbox.shape.extents = Vector2(width, height)
	
func _ready() -> void:
	hitbox.shape = RectangleShape2D.new()  # double check
	set_physics_process(false)  # don't want hitbox to do anything before this func is called
	pass

func _physics_process(delta: float):
	if framez < duration:
		framez += 1
	elif framez == duration:
		Engine.time_scale = 1
		queue_free()  # this waits for the current code to finish execution before deletion
		return
	if get_parent().selfState != parentState:  # check if we are still attacking
		Engine.time_scale = 1
		queue_free()
		return 

func getHitstun(kbVal):
	return floor(kbVal * 10)

# These variables are maybe not necessary
@export var weight = 100
@export var ratio = 1
@export var percentage = 20 # default for stamina mode in Melee

func knockback(p, d, w, ks, bk, r):
	percentage = p
	damage = d
	weight = w
	kb_scaling = ks
	base_kb = bk
	ratio = r
	# require 0.4% of SSBM knockback
	return ((((((percentage / 10) + (percentage * damage / 20)) * 1.4 * (200 / (weight + 100))) + 18) * kb_scaling) + base_kb) * ratio * 0.004

func getHorizontalDecay(a): # The rate at which the opponent will slow down after knockback
	var decay = 0.051 * cos(a * degToRad) # Rate of decay is 0.051. To get the Horizontal rate, multily by cos of angle
	decay = round(decay * 100000) / 100000 # Round to a whole number
	decay = decay * 1000 # Enlarge the rate of decay
	return decay
	
func getVerticalDecay(a):
	var decay = 0.051 * sin(a * degToRad) 
	decay = round(decay * 100000) / 100000
	decay = decay * 1000
	return abs(decay)
	
func getHorizontalVelocity(kbVal, a):
	var initialVelocity = kbVal * 30
	var horizontalVelocity = initialVelocity * cos(a * degToRad)
	horizontalVelocity = round(horizontalVelocity * 100000) / 100000
	return horizontalVelocity

func getVerticalVelocity(kbVal, a):
	var initialVelocity = kbVal * 30
	var verticalVelocity = initialVelocity * sin(a * degToRad)
	verticalVelocity = round(verticalVelocity * 100000) / 100000
	return verticalVelocity
	
	


func apply_angle_flipper(body):
	var xangle
	var angleWithDir
	if get_parent().dir == 'right':
		xangle = -body.global_position.angle_to_point(get_parent().global_position) / degToRad
		angleWithDir = angle
	elif get_parent().dir == 'left':
		xangle = body.global_position.angle_to_point(get_parent().global_position) / degToRad
		angleWithDir = (180 - angle) % 360
	match angle_flipper:
		0:
			body.velocity.x = (getHorizontalVelocity(knockbackVal, angleWithDir))
			body.velocity.y = (getVerticalVelocity(knockbackVal, angleWithDir))
			body.hdecay = (getHorizontalDecay(angleWithDir))
			body.vdecay = (getVerticalDecay(angleWithDir))
		1:
			if get_parent().dir == 'right':
				xangle = -self.global_position.angle_to_point(body.get_parent().global_position) / degToRad
			elif get_parent().dir == 'left':
				xangle = self.global_position.angle_to_point(body.get_parent().global_position) / degToRad
			body.velocity.x = (getHorizontalVelocity(knockbackVal, xangle+180))
			body.velocity.y = (getVerticalVelocity(knockbackVal, -xangle))
			body.hdecay = (getHorizontalDecay(xangle+180))
			body.vdecay = (getVerticalDecay(xangle))
			# away
			# return angle
		2: 
			if get_parent().dir == 'right':
				xangle = -body.get_parent().global_position.angle_to_point(self.global_position) / degToRad
			elif get_parent().dir == 'left':
				xangle = body.get_parent().global_position.angle_to_point(self.global_position) / degToRad
			body.velocity.x = (getHorizontalVelocity(knockbackVal, -xangle+180))
			body.velocity.y = (getVerticalVelocity(knockbackVal, -xangle))
			body.hdecay = (getHorizontalDecay(xangle+180))
			body.vdecay = (getVerticalDecay(xangle))
			# away
			# return angle
	# 0 - sends at the exact knockback angle
	# 1 - sends away from center of the ennemy player
	# 2 - sends towards center of the ennemy player
