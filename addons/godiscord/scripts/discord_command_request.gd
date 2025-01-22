class_name DiscordCommandRequest
extends DiscordResource
## Discord slash command request

var interaction: Dictionary
var name: String
var options: Dictionary
var caller: DiscordUser

func reply(content: String):
	var url = DiscordAPI.get_url("interactions/%s/%s/callback" % [interaction["id"], interaction["token"]])
	var payload = {
		"type": 4,
		"data": {
			"content": content
		}
	}
	var http_req = HTTPRequest.new()
	DiscordRequestHandler.add_child(http_req)
	http_req.request_completed.connect(func(_r, _c, _h, _b): http_req.queue_free())
	http_req.request(url, DiscordAPI.headers, HTTPClient.METHOD_POST, JSON.stringify(payload))
