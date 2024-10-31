extends Node

############## НЕ ТРОГАТЬ
var client = ENetMultiplayerPeer.new()

@rpc("authority")
func handle_request(request_dict: Dictionary):
	var request = Request.from_dict(request_dict)
	NetworkManager.handle_request(request)

func join_server():
	client.create_client("79.174.95.155", 12345)	
	multiplayer.multiplayer_peer = client
###############a


func ping(callback_class: String, callback_func: String):
	var request = Request.new(\
		"Server", \
		"pong", \
		[multiplayer.get_unique_id(), Time.get_unix_time_from_system(), callback_class, callback_func]
	)
	Server.rpc_on_server(request)
	
	
func rpc_on_server(request: Request):
	rpc_id(1, "handle_request", request.to_dict())
