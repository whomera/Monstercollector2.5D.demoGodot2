extends NinePatchRect

# Riferimenti ai nodi
@onready var close_button: Button = $Button2
@onready var scroll_button: Button = $Button
@onready var dialog_label: Label = $Label

# Segnale per indicare che il dialogo è finito
signal dialogue_finished

# Variabili per gestire il dialogo
var dialog_lines: Array = [
	"Benvenuto nel mondo di Godot!",
	"Questa è una demo di come scrollare le linee di dialogo.",
	"Puoi cambiare il testo come desideri.",
	"Godot è un motore di gioco potente e flessibile.",
	"Grazie per avermi scelto per il tuo progetto!"
]
var current_line_index: int = 0

func _ready():
	# Disabilita la funzione _process()
	
	# Nascondi il TextBox
	hide()

	# Connetti i segnali dei pulsanti


	# Inizializza il Label
	dialog_label.set_visible_characters(0)
	dialog_label.set_lines_skipped(0)

func _process(_delta):
	if Input.is_action_just_pressed("ui_y"):
		# Emetti il segnale "dialogue_finished"
		emit_signal("dialogue_finished")
		# Nascondi il TextBox
		hide()
		# Disabilita la funzione _process()
		set_process(false)
		dialog_label.set_visible_characters(0)
		dialog_label.set_lines_skipped(0)

# Funzione per aggiornare il testo visualizzato
func _on_KinematicBody_dialogue_started():
	print("Dialogo iniziato")
	if current_line_index == 0:
		var visible_characters_duration = dialog_label.get_visible_line_count() * 1.3
		var dialog_tween = create_tween()
		dialog_tween.tween_property(dialog_label, "visible_characters", dialog_label.get_total_character_count(), visible_characters_duration)
	_show_next_line()

func _on_scroll_button_pressed():
	_show_next_line()
	var visible_characters_duration = dialog_label.get_visible_line_count() * 1.3
	var dialog_tween = create_tween()
	dialog_label.set_visible_characters(0)
	dialog_tween.tween_property(dialog_label, "visible_characters", dialog_label.get_total_character_count(), visible_characters_duration)
	await get_tree().create_timer(visible_characters_duration).timeout
	scroll_button.grab_focus()
	

func _on_close_button_pressed():
	# Nascondi il dialogo senza rimuovere il nodo
	emit_signal("dialogue_finished")
	hide()
	# Disabilita la funzione _process()
	set_process(false)
	dialog_label.set_visible_characters(0)
	dialog_label.set_lines_skipped(0)
	current_line_index = 0

func _show_next_line():
	if current_line_index < dialog_lines.size():
		dialog_label.text = dialog_lines[current_line_index]
		current_line_index += 1
		var visible_characters_duration = dialog_label.get_visible_line_count() * 1.3
		var dialog_tween = create_tween()
		dialog_tween.tween_property(dialog_label, "visible_characters", dialog_label.get_total_character_count(), visible_characters_duration)
		# Mostra il TextBox
		show()
		# Abilita la funzione _process()
		set_process(true)
		await get_tree().create_timer(visible_characters_duration).timeout
		scroll_button.grab_focus()
	else:
		# Se non ci sono più linee da mostrare, emetti il segnale "dialogue_finished"
		emit_signal("dialogue_finished")
		# Nascondi il TextBox
		hide()
		# Disabilita la funzione _process()
		set_process(false)
		current_line_index = 0
		dialog_label.set_visible_characters(0)
		dialog_label.set_lines_skipped(0)
		current_line_index = 0
		

func show_dialog():
	# Mostra il dialogo e resetta l'indice delle linee

	_show_next_line()
	
