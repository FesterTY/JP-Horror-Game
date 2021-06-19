extends Spatial

onready var player = get_owner().get_node("Player")


func _ready():
	player.connect("page_on_pickup", self, "_page_on_pickup")

func _page_on_pickup(name):
	if name == self.name:
		queue_free()
