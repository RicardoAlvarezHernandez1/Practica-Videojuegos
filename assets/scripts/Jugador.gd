extends CharacterBody2D

var speed = 400

var atacking = false
var current_dir = ""
var isAlive = true
var pointsTillDead = 0
var hp = 100

func _ready():
	$Area2D/CollisionShape2D.disabled = true

func _physics_process(delta):
	movement()
	decide_animation()

func movement():
	if isAlive == true:
		velocity = Input.get_vector("left_movement", "right_movement" , "top_movement" , "down_movement") * speed
		move_and_slide()

func decide_animation():
	if isAlive == true:
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
			
			if current_dir == "right" :
				$Area2D/CollisionShape2D.disabled = false
				$JugadorAnimado.play("Atack")
				$Area2D.position.x = 34
				await ($JugadorAnimado.animation_finished)
				atacking = false
				$Area2D/CollisionShape2D.disabled = true
			elif current_dir == "left":
				$Area2D/CollisionShape2D.disabled = false
				$JugadorAnimado.play("Atack")
				$Area2D.position.x = -102
				await ($JugadorAnimado.animation_finished)
				atacking = false
				$Area2D/CollisionShape2D.disabled = true
			elif current_dir == "up":
				$JugadorAnimado.play("Atack_Top")
				await ($JugadorAnimado.animation_finished)
				atacking = false
			elif current_dir == "down":
				$JugadorAnimado.play("Atack_Down")
				await ($JugadorAnimado.animation_finished)
				atacking = false
		

func stopMoving():
	isAlive = false
	
func continueMoving():
	isAlive = true

func bossDamageReceived():
	hp = hp - 70
	isAlive = false
	if isAlive == false :
		$JugadorAnimado.play("Iddle")
	$ProgressBar.set_value(hp)
	

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		if pointsTillDead < 10 : 
			pointsTillDead = pointsTillDead + 1
			body.damageReceived()
		else:
			body.dead()
		
	
	
	
func dead():
	$JugadorAnimado.play("Dead")
	await ($JugadorAnimado.animation_finished)
	queue_free()
