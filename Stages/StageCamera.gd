extends Camera2D

@onready var p1 = get_tree().get_first_node_in_group("Players")

func _ready():
	pass
	
func _physics_process(delta):
	self.position = p1.position
