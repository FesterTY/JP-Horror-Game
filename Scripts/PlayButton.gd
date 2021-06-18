extends Button

onready var animationPlayer = get_owner().get_node("AnimationPlayer")
onready var blackOverlay = get_parent().get_node("BlackOverlay")

func _on_PlayButton_pressed():
	animationPlayer.play("load_scene")
	get_parent().move_child(blackOverlay, 2)
	MusicController.fade_out()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "load_scene":
		get_tree().change_scene("res://Scenes/Level/Main.tscn")
