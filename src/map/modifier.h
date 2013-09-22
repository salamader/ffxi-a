/*
===========================================================================

  Copyright (c) 2010-2012 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

  This file is part of DarkStar-server source code.

===========================================================================
*/

#ifndef _CMODIFIER_H
#define _CMODIFIER_H

#include "../common/cbasetypes.h"

enum MODIFIER
{
	MOD_NONE				= 0x00,

	MOD_DEF					= 0x01,		// Target's Defense
	MOD_HP					= 0x02,		// Target's HP
	MOD_HPP					= 0x03,		// HP Percentage
	MOD_CONVMPTOHP			= 0x04,		// MP -> HP (Cassie Earring)
	MOD_MP					= 0x05,		// MP +/-
	MOD_MPP					= 0x06,		// MP Percentage
	MOD_CONVHPTOMP			= 0x07,		// HP -> MP

	MOD_STR					= 0x08,		// Strength
	MOD_DEX					= 0x09,		// Dexterity
	MOD_VIT					= 0x0A,		// Vitality
	MOD_AGI					= 0x0B,		// Agility
	MOD_INT					= 0x0C,		// Intelligence
	MOD_MND					= 0x0D,		// Mind
	MOD_CHR					= 0x0E,		// Charisma

// Elemental Defenses

	MOD_FIREDEF				= 0x0F,		// Fire Defense
	MOD_ICEDEF				= 0x10,		// Ice Defense
	MOD_WINDDEF				= 0x11,		// Wind Defense
	MOD_EARTHDEF			= 0x12,		// Earth Defense
	MOD_THUNDERDEF			= 0x13,		// Thunder Defense
	MOD_WATERDEF			= 0x14,		// Water Defense
	MOD_LIGHTDEF			= 0x15,		// Light Defense
	MOD_DARKDEF				= 0x16,		// Dark Defense

	MOD_ATT					= 0x17,		// Attack
	MOD_RATT				= 0x18,		// Ranged Attack

	MOD_ACC					= 0x19,		// Accuracy
	MOD_RACC				= 0x1A,		// Ranged Accuracy

	MOD_ENMITY				= 0x1B,		// Enmity
	MOD_TRANQUIL_HEART		= 0x233,	// Reduces enmity bases on healing skill (only checks if > 0)

	MOD_MATT				= 0x1C,		// Magic Attack
	MOD_MDEF				= 0x1D,		// Magic Defense
	MOD_MACC				= 0x1E,		// Magic Accuracy
	MOD_MEVA				= 0x1F,		// Magic Evasion
	MOD_MAG_DMG_STAT		= 0x243,	// Magic Damage Stat from equip
	MOD_MAG_BURST_BONUS		= 0x19E,	// Magic Burst Dmg % Bonus
	MOD_ELEM_MAG_DMG		= 0x1A2,	// Elemental Magic Dmg % Bonus
	MOD_ENFB_MAG_DMG		= 0x1A3,	// Enfeebling Magic Dmg % Bonus
	MOD_NIN_MAG_DMG			= 0x1A4,	// Ninjutsu Magic Dmg % Bonus

// Magic Accuracy and Elemental Attacks

	MOD_FIREATT				= 0x20,		// Fire Damage
	MOD_ICEATT				= 0x21,		// Ice Damage
	MOD_WINDATT				= 0x22,		// Wind Damage
	MOD_EARTHATT			= 0x23,		// Earth Damage
	MOD_THUNDERATT			= 0x24,		// Thunder Damage
	MOD_WATERATT			= 0x25,		// Water Damage
	MOD_LIGHTATT			= 0x26,		// Light Damage
	MOD_DARKATT				= 0x27,		// Dark Damage
	MOD_FIREACC				= 0x28,		// Fire Accuracy
	MOD_ICEACC				= 0x29,		// Ice Accuracy
	MOD_WINDACC				= 0x2A,		// Wind Accuracy
	MOD_EARTHACC			= 0x2B,		// Earth Accuracy
	MOD_THUNDERACC			= 0x2C,		// Thunder Accuracy
	MOD_WATERACC			= 0x2D,		// Water Accuracy
	MOD_LIGHTACC			= 0x2E,		// Light Accuracy
	MOD_DARKACC				= 0x2F,		// Dark Accuracy

	MOD_WSACC				= 0x30,		// Weaponskill Accuracy
	MOD_WS_DMG				= 0x1C9,	// Weaponskill Damage %

// Resistance to damage type
// Value is stored as a percentage of damage reduction (to within 1000)
// Example: 1000 = 100%, 875 = 87.5%

	MOD_SLASHRES			= 0x31,  // Slash Resistance
	MOD_PIERCERES			= 0x32,	 // Piercing Resistance
	MOD_IMPACTRES			= 0x33,	 // Impact Resistance
	MOD_HTHRES				= 0x34,  // Hand-To-Hand Resistance


// Damage Reduction to Elements
// Value is stored as a percentage of damage reduction (to within 1000)
// Example: 1000 = 100%, 875 = 87.5%

