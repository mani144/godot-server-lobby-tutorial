extends Control

onready var status = get_node("VBox/Status")

func _ready():
	gamestate.connect("connection_failed", self, "_on_connection_failed")
	gamestate.connect("connection_succeeded", self, "_on_connection_success")
	gamestate.connect("server_disconnected", self, "_on_server_disconnect")
	gamestate.connect("players_updated", self, "update_players_list")


func _on_JoinButton_pressed():
	gamestate.my_name = $VBox/HBox/LineEdit.text
	gamestate.connect_to_server()


func _on_connection_success():
	status.text = "Connected"
	status.modulate = Color.green
	
	$Panel.show()


func _on_connection_failed():
	status.text = "Connection Failed, trying again"
	status.modulate = Color.red
	
	$Panel.hide()


func _on_server_disconnect():
	status.text = "Server Disconnected, trying to connect..."
	status.modulate = Color.red
	
	$Panel.hide()


func update_players_list():
	$Panel/Players.text = String(gamestate.get_player_list())


func _on_ReadyButton_pressed():
	# Tell server we are ready to join the game
	$Panel/ReadyButton.disabled = true
	gamestate.rpc_id(1, "player_ready")
