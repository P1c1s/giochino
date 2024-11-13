extends Control

var username = ""
var password

var created = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	if !created:
		username = $Username.text
		password = $Password.text.sha256_text()
		created = true
		$Login.text = "Login"
		$Username.text = ""
		$Password.text = ""
		print("Account Created!")
	else:
		if $Username.text == username:
			if $Password.text.sha256_text() == password:
				print("Login Success!")
			else:
				print("Login Failed!")
		else: 
			print("Login Failed!")