	MOD_FIRERES				= 0x36,		// % Fire Resistance
	MOD_ICERES				= 0x37,		// % Ice Resistance
	MOD_WINDRES				= 0x38,		// % Wind Resistance
	MOD_EARTHRES			= 0x39,		// % Earth Resistance
	MOD_THUNDERRES			= 0x3A,		// % Thunder Resistance
	MOD_WATERRES			= 0x3B,		// % Water Resistance
	MOD_LIGHTRES			= 0x3C,		// % Light Resistance
	MOD_DARKRES				= 0x3D,		// % Dark Resistance

	MOD_ATTP				= 0x3E,		// % Attack
	MOD_DEFP				= 0x3F,		// % Defense
	MOD_ACCP				= 0x40,		// % Accuracy
	MOD_EVAP				= 0x41,		// % Evasion
	MOD_RATTP				= 0x42,		// % Ranged Attack
	MOD_RACCP				= 0x43,		// % Ranged Attack Accuracy
	MOD_PARRYP				= 0x232,	// % Parry

	MOD_EVA					= 0x44,		// Evasion
	MOD_RDEF				= 0x45,		// Ranged Defense
	MOD_REVA				= 0x46,		// Ranged Evasion
	MOD_MPHEAL				= 0x47,		// MP Recovered while healing
	MOD_HPHEAL				= 0x48,		// HP Recovered while healing
	MOD_STORETP				= 0x49,		// Increases the rate at which TP is gained

// Working Skills (weapon combat skills)

	MOD_HTH					= 0x50,		// Hand To Hand
	MOD_DAGGER				= 0x51,		// Dagger
	MOD_SWORD				= 0x52,		// Sword
	MOD_GSWORD				= 0x53,		// Great Sword
	MOD_AXE					= 0x54,		// Axe
	MOD_GAXE				= 0x55,		// Great Axe
	MOD_SCYTHE				= 0x56,		// Scythe
	MOD_POLEARM				= 0x57,		// Polearm
	MOD_KATANA				= 0x58,		// Katana
	MOD_GKATANA				= 0x59,		// Great Katana
	MOD_CLUB				= 0x5A,		// Club
	MOD_STAFF				= 0x5B,		// Staff
	MOD_ARCHERY				= 0x68,		// Archery
	MOD_MARKSMAN			= 0x69,		// Marksman
	MOD_THROW				= 0x6A,		// Throw
	MOD_GUARD				= 0x6B,		// Guard
	MOD_EVASION				= 0x6C,		// Evasion
	MOD_SHIELD				= 0x6D,		// Shield
	MOD_PARRY				= 0x6E,		// Parry

// Magic Skills

	MOD_DIVINE				= 0x6F,
	MOD_HEALING				= 0x70,
	MOD_ENHANCE				= 0x71,
	MOD_ENFEEBLE			= 0x72,
	MOD_ELEM				= 0x73,
	MOD_DARK				= 0x74,
	MOD_SUMMONING			= 0x75,
	MOD_NINJUTSU			= 0x76,
	MOD_SINGING				= 0x77,
	MOD_STRING				= 0x78,
	MOD_WIND				= 0x79,
	MOD_BLUE				= 0x7A,
	MOD_GEOMANCY			= 0x244,

// Synthesis Skills

	MOD_FISH				= 0x7F,
	MOD_WOOD				= 0x80,
	MOD_SMITH				= 0x81,
	MOD_GOLDSMITH			= 0x82,
	MOD_CLOTH				= 0x83,
	MOD_LEATHER				= 0x84,
	MOD_BONE				= 0x85,
	MOD_ALCHEMY				= 0x86,
	MOD_COOK				= 0x87,
	MOD_SYNERGY				= 0x88,
	MOD_RIDING				= 0x89,

	MOD_GOLDFISHING			= 0x1D1,

// Chance you will not make an hq synth (Impossibility of HQ synth)

	MOD_ANTIHQ_WOOD			= 0x90,
	MOD_ANTIHQ_SMITH		= 0x91,
	MOD_ANTIHQ_GOLDSMITH	= 0x92,
	MOD_ANTIHQ_CLOTH		= 0x93,
	MOD_ANTIHQ_LEATHER		= 0x94,
	MOD_ANTIHQ_BONE			= 0x95,
	MOD_ANTIHQ_ALCHEMY		= 0x96,
	MOD_ANTIHQ_COOK			= 0x97,

// Damage / Crit Damage / Delay

	MOD_DMG					= 0xA0,				// Damage Multiplier
	MOD_DMGPHYS				= 0xA1,				// Physical Damage Multiplier
	MOD_DMGBREATH			= 0xA2,				// Breath Damage Multiplier
	MOD_DMGMAGIC			= 0xA3,				// Magic Damage Multiplier - 256 base! (value of -24 means -24/256 magic damage taken)
	MOD_DMGRANGE			= 0xA4,				// Range Damage Multiplier

