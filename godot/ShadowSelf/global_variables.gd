extends Node

var character_pos : Vector2
var volume_music : float = 0.5
var volume_effects: float = 0.5

var inventory: Array = ["Watch", "Gameboy", "PhoneCall"]
var trees_unlocked: Array = ["Future", "Present"]
var paused : bool = false
var isDragging: bool = false

var itemAttr : Dictionary = {
	"Gameboy": ["These things are so outdated now.", "So many fond memories growing up with this.", "Past"],
	"Bridge": ["An old rusty bridge.", "We used to throw rocks here.", "Past"],
	"Tree": ["A tree with a swing.", "We used to play here.",  "Past"],
	"NostalgicMemory": ["this item is bad", "this item is good", "Past"],
	"PhoneCall": ["My uncle is complaining about my younger sister again.", "TAKE RESPONSIBILITY.",  "Future"],
	"Watch": [ "A old watch.", "Never waste time, not even a second.",  "Future"],
	"ResponsabilityMemory": ["this item is bad", "this item is good",  "Future"],
	"IceCream": [ "It's too cold out for an ice cream now.", "Tastes as good as ever.",  "Present"],
	"CollegeLetter": ["College letter of rejection.", "They never knew I got accepted.",  "Present"],
	"PictureOfFamily": ["Old family photo.", "I remember spending more time with my sister when we were younger.",  "Present"],
	"Flower": ["Just an ordinary wilting flower.", "Just needs some water.",  "Present"],
	"RealityMemory": ["this item is bad", "this item is good",  "Present"]
	}

var dialog: Dictionary = {
	1: "Hey this is your uncle!",
	2: "",
	3: "",
	4: "",
	}
