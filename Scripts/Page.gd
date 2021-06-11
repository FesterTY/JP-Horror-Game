extends Spatial

onready var player = get_owner().get_node("Player")
onready var popup = $CanvasLayer/Control/Popup


func _ready():
	player.connect("page_on_pickup", self, "_page_on_pickup")

func _page_on_pickup():
	if Input.is_action_just_pressed("pickup"):
		queue_free()
