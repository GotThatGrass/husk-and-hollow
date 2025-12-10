extends Panel

@onready var icon := $Icon
@onready var count_label := $Count

@onready var deselected := get_theme_stylebox("panel")
@onready var selected := get_theme_stylebox("panel_selected")

var slot: ItemBarSlot

func set_slot_data(new_slot: ItemBarSlot):
	slot = new_slot
	refresh()

func refresh():
	if slot == null:
		return

	add_theme_stylebox_override("panel", selected if slot.selected else deselected)
	icon.texture = slot.item.texture if slot.item else null
	icon.visible = slot.item != null
	count_label.text = str(slot.stack_count) if slot.item else ""