	MOD_UDMGPHYS			= 0x183,			// Uncapped Damage Multipliers
	MOD_UDMGBREATH			= 0x184,			// Used in sentinal, invincible, physical shield etc
	MOD_UDMGMAGIC			= 0x185,
	MOD_UDMGRANGE			= 0x186,

	MOD_CRITHITRATE			= 0xA5,				// Raises chance to crit
	MOD_ENEMYCRITRATE		= 0xA6,				// Raises chance enemy will crit
	MOD_CRIT_DMG			= 0x1CB,			// Raises Crit Hit Dmg % divided by 100
	MOD_MAGIC_CRIT_RATE		= 0x22F,			// Raises chance to Magic Crit
	MOD_MAG_CRIT_DMG		= 0x230,			// Raises Magic Crit Dmg (MAB)

	MOD_SHIELD_DEF			= 0x1CC,			// Shield Dmg Reduction % Bonus

	MOD_HASTE_MAGIC			= 0xA7,				// Haste (and Slow) from magic - 1024 base! (448 cap)
	MOD_HASTE_ABILITY		= 0x17F,			// Haste (and Slow) from abilities - 1024 base! (256 cap?)
	MOD_HASTE_GEAR			= 0x180,			// Haste (and Slow) from equipment - 1024 base! (256 cap)
	MOD_SPELLINTERRUPT		= 0xA8,				// % Spell Interruption Rate
	MOD_MOVE				= 0xA9,				// % Movement Speed
	MOD_FASTCAST			= 0xAA,				// Increases Spell Cast Time (TRAIT)
	MOD_UFASTCAST			= 0x241,			// Increases Uncapped Spell Cast Time
	MOD_DELAY				= 0xAB,				// Increase/Decrease Delay
	MOD_RANGED_DELAY		= 0xAC,				// Increase/Decrease Ranged Delay
	MOD_MARTIAL_ARTS		= 0xAD,				// The integer amount of delay to reduce from H2H weapons' base delay. (TRAIT)
    MOD_SKILLCHAINBONUS     = 0xAE,				// Damage bonus applied to skill chain damage.  Modifier from effects/traits
    MOD_SKILLCHAINDMG       = 0xAF,				// Damage bonus applied to skill chain damage.  Modifier from gear (multiplicative after effect/traits)

// FOOD!

	MOD_FOOD_HPP			= 0xB0,
	MOD_FOOD_HP_CAP			= 0xB1,
	MOD_FOOD_MPP			= 0xB2,
	MOD_FOOD_MP_CAP			= 0xB3,
	MOD_FOOD_ATTP			= 0xB4,
	MOD_FOOD_ATT_CAP		= 0xB5,
	MOD_FOOD_DEFP			= 0xB6,
	MOD_FOOD_DEF_CAP		= 0xB7,
	MOD_FOOD_ACCP			= 0xB8,
	MOD_FOOD_ACC_CAP		= 0xB9,
	MOD_FOOD_RATTP			= 0xBA,
	MOD_FOOD_RATT_CAP		= 0xBB,
	MOD_FOOD_RACCP			= 0xBC,
	MOD_FOOD_RACC_CAP		= 0xBD,

// Killer-Effects - (Most by Traits/JobAbility)

	MOD_VERMIN_KILLER		= 0xE0,
	MOD_BIRD_KILLER			= 0xE1,
	MOD_AMORPH_KILLER		= 0xE2,
	MOD_LIZARD_KILLER		= 0xE3,
	MOD_AQUAN_KILLER		= 0xE4,
	MOD_PLANTOID_KILLER		= 0xE5,
	MOD_BEAST_KILLER		= 0xE6,
	MOD_UNDEAD_KILLER		= 0xE7,
	MOD_ARCANA_KILLER		= 0xE8,
	MOD_DRAGON_KILLER		= 0xE9,
	MOD_DEMON_KILLER		= 0xEA,
	MOD_EMPTY_KILLER		= 0xEB,
	MOD_HUMANOID_KILLER		= 0xEC,
    MOD_LUMORIAN_KILLER     = 0xED,
    MOD_LUMINION_KILLER     = 0xEE,

// Resistances and Damage increase to Ecosystems - Circle JAs
	MOD_DRAGON_DMG			= 0x239,
	MOD_ARCANE_DMG			= 0x23A,
	MOD_UNDEAD_DMG			= 0x23B,
	MOD_DEMON_DMG			= 0x23C,

// Resistances to enfeebles - Traits/Job Ability

