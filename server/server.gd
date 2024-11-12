extends Node

var request_handler = RequestHandler.new()
var websocket_url = "127.0.0.1:12345"
var socket = WebSocketPeer.new()


func _ready():
	var err = socket.connect_to_url(websocket_url)
	if err != OK:
		print("Ошибка подключения")
		set_process(false)

	
func _process(_delta):
	socket.poll()

	var state = socket.get_ready_state()

	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var packet = socket.get_packet().get_string_from_utf8()
			var json_result = JSON.parse_string(packet) 
			var request = Request.from_dict(json_result)
			request_handler.handle_request(request)

	elif state == WebSocketPeer.STATE_CLOSING:
		pass

	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		print("Соеденение закрыто с ошибкой: %d. Clean: %s" % [code, code != -1])
		set_process(false)
		

func send_request(request: Request):
	socket.send_text(JSON.stringify(request.to_dict()))
