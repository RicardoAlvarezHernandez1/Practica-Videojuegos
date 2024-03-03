extends CanvasLayer

var music_on = false
func _physics_process(delta):
	if Input.is_action_just_pressed("Menu"):
		$AudioStreamPlayer.play()
		get_tree().paused = not get_tree().paused
		$MusicaMenu.play()
		$ColorRect.visible = not $ColorRect.visible
		$Label.visible = not $Label.visible
		$VBoxContainer.visible = not $VBoxContainer.visible
		music_on = not music_on
		if music_on == false:
			$MusicaMenu.stop()

func _on_salir_pressed():
	get_tree().quit()

func _on_continuar_pressed():
	get_tree().paused = not get_tree().paused
	$ColorRect.visible = not $ColorRect.visible
	$Label.visible = not $Label.visible
	$VBoxContainer.visible = not $VBoxContainer.visible
	$MusicaMenu.stop()