	MOD_SLEEPRES			= 0xF0,
	MOD_POISONRES			= 0xF1,
	MOD_PARALYZERES			= 0xF2,
	MOD_BLINDRES			= 0xF3,
	MOD_SILENCERES			= 0xF4,
	MOD_VIRUSRES			= 0xF5,
	MOD_PETRIFYRES			= 0xF6,
	MOD_BINDRES				= 0xF7,
	MOD_CURSERES			= 0xF8,
	MOD_GRAVITYRES			= 0xF9,
	MOD_SLOWRES				= 0xFA,
	MOD_STUNRES				= 0xFB,
	MOD_CHARMRES			= 0xFC,
	MOD_DEATHRES			= 0xFD,				// Not sure if I can just fill in a blank
	MOD_TERRORRES			= 0xFE,				// empty inbetween on POL Utils
	MOD_AMNESIARES			= 0xFF,
	MOD_DOOMRES				= 0x19C,

	MOD_PARALYZE			= 0x101,			// Paralyze -- percent chance to proc
	MOD_MIJIN_GAKURE		= 0x102,			// Tracks whether or not you used this ability to die.
	MOD_DUAL_WIELD			= 0x103,			// Percent reduction in dual wield delay.
	MOD_SHIELD_MASTERY		= 0x1CD,			// Extra TP Gained from a Block
	MOD_TACTICAL_GUARD		= 0x1CE,			// Extra TP Gained from a Guard
	MOD_TACTICAL_PARRY		= 0x1CF,			// Extra TP Gained from a Parry
	MOD_OCCULT_ACCUMEN		= 0x1D0,			// TP Gained from Elemental or Dark Magic Casts divided by 1000

// Warrior
	MOD_DOUBLE_ATTACK		= 0x120,			// Percent chance to proc
	MOD_RETALIATION_DMG		= 0x1DB,			// % increase to Retaliation Dmg
	MOD_BLOOD_RAGE			= 0x228,			// Blood Rage duration

// Monk
	MOD_SUBTLE_BLOW			= 0x121,			// How much TP to reduce.
	MOD_COUNTER				= 0x123,			// Percent chance to counter
	MOD_KICK_ATTACK			= 0x124,			// Percent chance to kick
	MOD_KICK_DMG			= 0x182, 			// increases kick attack damage
	MOD_COUNTER_BASE_DMG	= 0x1D9,			// Increase Weapon Base DMG on Counters
	MOD_PFT_COUNTER_DMG		= 0x21A,			// Increase Weapon Base DMG on Perfect Counter

// White Mage
	MOD_AFFLATUS_SOLACE		= 0x125,			// Pool of HP accumulated during Afflatus Solace
	MOD_AFFLATUS_MISERY		= 0x126,			// Pool of HP accumulated during Afflatus Misery
	MOD_DIVINE_BENISON_FASTCAST		= 0x234,	// Divine Benison Fastcast Mod
	MOD_DIVINE_BENISON_ENMITY		= 0x235,	// Divine Benison Enmity Mod

// Black Mage
	MOD_CLEAR_MIND			= 0x127,			// Used in conjunction with MOD_HEALMP to increase amount between tics
	MOD_CONSERVE_MP			= 0x128,			// Percent chance
	MOD_MANA_WALL_DMG		= 0x21B,			// Percent additional Dmg Reduction to Mana Wall

// Red Mage
	MOD_BLINK				= 0x12B,			// Tracks blink shadows
	MOD_STONESKIN			= 0x12C,			// Tracks stoneskin HP pool
	MOD_PHALANX				= 0x12D,			// Tracks direct damage reduction
	MOD_SABOTEUR			= 0x220,			// Increase Potency and Duration durring Saboteur

// Thief
    MOD_STEAL               = 0x12A,			// Increase/Decrease THF Steal chance
	MOD_TRIPLE_ATTACK		= 0x12E,			// Percent chance
	MOD_TREASURE_HUNTER     = 0x12F,			// Percent chance
	MOD_SNEAK_ATK_MOD		= 0x1CA,			// Modifier for DEX Divided by 10 (1 = .01)
	MOD_TRICK_ATK_MOD		= 0x1D6,			// Modifier for AGI %
	MOD_SATA_DMG			= 0x1D7,			// SA TA Dmg Modifier %
	MOD_GILFINDER			= 0x1D4,			// Gil dropped from mob +50% per mod
	MOD_DESPOIL				= 0x1DC,			// Increase/Decrease THF Despoil chance

// Paladin
	MOD_SHIELD_BASH			= 0x181,			// Shield Bash Dmg Increase
	MOD_DIVINE_EMBLEM		= 0x21C,			// Divine Emblem enmity modifier
	MOD_BLOCK_RATE			= 0x21D,			// Increase chance to block with shield (Reprisal/Palisade)

// Dark Knight
	MOD_WEAPON_BASH			= 0x1B1,			// Increase Weapon Bash Damage
	MOD_STALWART_SOUL		= 0x1D5,			// HP reduction from Souleater divided by 1000
	MOD_DARK_MAG_CAST		= 0x1DA,			// % Reduction to Dark Magic Cast Time
	MOD_ABSORB_POTENCY		= 0x21E,			// % increase to Absorb potency
	MOD_ABSORB_DURATION		= 0x21F,			// Increase to Absorb duration seconds
	MOD_SCARLET_DMG			= 0x229,			// Percent Bonus to Dmg during Scarlet Delirium
	MOD_SCARLET_MDMG		= 0x22A,			// Percent Bonus to Magic Dmg during Scarlet Delirium

// Beastmaster
	MOD_TAME				= 0x130,			// Additional percent chance to charm
	MOD_CHARM_TIME			= 0x168,			// extends the charm time only, no effect of charm chance
	MOD_REWARD_HP_BONUS		= 0x16C,			// Percent to add to reward HP healed. (364)
	MOD_CHARM_CHANCE		= 0x19B,			// extra chance to charm (light&apollo staff etc)
	MOD_REWARD_RECAST		= 0x18C,			// Time reduction to Reward recast

// Bard
	MOD_SONG_RECAST			= 0x187,			// Percent decrease to Bard Song Recast
	MOD_SONG_CAST			= 0x18F,			// Percent decrease to Song Cast Time
	MOD_SONG_DURATION		= 0x1B3,			// Song Duration % Modifier
	MOD_SONG_EFFECTS		= 0x1C8,			// Additional # of Song Effects (Daurdabla)
	MOD_ALL_SONGS			= 0x1B4,			// Increase to all songs
	MOD_ETUDE				= 0x1B5,
	MOD_REQUIEM				= 0x1B6,
	MOD_VIRELAI				= 0x1B7,
	MOD_MARCH				= 0x1B8,
	MOD_HYMNUS				= 0x1B9,
	MOD_MADRIGAL			= 0x1BA,
	MOD_MINUET				= 0x1BB,
	MOD_CAROL				= 0x1BC,
	MOD_PAEON				= 0x1BD,
	MOD_MAMBO				= 0x1BE,
	MOD_LULLABY				= 0x1BF,
	MOD_BALLAD				= 0x1C0,
	MOD_MAZURKA				= 0x1C1,
	MOD_THRENODY			= 0x1C2,
	MOD_FINALE				= 0x1C3,
	MOD_MINNE				= 0x1C4,
	MOD_SCHERZO				= 0x1C5,
	MOD_ELEGY				= 0x1C6,
	MOD_PRELUDE				= 0x1C7,

// Ranger
	MOD_RECYCLE				= 0x131,			// Percent chance to recycle
	MOD_SNAP_SHOT			= 0x16D,			// Percent reduction to range attack delay
	MOD_RAPID_SHOT			= 0x167,			// Percent chance to proc rapid shot
	MOD_WIDESCAN			= 0x154,
	MOD_SHADOWBIND			= 0x1D2,			// Enables Shadowbind on next RA
	MOD_BARRAGE				= 0x1D3,			// Barrage Shot Count Increase
	MOD_DEAD_AIM			= 0x237,			// Critical Ranged Hit Dmg % Increase

// Samurai
	MOD_ZANSHIN				= 0x132,			// Percent chance to counter
	MOD_MEDITATE_DUR		= 0x1B0, 			// Extends Meditate duration in secs

// Ninja
	MOD_UTSUSEMI			= 0x133,			// Everyone's favorite --tracks shadows.
	MOD_NINJA_TOOL			= 0x134,			// Percent chance to not use a tool.
	MOD_STEALTH             = 0x166,			// Chance to remain undetected ??
	MOD_UTSUSEMI_CAST		= 0x195,			// Percent decrease to Utsusemi Cast Time
	MOD_NINJUTSU_RECAST		= 0x18A,			// Percent decrease to Ninjutsu Spell Recast
	MOD_PARRY_RATE			= 0x22D,			// Percent increase to parry rate.

// Dragoon
	MOD_JUMP_TP_BONUS				= 0x169,	// bonus tp player receives when using jump (must be divided by 10)
	MOD_JUMP_ATT_BONUS				= 0x16A,	// ATT% bonus for jump + high jump
	MOD_HIGH_JUMP_ENMITY_REDUCTION	= 0x16B,	// for gear that reduces more enmity from high jump
	MOD_SPIRIT_JUMP_TP				= 0x214,	// bonus tp player receives when using spirit jump (must be divided by 10)
	MOD_SPIRIT_JUMP_ATT				= 0x215,	// ATT% bonus for spirit jump
	MOD_CONSERVE_TP					= 0x236,	// Proc rate for Conserve TP

// Summoner
	MOD_AVATAR_PERPETUATION		= 0x173,		//stores base cost of current avatar
	MOD_WEATHER_REDUCTION		= 0x174,		//stores perpetuation reduction depending on weather
	MOD_DAY_REDUCTION			= 0x175,		//stores perpetuation reduction depending on day
	MOD_PERPETUATION_REDUCTION	= 0x15A,		//stores the MP/tick reduction from gear
	MOD_BP_DELAY			 	= 0x165,		//stores blood pact delay reduction
	MOD_SUMMON_CAST				= 0x192,		// Percent decrease to Summoning Magic Cast Time
	MOD_ELE_AVATAR_RECAST		= 0x18B,		// Percent decrease to Elemental Avatar Recast
	MOD_BLOOD_BOON				= 0x238,		// Proc chance for Blood Boon

// Blue Mage
	MOD_BLUE_POINTS			= 0x135,			// Tracks extra blue points
	MOD_BLUE_RECAST			= 0x189,			// Percent decrease to Blue Spell Recast
	MOD_BLUE_CAST			= 0x196,			// Percent decrease to Blue Magic Cast Time
	MOD_BLUE_LEARN			= 0x231,			// Percent chance increase to learn Blue Magics

// Corsair
	MOD_DMG_REFLECT			= 0x13C,			// Tracks totals
	MOD_ROLL_ROGUES			= 0x13D,			// Tracks totals
	MOD_ROLL_GALLANTS		= 0x13E,			// Tracks totals
	MOD_ROLL_CHAOS			= 0x13F,			// Tracks totals
	MOD_ROLL_BEAST			= 0x140,			// Tracks totals
	MOD_ROLL_CHORAL			= 0x141,			// Tracks totals
	MOD_ROLL_HUNTERS		= 0x142,			// Tracks totals
	MOD_ROLL_SAMURAI		= 0x143,			// Tracks totals
	MOD_ROLL_NINJA			= 0x144,			// Tracks totals
	MOD_ROLL_DRACHEN		= 0x145,			// Tracks totals
	MOD_ROLL_EVOKERS		= 0x146,			// Tracks totals
	MOD_ROLL_MAGUS			= 0x147,			// Tracks totals
	MOD_ROLL_CORSAIRS		= 0x148,			// Tracks totals
	MOD_ROLL_PUPPET			= 0x149,			// Tracks totals
	MOD_ROLL_DANCERS		= 0x14A,			// Tracks totals
	MOD_ROLL_SCHOLARS		= 0x14B,			// Tracks totals
	MOD_BUST				= 0x14C,			// # of busts
	MOD_QUICK_DRAW_DMG      = 0x242,

// Puppetmaster
    MOD_AUTO_MELEE_SKILL	= 0x246,
    MOD_AUTO_RANGED_SKILL	= 0x247,
    MOD_AUTO_MAGIC_SKILL	= 0x248,

// Dancer
	MOD_FINISHING_MOVES		= 0x14D,			// Tracks # of finishing moves
	MOD_JIG_TIME			= 0x1A6,			// Additional duration of Jigs in secs
	MOD_WALTZ_POTENCY		= 0x1DD,			// Additional potency of Waltzs
	MOD_WALTZ_RCVD			= 0x1DE,			// Additional potency of Waltzs Recieved
	MOD_STEP_ACCURACY		= 0x23D,			// Bonus accuracy for Dancer's steps

// Scholar
	MOD_SUBLIMATION_BONUS	= 0x14E,			// MP drain Mod for Sublimation charge.
	MOD_LIGHT_ARTS_EFFECT	= 0x1B2,
	MOD_DARK_ARTS_EFFECT	= 0x14F,
	MOD_LIGHT_ARTS_SKILL	= 0x150,
	MOD_DARK_ARTS_SKILL		= 0x151,
	MOD_REGEN_EFFECT		= 0x152,
	MOD_REGEN_DURATION		= 0x153,
	MOD_HELIX_EFFECT		= 0x22B,
	MOD_HELIX_DURATION		= 0x22C,
	MOD_STORMSURGE_EFFECT   = 0x22E,
	MOD_BLACK_MAGIC_COST    = 0x221,            // MP cost for black magic (light/dark arts)
    MOD_WHITE_MAGIC_COST    = 0x222,            // MP cost for white magic (light/dark arts)
    MOD_BLACK_MAGIC_CAST    = 0x223,            // Cast time for black magic (light/dark arts)
    MOD_WHITE_MAGIC_CAST    = 0x224,            // Cast time for black magic (light/dark arts)
    MOD_BLACK_MAGIC_RECAST  = 0x225,            // Recast time for black magic (light/dark arts)
    MOD_WHITE_MAGIC_RECAST  = 0x226,            // Recast time for white magic (light/dark arts)
    MOD_ALACRITY_CELERITY_EFFECT = 0x227,       // Bonus for celerity/alacrity effect
	MOD_GRIMOIRE_RECAST		= 0x19A,			// Percent decrease to Spell Recasts under Light Arts and Dark Arts
	MOD_GRIMOIRE_CAST		= 0x190,			// Percent decrease to Grimoire Cast Time

// Pets / Avatars / Automatons / Wyverns
	MOD_PET_MABB			= 0x138,			// Tracks totals
	MOD_PET_MACC			= 0x139,			// Tracks totals
	MOD_PET_MDEF			= 0x1E8,

