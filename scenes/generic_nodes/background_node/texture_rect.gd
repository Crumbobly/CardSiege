extends TextureRect

@export_group("Backgrounds Directory Path")
@export var dirAddon: String
var dirPath : String

var backgrounds: Array[String]
var bCounter: int
var bSize: int

@onready var fadeInTimer: Timer = $FadeInTimer
@onready var animationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fadeInTimer: Timer = $FadeInTimer
	var animationPlayer: AnimationPlayer = $AnimationPlayer
	var waitTime: int = 10

	dirPath = "res://assets/images/%s/" % [dirAddon]
	backgrounds = FilesParser.enlistFiles(dirPath)
	
	bCounter = -1
	bSize = backgrounds.size()
	
	if bSize > 0: 
		texture = load(backgrounds[0])
		bCounter = 0
	
	fadeInTimer.timeout.connect(_on_fadeInTimeout)
	animationPlayer.animation_finished.connect(_on_animationFinished)
	
	fadeInTimer.start(waitTime)

func _on_fadeInTimeout():
	animationPlayer.play("FadeToBlack")

func _on_animationFinished(anim_name: String):
	if(anim_name == "FadeToBlack"): fadeToBlackFinished()
	if(anim_name == "FadeToNormal"): fadeToNormalFinished()
	
func fadeToBlackFinished():
	bCounter = (bCounter + 1) % bSize
	texture = load(backgrounds[bCounter])
	animationPlayer.play("FadeToNormal")

func fadeToNormalFinished():
	fadeInTimer.start()
