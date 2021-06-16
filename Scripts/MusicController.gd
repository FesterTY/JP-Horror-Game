extends Node

var tween: Tween
var music: AudioStreamPlayer
var default_db = 0

var transition_duration = 0.5
var transition_type = 1 # TRANS_SINE

func play_music():
	music.play()

func stop_music():
	music.playing = false

func fade_in():
	tween.interpolate_property(music, "volume_db", -80, default_db, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween.start()

func fade_out():
	tween.interpolate_property(music, "volume_db", default_db, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween.start()
