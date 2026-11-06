extends Node2D
class_name WorldManager

@onready var food_scene: PackedScene = preload("res://Scenes/Food/Food.tscn")
@onready var entities: Node2D = $Entities
@onready var items: Node2D = $Items

@export var world_info: WorldInfo


func _ready():
	if not world_info:
		var new_world_info = WorldInfo.new()
		world_info = new_world_info
	
	# Spawn setup
	print(entities.get_children())
	for entity in entities.get_children():
		if entity is Noodle:
			entity.world_manager = self
			entity.world_info = world_info
			entity.assign_behaviors()
			entity.assign_actions()
			print("Adding world entity!")
			world_info.active_entities.append(entity.entity_info)
	
	print(world_info.active_entities)

# Eventually generalize this for any resource
func _on_food_timer_timeout():
	
	if not world_info:
		return
	
	print("Food timer ring!")
	var new_food_scene: Food = food_scene.instantiate()
	# duplicate() to make the resource unique
	var new_food_info: ItemInfo = load("res://Data/ItemInfos/food.tres").duplicate()
	var new_food_spawn = Vector2(randi_range(
		-world_info.world_size.x, 
		world_info.world_size.x), randi_range(
		-world_info.world_size.y, 
		world_info.world_size.y)
	)
	new_food_scene.position = new_food_spawn
	new_food_scene.destroy.connect(_on_resource_destruction)
	
	new_food_scene.item_info = new_food_info
	 # True forces node name to be name + enum
	items.add_child(new_food_scene, true)
	#active_resources[str(new_food_scene.name)] = new_food_scene.position
	#print(active_resources)
	
	new_food_info.name = new_food_scene.name
	new_food_info.position = new_food_spawn
	
	world_info.active_resources.append(new_food_scene.item_info)
	print(world_info.active_resources)

func _on_resource_destruction(res: Item):
	world_info.active_resources.erase(res.item_info)
	var d_item: Item = items.get_child(items.get_children().find(res))
	d_item.visible = false
