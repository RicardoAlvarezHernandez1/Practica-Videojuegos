extends CharacterBody2D
class_name DefaultEnemy

var speed = 190

var player = null
var running = true;
var playerLivesTillDead = 1
var BossHp = 100

func _ready():
	player = get_tree().get_nodes_in_group("Jugador")[0]
	
func  _physics_process(delta):
	
	follow()
	

func follow():
	if player != null:
		
		if running == true :
			velocity = position.direction_to(player.position) * speed
			if velocity.x > 0 :
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("Run")
			elif velocity.x < 0:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("Run")
			move_and_slide()


func dead(): 
	running = false
	$AnimatedSprite2D.play("Monster_Dead")
	await ($AnimatedSprite2D.animation_finished)
	queue_free()
	

func damageReceived():
	BossHp = BossHp - 10
	running = false
	$ProgressBar.set_value(BossHp)
	$AnimatedSprite2D.play("Damage")
	await ($AnimatedSprite2D.animation_finished)
	running = true
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Jugador"):
		if playerLivesTillDead > 0:
			playerLivesTillDead = playerLivesTillDead - 1
			running = false
			body.stopMoving()
			body.bossDamageReceived()
			$AnimatedSprite2D.play("Normal_Atack")
			await ($AnimatedSprite2D.animation_finished)
			body.continueMoving()
			running = true
		else: 
			running = false
			body.stopMoving()
			$AnimatedSprite2D.play("Normal_Atack")
			await ($AnimatedSprite2D.animation_finished)
			body.dead()
			$AnimatedSprite2D.play("Iddle")
		
		
		
		
