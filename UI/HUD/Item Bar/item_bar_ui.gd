extends CanvasLayer

@export var item_bar: ItemBar
@export var slot_scene: PackedScene
@onready var slots_container = $Wrapper/Slots

func populate_item_bar():
	if item_bar == null:
		return

	for child in slots_container.get_children():
		child.queue_free()

	for slot_data in item_bar.item_slots:
		var slot_ui = slot_scene.instantiate()
		slots_container.add_child(slot_ui)
		slot_ui.set_slot_data(slot_data)
