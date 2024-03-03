extends Node2D

var boss = preload("res://scenes/DefaultEnemy.tscn")
var esqueleto = preload("res://scenes/Esqueleto.tscn")
var goblin = preload("res://scenes/Duende.tscn")
var bool_spawn = true
var rand = RandomNumberGenerator.new()
var player = null

func _ready() -> void:
	rand.randomize()
	player = get_tree().get_nodes_in_group("Jugador")[0]

func _process(delta: float) -> void:
		spawn()

func spawn():
	if player.getKillCounterValue() < 15:
		for i in range(0,10):
			if bool_spawn:
				$Timer.start()
				bool_spawn = false
				var enemigos = [esqueleto, goblin]
				var enemigoRandom = enemigos[randi()% enemigos.size()]
				var enemigo = enemigoRandom.instantiate()
				var x = rand.randf_range(-639, 900)
				var y = rand.randf_range(-528, 900)
				enemigo.position.y = y
				enemigo.position.x = x
				add_child(enemigo)
			

func _on_timer_timeout():
	bool_spawn = true
	$Timer.start()
