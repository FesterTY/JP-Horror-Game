extends Node

var music: AudioStreamPlayer

func play_music():
	music.play()

func stop_music():
	music.playing = false
