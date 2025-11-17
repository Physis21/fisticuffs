extends Node

# Classes

class InptDirection:
	var val : String = 'neutral'
	var xmult : int = 0
	
	func set_val(turnVal : String):
		if turnVal == 'neutral':
			val = 'neutral'
			xmult = 0
		if turnVal == 'right':
			val = 'right'
			xmult = 1
		elif turnVal == 'left':
			val = 'left'
			xmult = -1
	
	func is_rightorleft():
		if val in ['left', 'right']:
			return true
		else:
			return false

class CharDirection:
	# val is either left or right atm
	var val : String = 'right'
	var flip : bool = false
	var xmult : int = 1
	
	func set_val(turnVal : String):
		if turnVal == 'neutral':
			pass # don't do anything
		if turnVal == 'right':
			val = 'right'
			flip = false # Sprite is right-facing by default
			xmult = 1
		elif turnVal == 'left':
			val = 'left'
			flip = true
			xmult = -1

func get_dir_val(id : int): # Apply SOCD
	if Input.is_action_pressed("right_%s" % id) and Input.is_action_pressed("left_%s" % id):
		return 'neutral'
	elif Input.is_action_pressed("right_%s" % id):
		return 'right'
	elif Input.is_action_pressed("left_%s" % id):
		return 'left'
	else:
		return 'neutral'
		
func grounded_move_x(body : CharacterBody2D, xspeed : int, direction : InptDirection):
	body.velocity.x = direction.xmult * xspeed


		
