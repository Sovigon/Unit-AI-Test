extends Resource
class_name Behavior

### PLAN
# - Create behavior parameter
# - Create curve
# - Create change parameters
# - Send signal to entity when status changed

@export var name: String = "behavior"
@export var min_max_val: Vector2 = Vector2(0.0, 100.0)
@export var current_val: float = 0.0:
	set(new_val):
		current_val += new_val
		clamp(current_val, min_max_val.x, min_max_val.y)
		state_monitor()

# @export var curve: Curve
@export var states: Array[String]
@export var thresholds: Array[float]

# Setter vals
@export var current_state: String
@export var current_zone_thresholds: Vector2

signal state_changed(state: String)

# Do a config check for errors:
# - states array size and threshold array size should have 2 and 1 elements minimum, respectively
# - states array should be equal to thresholds array + 1
#
# func config_check():
# 	pass

#func _init():
#	state_monitor(true)

func state_monitor(init: bool = false):
	if init or current_val > current_zone_thresholds.y or current_val < current_zone_thresholds.x:
		var t_enum = 0
		for threshold in thresholds:
			if threshold > current_val:
				state_change(states[t_enum])
				break
			elif current_val > threshold and t_enum == thresholds.size():
				state_change(states[t_enum + 1])
				break
			else:
				t_enum += 1

func state_change(new_state: String):
	current_state = new_state
	if thresholds[states.find(current_state) - 1] == thresholds[-1]:
		current_zone_thresholds.x = min_max_val.x
	else:
		current_zone_thresholds.x = thresholds[states.find(current_state) - 1]
	if thresholds[states.find(current_state) - 1]:
		current_zone_thresholds.y = thresholds[states.find(current_state)]
	else:
		current_zone_thresholds.y = min_max_val.y
	
	state_changed.emit(states[states.find(current_state)])
	
