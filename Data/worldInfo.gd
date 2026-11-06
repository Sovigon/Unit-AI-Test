extends Resource
class_name WorldInfo

@export var name: String
@export var world_size: Vector2

@export var active_entities: Array[EntityInfo]
@export var active_resources: Array[ItemInfo]

# Use this to stop the actions of other entities assigned to the same resource
# if said resource has expired
@export var current_assignments: Array

func new_assignment(entity: EntityInfo, resource: ItemInfo):
	pass
