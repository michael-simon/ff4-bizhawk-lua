--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

local CHARACTERS = {
	[0x00] = '<empty>',
	[0x01] = 'DK Cecil',
	[0x02] = 'Kain 1',
	[0x03] = 'Y. Rydia',
	[0x04] = 'Tellah 1',
	[0x05] = 'Edward',
	[0x06] = 'Rosa 1',
	[0x07] = 'Yang 1',
	[0x08] = 'Palom',
	[0x09] = 'Porom',
	[0x0A] = 'Tellah 2',
	[0x0B] = 'P. Cecil',
	[0x0C] = 'Tellah 3',
	[0x0D] = 'Yang 2',
	[0x0E] = 'Cid',
	[0x0F] = 'Kain 2',
	[0x10] = 'Rosa 2',
	[0x11] = 'A. Rydia',
	[0x12] = 'Edge',
	[0x13] = 'FuSoYa',
	[0x14] = 'Kain 3',
	[0x15] = 'Golbez',
	[0x16] = 'Anna',
}

local CLASSES = {
	[0x00] = 'Dark Knight',
	[0x01] = 'Dragoon',
	[0x02] = 'Young Caller',
	[0x03] = 'Sage',
	[0x04] = 'Bard',
	[0x05] = 'W. Wizard (Rosa)',
	[0x06] = 'Karate',
	[0x07] = 'B. Wizard',
	[0x08] = 'W. Wizard (Porom)',
	[0x09] = 'Paladin',
	[0x0A] = 'Chief',
	[0x0B] = 'Adult Caller',
	[0x0C] = 'Ninja',
	[0x0D] = 'Lunar',
	[0x0E] = 'Golbez',
}

--------------------------------------------------------------------------------
-- Stat Definitions
--------------------------------------------------------------------------------

