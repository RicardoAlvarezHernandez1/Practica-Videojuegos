extends Node2D
var isFullHp = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("Rotate")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	



func _on_area_2d_body_entered(body):
	
	if body.is_in_group("Jugador"):
		isFullHp = body.isFullHp()
		if isFullHp == false : 
			body.healing()
			queue_free()
		
		
