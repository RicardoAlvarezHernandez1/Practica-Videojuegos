extends CharacterBody2D

var speed = 400

var atacking = false
var current_dir = ""
var isAlive = true
var bossPointsTillDead = 0
var normalEnemyPointsTillDead = 0
var weakEnemyPointsTillDead = 0
var hp = 100
var killCounter = 0

func _ready():
	$Area2D/CollisionShape2D.disabled = true
	$Area2D2/CollisionShape2D.disabled = true
	
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
				$Area2D2/CollisionShape2D.position.y = -40
				$Area2D2/CollisionShape2D.disabled = false
				$JugadorAnimado.play("Atack_Top")
				await ($JugadorAnimado.animation_finished)
				$Area2D2/CollisionShape2D.disabled = true
				atacking = false
			elif current_dir == "down":
				$Area2D2/CollisionShape2D.position.y = 80
				$Area2D2/CollisionShape2D.disabled = false
				$JugadorAnimado.play("Atack_Down")
				await ($JugadorAnimado.animation_finished)
				$Area2D2/CollisionShape2D.disabled = true
				atacking = false
		

func getPlayerHp():
	return hp

func setPlayerHp(newHp):
	hp = newHp
	$ProgressBar.set_value(hp)
	
func getKillCounterValue():
	return killCounter

	
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

func normalEnemiesDamageReceived():
	
	isAlive = false
	if isAlive == false :
		$JugadorAnimado.play("Iddle")
	
	

func healing():
	hp = hp + 20
	$ProgressBar.set_value(hp)

func isFullHp():
	if hp == 100 :
		return true
	else :
		return false

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		if bossPointsTillDead < 10 : 
			bossPointsTillDead += 1
			body.damageReceived()
		else:
			body.dead()
			killCounter += 1
			$Label.set_text(": " + str(killCounter))
			bossPointsTillDead = 0
	elif body.is_in_group("esqueleto"):
		if normalEnemyPointsTillDead < 2 : 
			normalEnemyPointsTillDead += 1
			body.damageReceived()
		else:
			body.dead()
			if body.getIsAlive() == false :
				killCounter += 1
				$Label.set_text(": " + str(killCounter))
			normalEnemyPointsTillDead = 0
	elif body.is_in_group("duende"):
		if weakEnemyPointsTillDead < 1 : 
			weakEnemyPointsTillDead += 1
			body.damageReceived()
		else:
			body.dead()
			if body.getIsAlive() == false :
				killCounter += 1
				$Label.set_text(": " + str(killCounter))
			weakEnemyPointsTillDead = 0
		
		
	
	
	
func dead():
	$JugadorAnimado.play("Dead")
	await ($JugadorAnimado.animation_finished)
	get_tree().change_scene_to_file("res://scenes/gameOver.tscn")
	queue_free()
	


func _on_area_2d_2_body_entered(body):
	if body.is_in_group("enemy"):
		if bossPointsTillDead < 10 : 
			bossPointsTillDead = bossPointsTillDead + 1
			body.damageReceived()
		else:
			body.dead()
			killCounter = killCounter + 1
			$Label.set_text(": " + str(killCounter))
			bossPointsTillDead = 0
	elif body.is_in_group("esqueleto"):
		if normalEnemyPointsTillDead < 2 : 
			normalEnemyPointsTillDead = normalEnemyPointsTillDead + 1
			body.damageReceived()
		else:
			killCounter = killCounter + 1
			$Label.set_text(": " + str(killCounter))
			body.dead()
			normalEnemyPointsTillDead = 0
	elif body.is_in_group("duende"):
		if weakEnemyPointsTillDead < 1 : 
			weakEnemyPointsTillDead = weakEnemyPointsTillDead + 1
			body.damageReceived()
		else:
			killCounter = killCounter + 1
			$Label.set_text(": " + str(killCounter))
			body.dead()
			weakEnemyPointsTillDead = 0
		
		