local STATS = {
	id                     = {offset = 0x00, f = memory.readbyte,    mask = 0x1F, boolean = false},
	leftHanded             = {offset = 0x00, f = memory.readbyte,    mask = 0x40, boolean = true},
	rightHanded            = {offset = 0x00, f = memory.readbyte,    mask = 0x80, boolean = true},
	class                  = {offset = 0x01, f = memory.readbyte,    mask = 0x0F, boolean = false},
	inBackRow              = {offset = 0x01, f = memory.readbyte,    mask = 0x80, boolean = true},
	level                  = {offset = 0x02, f = memory.readbyte,    mask = nil,  boolean = false},
	-- TODO: Status Bytes: 0x03 - 0x06
	hp                     = {offset = 0x07, f = memory.read_u16_le, mask = nil,  boolean = false},
	hp_max                 = {offset = 0x09, f = memory.read_u16_le, mask = nil,  boolean = false},
	mp                     = {offset = 0x0B, f = memory.read_u16_le, mask = nil,  boolean = false},
	mp_max                 = {offset = 0x0D, f = memory.read_u16_le, mask = nil,  boolean = false},
	str_base               = {offset = 0x0F, f = memory.readbyte,    mask = nil,  boolean = false},
	agi_base               = {offset = 0x10, f = memory.readbyte,    mask = nil,  boolean = false},
	vit_base               = {offset = 0x11, f = memory.readbyte,    mask = nil,  boolean = false},
	wis_base               = {offset = 0x12, f = memory.readbyte,    mask = nil,  boolean = false},
	wil_base               = {offset = 0x13, f = memory.readbyte,    mask = nil,  boolean = false},
	str                    = {offset = 0x14, f = memory.readbyte,    mask = nil,  boolean = false},
	agi                    = {offset = 0x15, f = memory.readbyte,    mask = nil,  boolean = false},
	vit                    = {offset = 0x16, f = memory.readbyte,    mask = nil,  boolean = false},
	wis                    = {offset = 0x17, f = memory.readbyte,    mask = nil,  boolean = false},
	wil                    = {offset = 0x18, f = memory.readbyte,    mask = nil,  boolean = false},
	-- TODO: Attack Elemental: 0x19
	-- TODO: Attack Races: 0x1A
	attackMultiplier       = {offset = 0x1B, f = memory.readbyte,    mask = nil,  boolean = false},
	attackPercent          = {offset = 0x1C, f = memory.readbyte,    mask = nil,  boolean = false},
	attackBase             = {offset = 0x1D, f = memory.readbyte,    mask = nil,  boolean = false},
	-- TODO: Attack Status: 0x1E - 0x1F
	-- TODO: Element Weakness: 0x20 - 0x21
	magicDefenseMultiplier = {offset = 0x22, f = memory.readbyte,    mask = nil,  boolean = false},
	magicDefensePercent    = {offset = 0x23, f = memory.readbyte,    mask = nil,  boolean = false},
	magicDefenseBase       = {offset = 0x24, f = memory.readbyte,    mask = nil,  boolean = false},
	-- TODO: Elemental Defense: 0x25 - 0x26
	-- TODO: Racial Defense: 0x27
	defenseMultiplier      = {offset = 0x28, f = memory.readbyte,    mask = nil,  boolean = false},
	defensePercent         = {offset = 0x29, f = memory.readbyte,    mask = nil,  boolean = false},
	defenseBase            = {offset = 0x2A, f = memory.readbyte,    mask = nil,  boolean = false},
	-- TODO: Status Immunity: 0x2B - 0x2C
	criticalRate           = {offset = 0x2D, f = memory.readbyte,    mask = nil,  boolean = false},
	--unknown2E              = {offset = 0x2E, f = memory.readbyte,    mask = nil,  boolean = false},
	--unknown2F              = {offset = 0x2F, f = memory.readbyte,    mask = nil,  boolean = false},
	-- TODO: Equipment: 0x30 - 0x36
	exp                    = {offset = 0x37, f = memory.read_u24_le, mask = nil,  boolean = false},
	--unknown3A              = {offset = 0x3A, f = memory.readbyte,    mask = nil,  boolean = false},
	speedModifier          = {offset = 0x3B, f = memory.readbyte,    mask = nil,  boolean = false},
	--unknown3C              = {offset = 0x3C, f = memory.readbyte,    mask = nil,  boolean = false},
	levelUpExp             = {offset = 0x3D, f = memory.read_u24_le, mask = nil,  boolean = false},
	-- TODO: Creature Types: 0x40
	baseCriticalRate       = {offset = 0x41, f = memory.readbyte,    mask = nil,  boolean = false},
	criticalBonus          = {offset = 0x42, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown43              = {offset = 0x43, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown44              = {offset = 0x44, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown45              = {offset = 0x45, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown46              = {offset = 0x46, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown47              = {offset = 0x47, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown48              = {offset = 0x48, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown49              = {offset = 0x49, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown4A              = {offset = 0x4A, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown4B              = {offset = 0x4B, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown4C              = {offset = 0x4C, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown4D              = {offset = 0x4D, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown4E              = {offset = 0x4E, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown4F              = {offset = 0x4F, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown50              = {offset = 0x50, f = memory.readbyte,    mask = nil,  boolean = false},
--	-- 128 : Melee, 64: BigBomb, 32: Flame, 64: Bacchus, 64: Ether2: 32 for magic (spread or not)
--	-- TODO: Unknown: 0x43 - 0x50
--	-- TODO: Next Command: 0x51
--	-- TODO: Next Sub-Action: 0x52
--	-- TODO: Next Action Monster Target: 0x53
--	-- TODO: Next Action Party Target: 0x54
--	-- TODO: Unknown: 0x55 - 0x5F
--	unknown55              = {offset = 0x55, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown56              = {offset = 0x56, f = memory.readbyte,    mask = nil,  boolean = false},
--	-- 2/51 for Melee, 34/50 for BigBomb, 78/50 for Boreas, 114/50 for silkweb
--	-- 126/51 for Recall, 106/49 for psych, 90/49 for fire1, 94/49 for ice1, 138/51 for parry, 98 for lit1
--	unknown57              = {offset = 0x57, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown58              = {offset = 0x58, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown59              = {offset = 0x59, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown5A              = {offset = 0x5A, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown5B              = {offset = 0x5B, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown5C              = {offset = 0x5C, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown5D              = {offset = 0x5D, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown5E              = {offset = 0x5E, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown5F              = {offset = 0x5F, f = memory.readbyte,    mask = nil,  boolean = false},
	relativeSpeed          = {offset = 0x60, f = memory.read_u16_le, mask = nil,  boolean = false},
--	-- TODO: Unknown: 0x62 - 0x6F
--	unknown62              = {offset = 0x62, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown63              = {offset = 0x63, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown64              = {offset = 0x64, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown65              = {offset = 0x65, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown66              = {offset = 0x66, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown67              = {offset = 0x67, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown68              = {offset = 0x68, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown69              = {offset = 0x69, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown6A              = {offset = 0x6A, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown6B              = {offset = 0x6B, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown6C              = {offset = 0x6C, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown6D              = {offset = 0x6D, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown6E              = {offset = 0x6E, f = memory.readbyte,    mask = nil,  boolean = false},
--	unknown6F              = {offset = 0x6F, f = memory.readbyte,    mask = nil,  boolean = false},
	-- TODO: Level and Boss Bit: 0x70
	-- TODO: Unknown: 0x71 - 0x72
	-- TODO: Item Byte: 0x73
	-- TODO: Unknown: 0x74 - 0x7F

	unknownFlagW           = {offset = 0x00, f = memory.readbyte,    mask = 0x20, boolean = true},
	unknownFlagX           = {offset = 0x01, f = memory.readbyte,    mask = 0x10, boolean = true},
	unknownFlagY           = {offset = 0x01, f = memory.readbyte,    mask = 0x20, boolean = true},
	unknownFlagZ           = {offset = 0x01, f = memory.readbyte,    mask = 0x40, boolean = true},
}

local FLAGS = {
	{'leftHanded', 'L'},
	{'rightHanded', 'R'},
	{'inBackRow', 'B'},
}

local UNKNOWN_FLAGS = {
	{'unknownFlagW', 'W'},
	{'unknownFlagX', 'X'},
	{'unknownFlagY', 'Y'},
	{'unknownFlagZ', 'Z'},
}

--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------

local function readStat(stat, slot, battle)
	local baseAddress = 0x1000 + slot * 0x40

	if battle then
		baseAddress = 0x2000 + slot * 0x80
	end

	local stat = STATS[stat]

	if stat.offset >= 0x40 and not battle then
		return nil
	end

	local value = stat.f(baseAddress + stat.offset)

	if stat.mask then
		value = bit.band(value, stat.mask)
	end

	if stat.boolean then
		value = value > 0
	end

	return value
end

local function formatFlagString(flags, character)
	local output = ''

	for i = 1, #flags do
		local flag, description = unpack(flags[i])

		if character[flag] then
			output = output .. description
		else
			output = output .. ' '
		end
	end

	return output
end

local function readCharacter(slot, battle)
	local character = {}

	for key, _ in pairs(STATS) do
		character[key] = readStat(key, slot, battle)
	end

	character.name = CHARACTERS[character.id]
	character.className = CLASSES[character.class]
	character.stats_base = string.format('%02d %02d %02d %02d %02d', character.str_base, character.agi_base, character.vit_base, character.wis_base, character.wil_base)
	character.stats = string.format('%02d %02d %02d %02d %02d', character.str, character.agi, character.vit, character.wis, character.wil)
	character.attack = string.format('%dx %d (%d%%)', character.attackMultiplier, character.attackBase, character.attackPercent)
	character.defense = string.format('%dx %d (%d%%)', character.defenseMultiplier, character.defenseBase, character.defensePercent)
	character.magicDefense = string.format('%dx %d (%d%%)', character.magicDefenseMultiplier, character.magicDefenseBase, character.magicDefensePercent)

	character.flags = formatFlagString(FLAGS, character)
	character.unknownFlags = formatFlagString(UNKNOWN_FLAGS, character)

	return character
end

local pageWidth = 128;
local pageHeight = 112;
local horizBase = 0;
local vertBase  = 224;
	
local function drawText(slot, enemy, row, col, text, color, backcolor)
	local horiz = horizBase;
	local vert = vertBase;
	if enemy == 1 then
	   horiz = 256;
	   vert = 0;
	end
	gui.pixelText(math.floor(slot/2)*pageWidth + horiz + col * 4, (slot%2)*pageHeight + vert + row * 7, text, color, backcolor)
end

local function drawDataInPosition(data, slot, enemy)
	drawText(slot,enemy,  0, 0, string.format('Slot/Char:   %d/%s', slot, data.name))
	drawText(slot,enemy,  1, 0, string.format('Class:       %s', data.className))
	drawText(slot,enemy,  2, 13, 'LRB', 0xFF606060)
	drawText(slot,enemy,  2, 19, 'WXYZ', 0xFF606060)
	drawText(slot,enemy,  2, 0, string.format('Flags:       %s    %s', data.flags, data.unknownFlags), nil, 0x00000000)
	drawText(slot,enemy,  3, 0, string.format('Level:       %d', data.level))
	drawText(slot,enemy,  5, 0, string.format('HP: %d/%d', data.hp, data.hp_max))
	drawText(slot,enemy,  5,16, string.format('MP: %d/%d', data.mp, data.mp_max))
	drawText(slot,enemy,  6, 0, string.format('Base Stats:  %s', data.stats_base))
	drawText(slot,enemy,  7, 0, string.format('Stats:       %s', data.stats))
	drawText(slot,enemy,  8, 0, string.format('Attack:      %s', data.attack))
	drawText(slot,enemy,  9, 0, string.format('Defense:     %s', data.defense))
	drawText(slot,enemy, 10, 0, string.format('M. Defense:  %s', data.magicDefense))
	drawText(slot,enemy,  4, 0, string.format('XP: %d (%d to level)', data.exp, data.levelUpExp))
	drawText(slot,enemy,  3,16, string.format('Speed Mod.: %d', data.speedModifier))
	drawText(slot,enemy, 11, 0, string.format('Rel. Speed: %d', data.relativeSpeed))
	drawText(slot,enemy, 12, 0, string.format('Crit Rate:  %d', data.criticalRate))
	drawText(slot,enemy, 11,16, string.format('Crit Bonus: %d', data.criticalBonus))
	drawText(slot,enemy, 12,16, string.format('Base Crit:  %d', data.baseCriticalRate))

--	drawText(19, 0, string.format('Unknown 0x43:   %d', characterBattle.unknown43))
--	drawText(20, 0, string.format('Unknown 0x44:   %d', characterBattle.unknown44))
--	drawText(21, 0, string.format('Unknown 0x45:   %d', characterBattle.unknown45))
--	drawText(22, 0, string.format('Unknown 0x46:   %d', characterBattle.unknown46))
--	drawText(23, 0, string.format('Unknown 0x47:   %d', characterBattle.unknown47))
--	drawText(24, 0, string.format('Unknown 0x48:   %d', characterBattle.unknown48))
--	drawText(25, 0, string.format('Unknown 0x49:   %d', characterBattle.unknown49))
--	drawText(26, 0, string.format('Unknown 0x4A:   %d', characterBattle.unknown4A))
--	drawText(27, 0, string.format('Unknown 0x4B:   %d', characterBattle.unknown4B))
--	drawText(28, 0, string.format('Unknown 0x4C:   %d', characterBattle.unknown4C))
--	drawText(29, 0, string.format('Unknown 0x4D:   %d', characterBattle.unknown4D))
--	drawText(30, 0, string.format('Unknown 0x4E:   %d', characterBattle.unknown4E))
--	drawText(31, 0, string.format('Unknown 0x4F:   %d', characterBattle.unknown4F))
--	drawText(18, 32,string.format('Unknown 0x50:   %d', characterBattle.unknown50))
--	drawText(19, 32,string.format('Unknown 0x2E:   %d', characterBattle.unknown2E))
--	drawText(20, 32,string.format('Unknown 0x2F:   %d', characterBattle.unknown2F))
--	drawText(21, 32,string.format('Unknown 0x3A:   %d', characterBattle.unknown3A))
--	drawText(22, 32,string.format('Unknown 0x3C:   %d', characterBattle.unknown3C))
--	drawText(23, 32,string.format('Unknown 0x55:   %d', characterBattle.unknown55))
--	drawText(24, 32,string.format('Unknown 0x56:   %d', characterBattle.unknown56))
--	drawText(25, 32,string.format('Unknown 0x57:   %d', characterBattle.unknown57))
--	drawText(26, 32,string.format('Unknown 0x58:   %d', characterBattle.unknown58))
--	drawText(27, 32,string.format('Unknown 0x59:   %d', characterBattle.unknown59))
--	drawText(28, 32,string.format('Unknown 0x5A:   %d', characterBattle.unknown5A))
--	drawText(29, 32,string.format('Unknown 0x5B:   %d', characterBattle.unknown5B))
--	drawText(30, 32,string.format('Unknown 0x5C:   %d', characterBattle.unknown5C))
--	drawText(31, 32,string.format('Unknown 0x5D:   %d', characterBattle.unknown5D))
--	drawText(0, 64, string.format('Unknown 0x5E:   %d', characterBattle.unknown5E))
--	drawText(1, 64, string.format('Unknown 0x5F:   %d', characterBattle.unknown5F))
--	drawText(2, 64, string.format('Unknown 0x62:   %d', characterBattle.unknown62))
--	drawText(3, 64, string.format('Unknown 0x63:   %d', characterBattle.unknown63))
--	drawText(4, 64, string.format('Unknown 0x64:   %d', characterBattle.unknown64))
--	drawText(5, 64, string.format('Unknown 0x65:   %d', characterBattle.unknown65))
--	drawText(6, 64, string.format('Unknown 0x66:   %d', characterBattle.unknown66))
-- 	drawText(7, 64, string.format('Unknown 0x67:   %d', characterBattle.unknown67))
-- 	drawText(8, 64, string.format('Unknown 0x68:   %d', characterBattle.unknown68))
-- 	drawText(9, 64, string.format('Unknown 0x69:   %d', characterBattle.unknown69))
-- 	drawText(10,64, string.format('Unknown 0x6A:   %d', characterBattle.unknown6A))
-- 	drawText(11,64, string.format('Unknown 0x6B:   %d', characterBattle.unknown6B))
-- 	drawText(12,64, string.format('Unknown 0x6C:   %d', characterBattle.unknown6C))
-- 	drawText(13,64, string.format('Unknown 0x6D:   %d', characterBattle.unknown6D))
-- 	drawText(14,64, string.format('Unknown 0x6E:   %d', characterBattle.unknown6E))
-- 	drawText(15,64, string.format('Unknown 0x6F:   %d', characterBattle.unknown6F))
	
end

local function displayCharacterData(slot)
	local characterBattle = readCharacter(slot, true)
    drawDataInPosition(characterBattle, slot, 0)
end

local function displayEnemyData(slot)
	local enemyBattle = readCharacter(slot+6, true)
	drawDataInPosition(enemyBattle, slot, 1)
end

--------------------------------------------------------------------------------
-- Form Handling
--------------------------------------------------------------------------------

--local form
--local formLabel
--local formSlot
--local formButton
--
--local slot = 0
--
--function onExit()
--	forms.destroy(form)
--end
--
--function onUpdate()
--	slot = tonumber(forms.gettext(formSlot))
--end
--
--form = forms.newform(200, 150, "Character Record")
--formLabel = forms.label(form, 'Slot to Display:', 5, 8)
--formSlot = forms.textbox(form, '0', 170, 25, nil, 5, 32)
--formButton = forms.button(form, 'Update', onUpdate, 5, 64)
--
--event.onexit(onExit)

--------------------------------------------------------------------------------
-- Main Execution
--------------------------------------------------------------------------------

function main()
	client.SetGameExtraPadding(0, 0, 128, 224)
	displayCharacterData(0)
	displayCharacterData(1)
	displayCharacterData(2)
	displayCharacterData(3)
	displayCharacterData(4)
	displayEnemyData(0)
--	displayEnemyData(1)
--	displayEnemyData(2)
--	displayEnemyData(3)
--	displayEnemyData(4)
--	displayEnemyData(5)
--	displayEnemyData(6)
--	displayEnemyData(7)

end

while true do
	main()
	emu.frameadvance()
end
