extends Node2D

func _ready():
	$Sonido.play()
	
func _on_salir_pressed():
	get_tree().quit()
	
func _on_reiniciar_pressed():
	get_tree().change_scene_to_file("res://scenes/Juego.tscn")
