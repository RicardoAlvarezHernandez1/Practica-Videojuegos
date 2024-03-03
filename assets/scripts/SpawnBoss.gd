extends Node2D

var boss = preload("res://scenes/DefaultEnemy.tscn")
var bool_spawn = true
var rand = RandomNumberGenerator.new()
var player = null

func _ready() -> void:
	player = get_tree().get_nodes_in_group("Jugador")[0]

func _process(delta: float) -> void:
	spawn()
	


func spawn():
	if player.getKillCounterValue() >= 15:
		if bool_spawn:
			bool_spawn = false
			var enemigo = boss.instantiate()
			enemigo.position.y = 614.681
			enemigo.position.x = 366.316
			add_child(enemigo)
		



