extends CharacterBody2D
class_name Duende

var speed = 190

var player = null
var running = true;
var playerLivesTillDead = 10
var BossHp = 100
var isAlive = true


func _ready():
	player = get_tree().get_nodes_in_group("Jugador")[0]
	isAlive = true

	
func _physics_process(delta):
	follow()
	

func follow():
	if player != null:
		
		if running == true :
			velocity = position.direction_to(player.position) * speed
			if velocity.x < 0 :
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("Run")
			elif velocity.x > 0:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("Run")
			move_and_slide()


func getIsAlive():
	return isAlive

func dead(): 
	running = false
	isAlive = false
	$AnimatedSprite2D.play("Dead")
	await ($AnimatedSprite2D.animation_finished)
	queue_free()
	
	
	


func damageReceived():
	running = false
	$AnimatedSprite2D.play("TakeDamage")
	await ($AnimatedSprite2D.animation_finished)
	running = true
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Jugador"):
		if body.getPlayerHp() > 0 :
			body.setPlayerHp(body.getPlayerHp() - 10) 
			running = false
			body.stopMoving()
			body.normalEnemiesDamageReceived()
			$AnimatedSprite2D.play("Atack")
			await ($AnimatedSprite2D.animation_finished)
			body.continueMoving()
			running = true
		else: 
			running = false
			body.stopMoving()
			$AnimatedSprite2D.play("Atack")
			await ($AnimatedSprite2D.animation_finished)
			body.dead()
			$AnimatedSprite2D.play("Iddle")
			running = true
		
		
		
		

