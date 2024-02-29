extends CharacterBody2D

var speed = 250

var atacking = false
var current_dir = ""

func _physics_process(delta):
	movement()
	decide_animation()

func movement():
	velocity = Input.get_vector("left_movement", "right_movement" , "top_movement" , "down_movement") * speed
	move_and_slide()

func decide_animation():
	
	if !atacking:
		
		if velocity.x == 0 and velocity.y == 0:
			$JugadorAnimado.play("Iddle")
		elif velocity.x < 0:
			$JugadorAnimado.flip_h = true
			current_dir = "left"
			$JugadorAnimado.play("Run_Animation")
		elif velocity.x > 0:
			$JugadorAnimado.flip_h = false
			current_dir = "right"
			$JugadorAnimado.play("Run_Animation")
		#---------------------------------------------
		if velocity.y < 0:
			current_dir = "up"
			$JugadorAnimado.play("Run_Top")
			
		elif velocity.y > 0:
			current_dir = "down"
			$JugadorAnimado.play("Run_Down")
		
		if Input.is_action_just_pressed("atack"):
			atacking = true
	else:
		
		if current_dir == "left" or current_dir == "right":
			$JugadorAnimado.play("Atack")
			await ($JugadorAnimado.animation_finished)
			atacking = false
		elif current_dir == "up":
			$JugadorAnimado.play("Atack_Top")
			await ($JugadorAnimado.animation_finished)
			atacking = false
		elif current_dir == "down":
			$JugadorAnimado.play("Atack_Down")
			await ($JugadorAnimado.animation_finished)
			atacking = false
		
	

