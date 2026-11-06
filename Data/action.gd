extends Resource
class_name Action

### PLAN
# - Create behavior heirarchy
# - Select behavior statuses for action (bucket)
# - Get behavior parameter solution
# - Direct entity to solution

@export var name: String = "action"
@export var entity_info: EntityInfo
@export var world_info: WorldInfo


# Behavior requirements element: [name: String, state: String, active: bool]
@export var behavior_requirements: Array[BehaveRequireElement] = []
@export var current_priority: int
@export var resource_req: bool
@export var resource_need_type: Array[ItemInfo.ItemType] = []
@export var destinations: Array[Vector2] = []

signal queue_action(action_name: String, priority: int, action_destinations: Array[Vector2])
signal remove_action(action_name: String)

# Do a config check for errors:
# - all behaviors listed in behavior_requirements are found in entity

func behavior_update():
	print("Checking behavior for action!")
	# Check if behavior state is in requirements
	var active_tally: int = 0
	for req: BehaveRequireElement in behavior_requirements:
		var behavior_check: Behavior
		
		if entity_info.select_behavior(req.name):
			behavior_check = entity_info.select_behavior(req.name)
		else:
			continue
		
		if behavior_check.current_state in req.state:
			req.active = true
			current_priority = req.state[behavior_check.current_state]
			active_tally += 1
		else:
			req.active = false
	
	if active_tally == behavior_requirements.size():
		action_trigger()
	else:
		remove_action.emit(name)
		
	#var trigger: bool = false
	#
	#for req: BehaveRequireElement in behavior_requirements:
		#if req.active == true:
			#trigger = true
		#else:
			#trigger = false
			#break
	#
	#if trigger:
		#action_trigger()
	#else:
		#remove_action.emit(name)

func action_trigger():
	destinations.clear()
	if resource_req:
		var n_enum = 0
		for need in resource_need_type:
			# Potential for multiple destinations, remember to let the entity sort by nearest
			var new_destination = get_behavior_loc(true, resource_need_type[n_enum])
			destinations.append(new_destination)
			n_enum += 1
	else:
		destinations.append(get_behavior_loc(false))
	
	print("Destinations added: " + str(destinations))
	queue_action.emit(name, current_priority, destinations)

# TODO: Create handling for if a resource is not present but behavior threshold is met
func get_behavior_loc(is_resource: bool, resource_type: Variant = null) -> Vector2:
	var coor: Vector2
	
	if is_resource:
		var closest_res_name: String
		var closest_res_coor: Vector2
		for res: ItemInfo in world_info.active_resources:
			if res.item_class != resource_type:
				continue
			var res_coor_check = world_info.active_resources[world_info.active_resources.find(res)].position
			print(entity_info.position.distance_to(res_coor_check))
			if not closest_res_coor or entity_info.position.distance_to(closest_res_coor) > entity_info.position.distance_to(res_coor_check):
				closest_res_name = res.name
				closest_res_coor = res_coor_check
		print(closest_res_name)
		print(entity_info.position.distance_to(closest_res_coor))
		coor = closest_res_coor
	return coor
