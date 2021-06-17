extends Node

func _ready():
	MusicController.music = $Music
	MusicController.tween = $MusicTween
