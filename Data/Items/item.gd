extends Area2D
class_name Item

@export var item_info: ItemInfo

signal destroy

# TODO: Generalize item interaction for pickups, inventory, and consumption
func _on_body_entered(body: Node2D):
	if body is Noodle:
		match item_info.item_class:
			ItemInfo.ItemType.FOOD:
				if body.entity_info.check_behavior("hunger"):
					body.entity_info.select_behavior("hunger").current_val = item_info.value
					print("FOOD: Om nom nom!")
					destroy.emit(self)