	MOD_PET_ATTP			= 0x13A,			// Tracks totals
	MOD_PET_DEFP			= 0x1E9,
	MOD_PET_ACC				= 0x13B,			// Tracks totals
	MOD_PET_RACC			= 0x1EA,
	MOD_PET_ATT				= 0x1EB,
	MOD_PET_RATT			= 0x1EC,
	MOD_PET_DEF				= 0x1ED,
	MOD_PET_EVA				= 0x1EE,

	MOD_PET_HP				= 0x1EF,
	MOD_PET_HPP				= 0x1F0,
	MOD_PET_MP				= 0x1F1,

	MOD_PET_HPHEAL			= 0x1F2,
	MOD_PET_MPHEAL			= 0x1F3,

	MOD_PET_ENMITY			= 0x1F4,
	MOD_PET_BLD_PACT_DMG	= 0x1F5,
	MOD_PET_REGAIN			= 0x1F6,
	MOD_PET_REGEN			= 0x1F7,
	MOD_PET_REFRESH			= 0x1F8,
	MOD_PET_HASTE			= 0x1F9,
	MOD_PET_STORETP			= 0x1FA,
	MOD_PET_TPBONUS			= 0x1FB,

	MOD_PET_DMG				= 0x1FC,
	MOD_PET_PPHYS_DMG		= 0x1FD,
	MOD_PET_MAG_DMG			= 0x1FE,
	MOD_PET_CRITRATE		= 0x1FF,

