extends Node

var character_pos : Vector2 = Vector2(500,500)
var inventory: Array = ["PhoneCall"]
var trees_unlocked: Array = []
var paused : bool = false
var isDragging: bool = false
var playerOffLimitsRight: bool = false
var playerOffLimitsLeft: bool = false

var itemAttr : Dictionary = {
	"Gameboy": ["These things are so outdated now.", "So many fond memories growing up with this.", "Past"],
	"BridgePebbles": ["An old rusty bridge.", "We used to throw rocks here.\nDad could make the rocks skip 7 times in the water.", "Past"],
	"Tree": ["A tree with a swing.", "We used to play here.\nIt was like flying.",  "Past"],
	"NostalgicMemory": ["", "I miss them.", "Past"],
	"PhoneCall": ["My uncle called me complaining about my younger sister again.", "TAKE RESPONSIBILITY.",  "Future"],
	"Watch": [ "Grandpa's old watch.", "Never waste time, not even a second.",  "Future"],
	"ResponsabilityMemory": ["", "I have so many things to do.",  "Future"],
	"IceCream": [ "It's too cold out for an ice cream now.", "Tastes as good as ever.",  "Present"],
	"CollegeLetter": ["College letter of acceptance.", "Finally got accepted and they'll never know it.",  "Present"],
	"PictureOfFamily": ["Old family photo. No longer here.", "I remember spending more time with my sister when we were younger.",  "Present"],
	"Flower": ["Just an ordinary wilting flower.", "Just needs some water.",  "Present"],
	"RealityMemory": ["", "Time to face reality.",  "Present"]
	}
