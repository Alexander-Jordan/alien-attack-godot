class_name RandomAudioPlayer2D extends AudioStreamPlayer2D

func play_random_audio_and_await_finished(audio_streams: Array[AudioStream]) -> void:
	if audio_streams.is_empty():
		return
	stream = audio_streams.pick_random()
	play()
	await finished