	MOD_PET_BREATH_ACC		= 0x200,
	MOD_WYVERN_BREATH		= 0x201,
	MOD_PET_BREATH_DMG		= 0x202,
	MOD_WYVERN_SUBJOB		= 0x216,

	MOD_PET_BMAG_SKL		= 0x203,
	MOD_PET_COMBAT_SKL		= 0x204,
	MOD_PET_MELEE_SKL		= 0x205,
	MOD_PET_WMAG_SKL		= 0x206,

	MOD_PET_DBL_ATK			= 0x207,
	MOD_PET_COUNTER			= 0x208,
	MOD_PET_SPELL_TIME		= 0x209,
	MOD_PET_CONSERVE_MP		= 0x20A,
	MOD_PET_MP_COST			= 0x20B,
	MOD_PET_CURE_PTNCY		= 0x20C,
	MOD_PET_SUBTLE_BLOW		= 0x217,
	MOD_PET_FASTCAST		= 0x218,
	MOD_PET_SPELL_INT		= 0x219,

	MOD_PET_STR				= 0x20D,
	MOD_PET_DEX				= 0x20E,
	MOD_PET_VIT				= 0x20F,
	MOD_PET_AGI				= 0x210,
	MOD_PET_INT				= 0x211,
	MOD_PET_MND				= 0x212,
	MOD_PET_CHR				= 0x213,

// Fellow
	MOD_FELLOW_HP			= 0x1DF,
	MOD_FELLOW_MP			= 0x1E0,
	MOD_FELLOW_STR			= 0x1E1,
	MOD_FELLOW_DEX			= 0x1E2,
	MOD_FELLOW_VIT			= 0x1E3,
	MOD_FELLOW_AGI			= 0x1E4,
	MOD_FELLOW_INT			= 0x1E5,
	MOD_FELLOW_MND			= 0x1E6,
	MOD_FELLOW_CHR			= 0x1E7,


