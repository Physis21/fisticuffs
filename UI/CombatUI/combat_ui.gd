class_name CombatUI extends Control
## Display around stage and fighters during a battle.

@onready var seconds_timer : Timer = $SecondsTimer

var texts : Array[String] = ["Test1", "Test2"]
var healths : Array[float] = [90, 91]
var format_health_txt_display : String = "%.1f / %.1f HP"
var time_counter_val : int = 0 ## Current value of time counter.

func _ready() -> void:
	#set_health(0, 1000, 90, 100)
	#set_health(1, 1000, 91, 101)
	time_counter_val = 0
	seconds_timer.start()
	
func _physics_process(_delta: float) -> void:
	$MarginContainer/Label0.text = texts[0]
	$MarginContainer/Label1.text = texts[1]
	$MarginContainer/TimeCounter.text = "%s" % time_counter_val

func set_health(id : int, max_health: float, _old_health: float, new_health : float):
	print("run set_health from combat ui")
	texts[id] = format_health_txt_display % [new_health, max_health]
	healths[id] = new_health


func _on_seconds_timer_timeout() -> void:
	time_counter_val += 1
	pass # Replace with function body.
