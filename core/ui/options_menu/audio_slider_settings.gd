extends Control

@export var audio_name_label: Label
@export var audio_number_label: Label
@export var h_slider: HSlider

@export_enum("Master", "Music", "Sfx") var bus_name: String

@onready var bus_index: int = 0

func _ready():
	h_slider.value_changed.connect(_on_value_changed)
	get_bus_name_by_index()
	set_name_label_text()
	set_slider_value()

func set_name_label_text() -> void:
	audio_name_label.text = str(bus_name) + " Volume"

func set_audio_number_label_text() -> void:
	audio_number_label.text = str(h_slider.value * 100) + "%"

func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_number_label_text()

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_number_label_text()
