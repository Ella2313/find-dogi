extends Node

var terrain: Terrain3D


func _ready() -> void:
	$UI.player = $Player
		
	if has_node("RunThisSceneLabel3D"):
		$RunThisSceneLabel3D.queue_free()


	# Enable runtime navigation baking using the terrain
	# Enable `Debug/Visible Navigation` if you wish to see it
	$RuntimeNavigationBaker.terrain = terrain
	$RuntimeNavigationBaker.enabled = true
