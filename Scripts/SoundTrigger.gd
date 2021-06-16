extends Area

func _ready():
	connect("body_entered", self, "_on_soundtrigger_body_entered", [], CONNECT_ONESHOT)

func _on_soundtrigger_body_entered(body):
	if body.name == "Player":
		$AudioStreamPlayer3D.play()
