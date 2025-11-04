extends Sprite2D

var dir = 'right'

@onready var anim = $AnimationPlayer

func _ready():
	set_process(true)
	anim.play('default')
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'default':
		queue_free()

func turn(direction):
	var flip = true
	if direction == 'right':  # face right
		dir = 'right'
		flip = false
	elif direction == 'left':  # face left
		dir = 'left'
		flip = true		
	$Sprite.set_flip_h(flip) # debug
