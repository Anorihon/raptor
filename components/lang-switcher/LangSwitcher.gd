extends TextureButton

const FLAG_EN = preload("res://assets/img/flags/en.png")
const FLAG_RU = preload("res://assets/img/flags/ru.png")


func _ready():
	connect("button_up", self, "_on_button_up")


func _on_button_up():
	var current_locale = TranslationServer.get_locale()
	var next_locale = 'en' if current_locale == 'ru' else 'ru'
	
	texture_normal = FLAG_EN if next_locale == 'en' else FLAG_RU
	TranslationServer.set_locale(next_locale)
	Global.emit_signal("locale_changed", TranslationServer.get_locale())
