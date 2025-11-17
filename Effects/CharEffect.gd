extends Sprite2D
class_name CharEffect

var dir = Movement.CharDirection.new()

@onready var anim = $AnimationPlayer

func _ready():
	set_process(true)
	anim.play('default')

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'default':
		queue_free()

func turn(directionVal):
	dir.set_val(directionVal)
	$Sprite.set_flip_h(dir.flip) # debug later if needed
