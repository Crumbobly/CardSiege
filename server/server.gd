extends Node

############## НЕ ТРОГАТЬ
var client = ENetMultiplayerPeer.new()

@rpc("authority")
func handle_request(scene_name: String, function_name: String, args: Array):
	NetworkManager.handle_request(scene_name, function_name, args)

func join_server():
	client.create_client("127.0.0.1", 12345)	
	multiplayer.multiplayer_peer = client
###############

func send_message_to_server(message: String):
	rpc_id(1, "handle_request", "Server", "client_chat_callback", [multiplayer.get_unique_id(), message])

func login(login: String, password: String):
	rpc_id(1, "handle_request", "Auth", "login", [multiplayer.get_unique_id(), login, password])

func register(login: String, password: String):
	rpc_id(1, "handle_request", "Auth", "register", [multiplayer.get_unique_id(), login, password])
	