	MOD_ENSPELL				= 0x155,			//stores the type of enspell active (0 if nothing)
	MOD_SPIKES				= 0x156,			//store the type of spike spell active (0 if nothing)
	MOD_ENSPELL_DMG			= 0x157,			//stores the base damage of the enspell before reductions
	MOD_SPIKES_DMG			= 0x158,			//stores the base damage of the spikes before reductions
	MOD_ENSPELL_DURATION	= 0x19D,			//stores the additional duration time for enspell

	MOD_TP_BONUS			= 0x159,
	MOD_DEDICATION			= 0x136,			// % exp gain
	MOD_DEDICATION_CAP		= 0x137,			// Cap of dedicaiton effect
	MOD_EXP_BONUS			= 0x17E,


	MOD_FIRE_AFFINITY		= 0x15B,			//stores the amount of elemental affinity (elemental staves mostly)
	MOD_EARTH_AFFINITY		= 0x15C,
	MOD_WATER_AFFINITY		= 0x15D,
	MOD_ICE_AFFINITY		= 0x15E,
	MOD_THUNDER_AFFINITY	= 0x15F,
	MOD_WIND_AFFINITY		= 0x160,
	MOD_LIGHT_AFFINITY		= 0x161,
	MOD_DARK_AFFINITY		= 0x162,

// Special Modifier+

