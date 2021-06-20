extends Area

export(String, "WASD", "MOUSE", "PICKUP") var type

onready var animationPlayer = $CanvasLayer/Tutorial/AnimationPlayer
var waitToPlay = false

func _ready():
	connect("body_entered",self,"_on_TutorialTrigger_body_entered", [], CONNECT_ONESHOT)

func _on_TutorialTrigger_body_entered(body):
	if animationPlayer.current_animation.length() > 0:
		waitToPlay = true
	else:
		animationPlayer.play(type)

func _on_AnimationPlayer_animation_finished(anim_name):
	if waitToPlay:
		animationPlayer.play(type)
		waitToPlay = false
