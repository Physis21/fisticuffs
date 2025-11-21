extends Area2D

@export var width = 300
@export var height = 400
@onready var pushbox = get_node("PushboxShape")
@onready var shapecast = get_node("ShapeCast2D")
@onready var parentState = get_parent().selfState

var self_right_side_xpos = self.global_position.x + width
var self_left_side_xpos = self.global_position.x - width

var player_list = []  # list of player characters this pushox cannot collide with

func _ready() -> void:
	pushbox.shape = RectangleShape2D.new()  # double check
	shapecast.shape = RectangleShape2D.new()
	set_physics_process(false)  # don't want pushbox to do anything before this func is called

func _physics_process(_delta: float) -> void:
	update_side_pos()
	if shapecast.is_colliding() and get_parent().velocity.x != 0:
		var area = shapecast.get_collider(0)
		var area_right_side_xpos = area.global_position.x + width
		var area_left_side_xpos = area.global_position.x - width
		var right_gap = abs(self_right_side_xpos - area_left_side_xpos)
		var left_gap = abs(self_left_side_xpos - area_right_side_xpos)
		var adjustement
		if right_gap <= left_gap:
			adjustement = -right_gap / 2
		elif right_gap >= left_gap:
			adjustement = left_gap / 2
		print("adjustement = %s" % adjustement)

func set_parameters(w, h, p, parent=get_parent()):
	player_list.append(parent)
	player_list.append(self)  # just in case
	self.position = Vector2(0,0)
	width = w
	height = h
	self.position = p
	update_extents()
	#self.area_entered.connect(pushbox_overlap) # Manual connecting
	set_physics_process(true)

#func pushbox_overlap(area):
	#var body = area.get_parent()
	#if !(body in player_list) and get_parent().velocity.x != 0:
		#var self_right_side_xpos = self.global_position.x + width
		#var self_left_side_xpos = self.global_position.x - width
		#var area_right_side_xpos = area.global_position.x + width
		#var area_left_side_xpos = area.global_position.x - width
		#var right_gap = abs(self_right_side_xpos - area_left_side_xpos)
		#var left_gap = abs(self_left_side_xpos - area_right_side_xpos)
		#var adjustement
		#if right_gap <= left_gap:
			#adjustement = -right_gap / 2
		#elif right_gap >= left_gap:
			#adjustement = left_gap / 2
		#print("Old global position: %s" % get_parent().global_position.x)
		#get_parent().global_position.x += adjustement
		#print("New global position: %s" % get_parent().global_position.x)
		#body.global_position.x -= adjustement
		

func update_extents():
	pushbox.shape.extents = Vector2(width, height)
	shapecast.shape.extents = Vector2(width, height)

func update_side_pos():
	self_right_side_xpos = self.global_position.x + width
	self_left_side_xpos = self.global_position.x - width
