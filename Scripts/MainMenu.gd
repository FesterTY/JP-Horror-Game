extends Node

func _ready():
	MusicController.music = $Music
	MusicController.tween = $MusicTween
	$AnimationPlayer.play("scene_loaded")
