extends Node

# Game port and ip
const ip = "127.0.0.1"
const DEFAULT_PORT = 8888

# Signal to let GUI know whats up
signal connection_failed()
signal connection_succeeded()
signal server_disconnected()
signal players_updated()

var my_name = "Client"

# Players dict stored as id:name
var players = {}

func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


func connect_to_server():
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(host)


# Callback from SceneTree, called when connect to server
func _connected_ok():
	emit_signal("connection_succeeded")
	
	# Register ourselves with the server
	rpc_id(1, "register_player", my_name)


# Callback from SceneTree, called when server disconnect
func _server_disconnected():
	players.clear()
	emit_signal("server_disconnected")
	
	# Try to connect again
	connect_to_server()


# Callback from SceneTree, called when unabled to connect to server
func _connected_fail():
	get_tree().set_network_peer(null) # Remove peer
	emit_signal("connection_failed")
	
	# Try to connect again
	connect_to_server()

puppet func register_player(id, new_player_data):
	players[id] = new_player_data
	emit_signal("players_updated")


puppet func unregister_player(id):
	players.erase(id)
	emit_signal("players_updated")


# Returns list of player names
func get_player_list():
	return players.values()

puppet func pre_start_game():
	get_node("/root/Main").hide()
	var world = load("res://World.tscn").instance()
	get_tree().get_root().add_child(world)
	
	rpc_id(1, "post_start_game")



 
