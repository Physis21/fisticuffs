extends Node

func hitstun(mod, duration):
	# mod is the hitlag of the attack
	Engine.time_scale = mod / 100
	print(str(mod))
	await get_tree().create_timer(duration * Engine.time_scale).timeout
	Engine.time_scale = 1
