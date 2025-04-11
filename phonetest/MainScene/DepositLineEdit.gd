extends LineEdit


func _process(delta: float) -> void:
	for i in self.text:
		if not i.is_valid_int():
			self.text.erase(self.text.find(i))
