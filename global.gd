extends Node

@export var floorCount = 3
@export var currentGold = 3000
@export var cost = 0
@export var currentFloor = 1

var floorArray = Array()

var floorGrid = []
var floor_width = 5
var floor_height = 5
var scores = []
var puzzleChallenge = []

var bossPlaced = false

var heroHealth = 100
var heroGaveUp = false
var score = 0

var heroes = [] #[defense, persistence, potionCount]

var def = 0
var per = 0
var potions = 0

var currentGoldString = "Current Gold: " + str(currentGold) + "\n"

enum Features {BOSS, CHEST}
