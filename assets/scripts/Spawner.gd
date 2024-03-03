extends Node2D

var boss = preload("res://scenes/DefaultEnemy.tscn")
var esqueleto = preload("res://scenes/DefaultEnemy.tscn")
var goblin = preload("res://scenes/DefaultEnemy.tscn")
#sustituir por golbin y esqueleto respectivamente
var bool_spawn = true
var rand = RandomNumberGenerator.new()

func _ready() -> void:
	rand.randomize()

func _process(delta: float) -> void:
		spawn()

func spawn():
	if bool_spawn:
		$Timer.start()
		bool_spawn = false
		var enemigos = [boss, esqueleto, goblin]
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