	MOD_ADDS_WEAPONSKILL	 = 0x163,
	MOD_ADDS_WEAPONSKILL_DYN = 0x164,

	MOD_CRYSTAL_DROP		 = 0x1D8,			// Increase drop rate of Crystals (20 Max)

	MOD_MAIN_DMG_RATING		 = 0x16E,			//adds damage rating to main hand weapon (maneater/blau dolch etc hidden effects)
	MOD_SUB_DMG_RATING		 = 0x16F,			//adds damage rating to off hand weapon
	MOD_REGAIN				 = 0x170,			//auto regain TP (from items) | this is multiplied by 10 e.g. 20 is 2% TP
	MOD_REGAIN_DOWN			 = 0x23E,			//plague, reduce tp
	MOD_REFRESH				 = 0x171,			//auto refresh from equipment
	MOD_REFRESH_DOWN		 = 0x23F,			//plague, reduce mp
	MOD_REGEN				 = 0x172,			//auto regen from equipment
	MOD_REGEN_DOWN      	 = 0x240,			//poison
	MOD_CURE_POTENCY		 = 0x176,			//% cure potency | bonus from gear is capped at 50
	MOD_CURE_POTENCY_RCVD	 = 0x177,			//% potency of received cure | healer's roll, some items have this
	MOD_RANGED_DMG_RATING	 = 0x178,			//adds damage rating to ranged weapon
	MOD_MAIN_DMG_RANK		 = 0x179,			//adds weapon rank to main weapon (http://wiki.bluegartr.com/bg/Weapon_Rank)
	MOD_SUB_DMG_RANK		 = 0x17A,			//adds weapon rank to sub weapon
	MOD_RANGED_DMG_RANK		 = 0x17B,			//adds weapon rank to ranged weapon
	MOD_DELAYP				 = 0x17C,			//delay addition percent (does not affect tp gain)
	MOD_RANGED_DELAYP		 = 0x17D,			//ranged delay addition percent (does not affect tp gain)

	MOD_ELEMENTAL_RECAST	= 0x188,			// Percent decrease to Elemental Spell Recast

	MOD_BLACK_CAST			= 0x18D,			// Percent decrease to Black Magic Cast Time
	MOD_CURE_CAST			= 0x18E,			// Percent decrease to Cure Magic Cast Time
	MOD_STONESKIN_CAST		= 0x191,			// Percent decrease to Stoneskin Cast Time
	MOD_ELEMENTAL_CAST		= 0x193,			// Percent decrease to Elemental Magic Cast Time
	MOD_HEALING_CAST		= 0x194,			// Percent decrease to Healing Magic Cast Time
	MOD_ENHANCING_CAST		= 0x197,			// Percent decrease to Enhancing Magic Cast Time
	MOD_ENFEEBLING_CAST		= 0x198,			// Percent decrease to Enfeebling Magic Cast Time
	MOD_QUICK_MAGIC			= 0x199,			// Occasionally causes spells to cast instantly and 0 recast

	MOD_CHOCOBO_TIME		= 0x19F,			// Chocobo Riding Time Increase in Mins

	MOD_EAT_RAW_FISH		= 0x1A0,			// Allows the User to eat Raw Fish like a Mithra
	MOD_EAT_RAW_MEAT		= 0x1A1,			// Allows the User to eat Raw Meat like a Galka

	MOD_QUADRUPLE_ATTACK	= 0x1A5,			// Percent chance

	MOD_SNEAK_DUR			= 0x1A7,			// Percent Increase
	MOD_INVIS_DUR			= 0x1A8,			// Percent Increase
	MOD_ENHANCING_DUR		= 0x1A9,			// Percent Increase
	MOD_BARSPELL_DUR		= 0x1AB,			// Percent Increase duration Elemental Resistance Spells
	MOD_BARSPELL_PWR		= 0x1AC,			// Power Increase Elemental Resistance Spells
	MOD_DRAIN_ASPIR			= 0x1AD,			// Percent Increase
	MOD_CURSNA_EFFECT		= 0x1AE,			// Percent Increase chance to remove DooM
	MOD_CURSNA_RCVD			= 0x1AF,			// Percent Increase chance to remove DooM

	MOD_STONESKIN_HP		= 0x1AA,			// Stoneskin
	MOD_AUTO_RERAISE		= 0x245				// Auto-Raise
	
	// To save time finding the next mod to use..

	//MOD_SPARE				= 0x249;

};

#define MAX_MODIFIER	       0x249



/************************************************************************
*  Modifier Class														*
************************************************************************/

class CModifier
{
public:

	uint16	getModID();
	int16	getModAmount();

	void	setModAmount(int16 amount);

	 CModifier(uint16 type, int16 amount = 0);
	~CModifier();

private:

	uint16	m_id;
	int16	m_amount;
};

#endif