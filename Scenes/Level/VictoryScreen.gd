extends CanvasLayer


func _ready():
	$Control/AnimationPlayer.play("Credits")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().quit()
