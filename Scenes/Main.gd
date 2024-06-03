extends Node2D

# --------- Scenes ---------
var domino_blue:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteBleu.tscn")
var domino_red:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRouge.tscn")
var domino_green:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteVert.tscn")
var pinkfloyd:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteRose.tscn")
var domino_yellow:PackedScene = preload("res://Scenes/Domino/DominoPalette/DominoPaletteJaune.tscn")

var regle_inst:PackedScene = preload("res://Scenes/Règle.tscn")

# --------- Signals ---------
signal base_activer(index_regle)

# --------- Constants ---------
const max_nb_domino = 13
const max_nb_regles = 8
const max_nb_domino_par_cote_regle = 4

# --------- Variables ---------
var regle_select:int = -1
var base:bool = false
var objectif:bool = false

func _ready():
	base = true
	$"%PanelBase".color = Color.gainsboro

func _process(_delta):
	pass

# --------- Signal handlers palette ---------
func _on_DominoPaletteBleu_click_domino_bleu():
	var instance_bleu = domino_blue.instance()
	instance_bleu.connect("supp_domino",self,"supp_domino_handle")
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_bleu.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_bleu)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_bleu.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_bleu)
	elif regle_select != -1:
		ajouter_a_regle(instance_bleu)

func _on_DominoPaletteRouge_click_domino_rouge():
	var instance_rouge = domino_red.instance()
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_rouge.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_rouge)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_rouge.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_rouge)
	elif regle_select != -1:
		ajouter_a_regle(instance_rouge)

func _on_DominoPaletteVert_click_domino_vert():
	var instance_vert = domino_green.instance()
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_vert.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_vert)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_vert.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_vert)
	elif regle_select != -1:
		ajouter_a_regle(instance_vert)

func _on_DominoPaletteJaune_click_domino_jaune():
	var instance_jaune = domino_yellow.instance()
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_jaune.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_jaune)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_jaune.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_jaune)
	elif regle_select != -1:
		ajouter_a_regle(instance_jaune)

func _on_DominoPaletteRose_click_domino_rose():
	var instance_rose = pinkfloyd.instance()
	if base :
		if $"%PanelBase".get_child_count() - 1 < max_nb_domino :
			instance_rose.position = $"%BasePoint".position + (Vector2.RIGHT * 45 * ($"%PanelBase".get_child_count() - 1))
			$"%PanelBase".add_child(instance_rose)
	elif objectif :
		if $"%PanelObjectif".get_child_count() - 1 < max_nb_domino :
			instance_rose.position = $"%ObjectifPoint".position + (Vector2.RIGHT * 45 * ($"%PanelObjectif".get_child_count() - 1))
			$"%PanelObjectif".add_child(instance_rose)
	elif regle_select != -1:
		ajouter_a_regle(instance_rose)

# --------- Signal handler base slection ---------
func _on_PanelBase_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		base = true
		objectif = false
		$"%PanelBase".color = Color.gainsboro
		$"%PanelObjectif".color = Color.white
		regle_select = -1
		emit_signal("base_activer",-1)
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		_propagate_event(event,$"%PanelBase")

# --------- Signal handler objective selection ---------
func _on_PanelObjectif_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		objectif = true
		$"%PanelObjectif".color = Color.gainsboro
		base = false
		$"%PanelBase".color = Color.white
		regle_select = -1
		emit_signal("base_activer",-1)
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
			_propagate_event(event,$"%PanelObjectif")
# --------- Signal handler add rule button ---------
func _on_Button_pressed():
	if $"%PanelRegles".get_child_count() -1 < max_nb_regles :
		var instance_regle = regle_inst.instance()
		instance_regle.position = $"%ReglePoint".position + (Vector2.DOWN * 60 * ($"%PanelRegles".get_child_count() - 1))
		instance_regle.connect("regle_activer",self,"regle_activer_handle")
		$"%PanelRegles".add_child(instance_regle)

# --------- Signal handlers remove rule focus ---------
func _on_Fond_base_activer(index_regle):
	var children = $"%PanelRegles".get_children()
	for child in children:
		if child is Position2D or (index_regle != -1 and child.get_index() == index_regle) :
			continue
		if child.name.find("Regle") >= 0:
			remove_focus_regle(child)

# --------- Helper functions ---------
func regle_activer_handle(index):
	regle_select = index
	base = false
	objectif = false
	$"%PanelBase".color = Color.white
	$"%PanelObjectif".color = Color.white
	
	_on_Fond_base_activer(index)

func remove_focus_regle(regle):
	regle.regle = false
	regle.droite = false
	regle.gauche = false
	
	# Getting ColorRect 
	var regle_children = regle.get_children()[0]
	regle_children.color = Color.white
	#Getting the children of ColorRect
	regle_children = regle_children.get_children()
	regle_children[1].color = Color.white
	regle_children[3].color = Color.white

func ajouter_a_regle(instance):
	# regle contient le noeud de la scène (Node2D)
	var regle = $"%PanelRegles".get_children()[regle_select]
#	print(regle)
	#sous regle contient les enfants : AreaPrincipale, Gauche,Flèche,Droite
	var sous_regle = regle.get_children()[0].get_children()
#	print(sous_regle)
	if regle.droite:
		if sous_regle[3].get_child_count() - 2 < max_nb_domino_par_cote_regle :
			instance.position = sous_regle[3].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[3].get_child_count() - 2))
			instance.scale = Vector2(0.15,0.15)
			sous_regle[3].add_child(instance)
	elif regle.gauche:
		if sous_regle[1].get_child_count() - 2 < max_nb_domino_par_cote_regle :
			instance.position = sous_regle[1].get_children()[1].position + (Vector2.RIGHT * 10 * (sous_regle[1].get_child_count() - 2))
			instance.scale = Vector2(0.15,0.15)
			sous_regle[1].add_child(instance)

func _on_BJouer_pressed():
	get_tree().change_scene("res://Scenes/Resolution.tscn")

# pour propager le signal aux dominos
func _propagate_event(event,node):
	var mouse_pos = get_local_mouse_position()
	for child in node.get_children():
		if not (child is Position2D) and child.get_rect().has_point(mouse_pos):
			child.input(event)

func supp_domino_handle(id,parent):
	print(id,parent)
