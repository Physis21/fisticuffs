class_name CombatUI extends Control
## Display around stage and fighters during a battle.

var texts : Array[String] = ["Test1", "Test2"]
var healths : Array[float] = [90, 91]
var format_health_txt_display : String = "%.1f / %.1f HP"

func _ready() -> void:
	#set_health(0, 1000, 90, 100)
	#set_health(1, 1000, 91, 101)
	pass
	
func _physics_process(_delta: float) -> void:
	$MarginContainer/Label0.text = texts[0]
	$MarginContainer/Label1.text = texts[1]

func set_health(id : int, max_health: float, _old_health: float, new_health : float):
	print("run set_health from combat ui")
	texts[id] = format_health_txt_display % [new_health, max_health]
	healths[id] = new_health
