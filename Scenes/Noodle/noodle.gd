extends CharacterBody2D
class_name Noodle

@onready var hunger_label: Label = $Labels/HungerLabel

var world_manager: WorldManager

@export var entity_info: EntityInfo
@export var world_info: WorldInfo

@export var current_action: String = "IDLE"
@export var destination: Vector2

const SPEED = 40000.0
var active_speed: float = 0

func _ready():
	var new_entity_info = EntityInfo.new()
	new_entity_info.name = self.name
	entity_info = new_entity_info
	
	# Verify all behavior and actions are listed for signals and calls

func _process(delta: float):
	pass

func _physics_process(delta: float) -> void:
	if current_action != "IDLE":
		active_speed = SPEED
	elif current_action == "IDLE":
		active_speed = 0
	
	velocity = global_position.direction_to(destination) * active_speed * delta
	
	if entity_info:
		entity_info.position = global_position
	
	move_and_slide()

func assign_behaviors():
	var hunger_behavior = preload("res://Data/Behaviors/hunger.tres")
	hunger_behavior.state_monitor(true)
	hunger_behavior.state_changed.connect(_on_hunger_state_changed)
	hunger_label.text = hunger_behavior.current_state
	print(hunger_behavior.current_state)
	print(hunger_behavior.current_zone_thresholds)
	entity_info.behavior_list.append(hunger_behavior)
	
	print(entity_info.behavior_list)

func assign_actions():
	var get_food_action = preload("res://Data/Actions/getFood.tres")
	get_food_action.queue_action.connect(_on_get_food_queue_action)
	get_food_action.remove_action.connect(_on_get_food_remove_action)
	entity_info.action_list.append(get_food_action)
	get_food_action.entity_info = entity_info
	get_food_action.world_info = world_info
	
	print(entity_info.action_list)

### TIMERS

func _on_hunger_timer_timeout() -> void:
	#var found_behavior: bool = false
	#var behavior_select: Behavior
	#
	#for behavior in behavior_list:
		#if behavior.name == "hunger":
			#found_behavior = true
			#behavior_select = behavior
			#break
	#
	#if not found_behavior:
		#return
	#
	#behavior_select.current_val = 5.0
	entity_info.select_behavior("hunger").current_val = 5.0
	print("Hunger increased!")


### STATE SIGNALS

func _on_hunger_state_changed(state: String):
	#hunger_label.text = state
	#if state == "Peckish":
		#var closest_food_name: String
		#var closest_food_coor: Vector2
		#for food in world_info.active_resources:
			#if not closest_food_coor or position.distance_to(closest_food_coor) > position.distance_to(world_info.active_resources[food]):
				#closest_food_name = food
				#closest_food_coor = world_info.active_resources[food]
		#print(closest_food_name)
		#destination = closest_food_coor
	entity_info.select_action("getFood").behavior_update()

func _on_get_food_queue_action(action_name: String, priority: int, action_destinations: Array[Vector2]):
	# Check if action is present in todo_list, if true then update
	# Append action to todo_list
	# Trigger todo_list_check()
	print("Queue food action emitted!")
	var todo_get = entity_info.todo_list.filter(func(todo: ActionPriority): return todo.name == action_name)
	print(todo_get)
	
	if todo_get.size() == 0:
		print("Adding new task to todo!")
		var new_todo: ActionPriority = ActionPriority.new()
		new_todo.name = action_name
		new_todo.priority = priority
		new_todo.destinations = action_destinations
		
		print(new_todo)
		entity_info.todo_list.append(new_todo)
	elif todo_get.size() == 1:
		print("Updating todo task!")
		var update_todo: ActionPriority = todo_get.pop_front()
		entity_info.todo_list.erase(update_todo)
		update_todo.priority = priority
		update_todo.destinations = action_destinations
			
		entity_info.todo_list.append(update_todo)
	else:
		push_error("NOODLE: Duplicate actions inside of todo_list!")
		return
		
	print("Starting todo list check!")
	destination = entity_info.todo_list_check(global_position)
	current_action = "GET FOOD"

func _on_get_food_remove_action(action_name: String):
	# Remove action from todo_list, then trigger todo_list_check()
	# Trigger todo_list_check()
	for todo_action in entity_info.todo_list:
		if todo_action.name == action_name:
			entity_info.todo_list.erase(todo_action)
	
	destination = entity_info.todo_list_check(global_position)
	current_action = "IDLE"
