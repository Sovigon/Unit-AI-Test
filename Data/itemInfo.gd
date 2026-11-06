extends Resource
class_name ItemInfo

@export var name: String

# Maybe create an enum for whether the item is to be carried, stored, or consumed
enum ItemType {
	FOOD,
	WOOD,
	STONE
}

@export var item_class: ItemType
@export var consumable: bool = false
@export var value: float = 0.0

@export var position: Vector2
