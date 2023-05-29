local config = {
	boss = {
		name = "Faceless Bane",
		position = Position(33617, 32561, 13),
	},
	requiredLevel = 250,
	timeToFightAgain = 20 * 60 * 60,
	timeToDefeatBoss = 10 * 60,
	playerPositions = {
		{ pos = Position(33638, 32562, 13), teleport = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33639, 32562, 13), teleport = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33640, 32562, 13), teleport = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33641, 32562, 13), teleport = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT },
		{ pos = Position(33642, 32562, 13), teleport = Position(33617, 32567, 13), effect = CONST_ME_TELEPORT }
	},
	specPos = {
		from = Position(33607, 32553, 13),
		to = Position(33627, 32570, 13)
	},
	exit = Position(33618, 32523, 15),
	storage = Storage.Quest.U12_00.TheDreamCourts.FacelessBaneTime
}

local threatenedLever = Action()

function threatenedLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	return CreateDefaultLeverBoss(player, config)
end

threatenedLever:uid(1039)
threatenedLever:register()
