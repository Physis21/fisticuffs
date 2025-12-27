class_name CombatUI extends Control
## Display around stage and fighters during a battle.

var texts : Array[String] = ["Test1", "Test2"]
var healths : Array[float] = [90, 91]

func _ready() -> void:
	set_health(0, 100)
	set_health(1, 101)
	#var _err = self.connect("health_update", set_health)
	
func _physics_process(_delta: float) -> void:
	$MarginContainer/Label0.text = texts[0]
	$MarginContainer/Label1.text = texts[1]

func set_health(id : int, new_health : float):
	print("health changed from combat ui!")
	texts[id] = "Health = %.1f" % new_health
	healths[id] = new_health
