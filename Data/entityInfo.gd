extends Resource
class_name EntityInfo

@export var name: String

@export var action_list: Array[Action]
@export var behavior_list: Array[Behavior]
@export var todo_list: Array[ActionPriority]

@export var position: Vector2
@export var destination: Vector2


func check_behavior(b_name: String) -> bool:
	var b_found: bool = false
	for behavior in behavior_list:
		if b_name in behavior.name:
			b_found = true
	return b_found

func select_behavior(b_name: String) -> Behavior:
	var b_select: Behavior
	for behavior in behavior_list:
		if b_name in behavior.name:
			b_select = behavior
	return b_select

func select_action(a_name: String) -> Action:
	var a_select: Action
	for action in action_list:
		if a_name in action.name:
			a_select = action
	return a_select

#! Make sure current_pos is fed with global_position!
func todo_list_check(current_pos: Vector2) -> Vector2:
	# Check if array is populated, make destination current position if not
	# Sort array by ActionPriority.priority, then set destination to [0].destination
	if todo_list.size() == 0:
		return current_pos
	
	todo_list.sort_custom(func(a: ActionPriority, b: ActionPriority): return a.priority > b.priority)
	var action_destinations: Array[Vector2] = todo_list[0].destinations
	
	var new_destination: Vector2
	var loc_distance: float
	for loc in action_destinations:
		if not new_destination:
			new_destination = loc
			loc_distance = loc.distance_to(current_pos)
		elif loc.distance_to(current_pos) < loc_distance:
			new_destination = loc
			loc_distance = loc.distance_to(current_pos)
	print("New location todo! Location: " + str(new_destination))
	return new_destination
