extends Node

var ip = "127.0.0.1"
var port = 12305
var network = NetworkedMultiplayerENet.new()


func _ready():
	connect_to_server()


func connect_to_server():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")
	print("Try to connect")


func _on_connection_failed():
	print("Failed to connect")


func _on_connection_succeeded():
	print("Succesfully connected")
	rpc_id(1, "hello")


remote func wassaup(num):
	print("Hello from Server " + str(num))
