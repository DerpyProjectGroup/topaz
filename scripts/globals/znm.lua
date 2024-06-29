-----------------------------------
-- Zeni NM System + Helpers
-- Soultrapper         : !additem 18721
-- Blank Soul Plate    : !additem 18722
-- Soultrapper 2000    : !additem 18724
-- Blank HS Soul Plate : !additem 18725
-- Soul Plate          : !additem 2477
-- Sanraku & Ryo       : !pos -127.0 0.9 22.6 50
-----------------------------------
require('scripts/globals/magic')
require('scripts/globals/npc_util')
require('scripts/globals/pankration')
require('scripts/globals/utils')
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
---------------------------------------------------------------------------------
local FAUNA_LIMIT = 10000 -- Zeni handed out per Fauna (NM)
local SUBJECT_OF_INTEREST_LIMIT = 20000 -- Zeni handed out per SubjectsOfInterest
---------------------------------------------------------------------------------

local trophies =
{
    2616, 2617, 2618, 2613, 2614, 2615, 2610, 2611, 2612,
    2609, 2626, 2627, 2628, 2623, 2624, 2625, 2620, 2621,
    2622, 2619, 2636, 2637, 2638, 2633, 2634, 2635, 2630,
    2631, 2632, 2629
}

local lures =
{
    2580, 2581, 2582, 2577, 2578, 2579, 2574, 2575, 2576,
    2573, 2590, 2591, 2592, 2587, 2588, 2589, 2584, 2585,
    2586, 2583, 2600, 2601, 2602, 2597, 2598, 2599, 2594,
    2595, 2596, 2593, 2572
}

local seals =
{
    xi.ki.MAROON_SEAL, xi.ki.MAROON_SEAL, xi.ki.MAROON_SEAL,
    xi.ki.APPLE_GREEN_SEAL,xi.ki.APPLE_GREEN_SEAL,xi.ki.APPLE_GREEN_SEAL,
    xi.ki.CHARCOAL_GREY_SEAL, xi.ki.DEEP_PURPLE_SEAL, xi.ki.CHESTNUT_COLORED_SEAL,
    xi.ki.LILAC_COLORED_SEAL,
    xi.ki.CERISE_SEAL,xi.ki.CERISE_SEAL,xi.ki.CERISE_SEAL,
    xi.ki.SALMON_COLORED_SEAL,xi.ki.SALMON_COLORED_SEAL,xi.ki.SALMON_COLORED_SEAL,
    xi.ki.PURPLISH_GREY_SEAL, xi.ki.GOLD_COLORED_SEAL, xi.ki.COPPER_COLORED_SEAL,
    xi.ki.BRIGHT_BLUE_SEAL,
    xi.ki.PINE_GREEN_SEAL,xi.ki.PINE_GREEN_SEAL,xi.ki.PINE_GREEN_SEAL,
    xi.ki.AMBER_COLORED_SEAL,xi.ki.AMBER_COLORED_SEAL,xi.ki.AMBER_COLORED_SEAL,
    xi.ki.FALLOW_COLORED_SEAL,xi.ki.TAUPE_COLORED_SEAL,xi.ki.SIENNA_COLORED_SEAL,
    xi.ki.LAVENDER_COLORED_SEAL
}

xi = xi or {}
xi.znm = xi.znm or {}

xi.items = xi.items or {}
xi.items['BLANK_SOUL_PLATE'] = 18722
xi.items['BLANK_HIGH_SPEED_SOUL_PLATE'] = 18725
xi.items['SOUL_PLATE'] = 2477


xi.znm.updatePopItemCosts = function()
    for k,item in pairs(lures) do
        local itemVarName = string.format('[ZNM]PopItemCost' ..item.. '')
        local currentUpcharge = GetServerVariable(itemVarName)
        if (currentUpcharge > 0) then
            SetServerVariable(itemVarName, currentUpcharge - 100)
        end
    end
end

-----------------------------------
-- Sanraku's Interests - Genus
-----------------------------------
xi.znm.subjectsOfInterest = xi.znm.subjectsOfInterest or {}
-- aquans
xi.znm.subjectsOfInterest[0] = {75, 76, 77, 372, 400} -- crab 
xi.znm.subjectsOfInterest[1] = {197} -- pugil
xi.znm.subjectsOfInterest[2] = {218, 219} -- sea monk
xi.znm.subjectsOfInterest[3] = {312, 191} -- orobon
-- amorphs
xi.znm.subjectsOfInterest[4] = {396, 276, 258} -- worm
xi.znm.subjectsOfInterest[5] = {172, 369} -- leech
xi.znm.subjectsOfInterest[6] = {290, 66, 67, 228, 229, 230} -- slime
xi.znm.subjectsOfInterest[7] = {299, 112} -- flan
-- arcana
xi.znm.subjectsOfInterest[8] = {56, 82, 232, 300} -- bomb
xi.znm.subjectsOfInterest[9] = {68, 69} -- cluster bomb
-- undead
xi.znm.subjectsOfInterest[10] = {52, 121} -- ghost
xi.znm.subjectsOfInterest[11] = {88, 89, 227, 292} -- skeleton
xi.znm.subjectsOfInterest[12] = {86} -- doomed
-- vermin
xi.znm.subjectsOfInterest[13] = {64, 293} -- chigoe
xi.znm.subjectsOfInterest[14] = {235} -- spider
xi.znm.subjectsOfInterest[15] = {48} -- bee
xi.znm.subjectsOfInterest[16] = {79, 107, 108} -- crawler
xi.znm.subjectsOfInterest[17] = {254, 289} -- wamoura larvae
xi.znm.subjectsOfInterest[18] = {113, 374, 375} -- fly
xi.znm.subjectsOfInterest[19] = {81} -- diremite
xi.znm.subjectsOfInterest[20] = {217, 273, 274, 402} -- scorpion
xi.znm.subjectsOfInterest[21] = {253, 307} -- wamoura
-- demon
xi.znm.subjectsOfInterest[22] = {165, 166, 301} -- imp
-- dragon
xi.znm.subjectsOfInterest[23] = {198, 286} -- puk
xi.znm.subjectsOfInterest[24] = {265, 266, 331, 278} -- wyvren
xi.znm.subjectsOfInterest[25] = {298, 87} -- dragon
-- birds
xi.znm.subjectsOfInterest[26] = {46} -- bat
xi.znm.subjectsOfInterest[27] = {47} -- flock bat
xi.znm.subjectsOfInterest[28] = {72, 287} -- colibri
xi.znm.subjectsOfInterest[29] = {55} -- bird
xi.znm.subjectsOfInterest[30] = {27, 294} -- apkallu
xi.znm.subjectsOfInterest[31] = {70} -- cockatrice
-- beast
xi.znm.subjectsOfInterest[32] = {167, 226, 398} -- sheep
xi.znm.subjectsOfInterest[33] = {242} -- tiger
xi.znm.subjectsOfInterest[34] = {180, 371, 295} -- marid
xi.znm.subjectsOfInterest[35] = {208} -- ram
-- plantoid
xi.znm.subjectsOfInterest[36] = {437, 216} -- sapling
xi.znm.subjectsOfInterest[37] = {114} -- flytrap
xi.znm.subjectsOfInterest[38] = {116} -- funguar
xi.znm.subjectsOfInterest[39] = {245} -- treant
xi.znm.subjectsOfInterest[40] = {296, 186} -- morbol
-- lizard
xi.znm.subjectsOfInterest[41] = {438, 97, 174} -- lizard
xi.znm.subjectsOfInterest[42] = {210, 376, 377} -- raptor
xi.znm.subjectsOfInterest[43] = {58} -- bugard
xi.znm.subjectsOfInterest[44] = {306, 257} -- wivre
-- elemental
xi.znm.subjectsOfInterest[45] = {102} -- fire
xi.znm.subjectsOfInterest[46] = {103} -- ice
xi.znm.subjectsOfInterest[47] = {99} -- wind
xi.znm.subjectsOfInterest[48] = {101} -- earth
xi.znm.subjectsOfInterest[49] = {105} -- thunder
xi.znm.subjectsOfInterest[50] = {106} -- water
xi.znm.subjectsOfInterest[51] = {100} -- dark -- notably no light ele
-- beastmen
xi.znm.subjectsOfInterest[52] = {184} -- moblin
xi.znm.subjectsOfInterest[53] = {196, 297} -- poroggo 
xi.znm.subjectsOfInterest[54] = {213} -- sahagin 
xi.znm.subjectsOfInterest[55] = {305, 176, 285, 177, 176, 257} -- mamool ja
xi.znm.subjectsOfInterest[56] = {310, 171, 469} -- lamia
xi.znm.subjectsOfInterest[57] = {182} -- merrow
xi.znm.subjectsOfInterest[58] = {288, 199} -- qiqirn
xi.znm.subjectsOfInterest[59] = {308, 246, 326} -- troll
-- undead part 2
xi.znm.subjectsOfInterest[60] = {203, 204, 205, 303} -- qutrub
-- demon part 2
xi.znm.subjectsOfInterest[61] = {233, 311} -- soulflayer


xi.znm.changeSubjectsOfInterest = function()
    local subjectsOfInterestKey = math.random(#xi.znm.subjectsOfInterest)
    SetServerVariable('[ZNM]SubjectsOfInterest', subjectsOfInterestKey)
    SetServerVariable('[ZNM]SubOfInterestLimit', SUBJECT_OF_INTEREST_LIMIT)
    SetServerVariable('[ZNM]SubOfInterestTimeLimit', os.time() + 24 * 60 * 60) -- 24 hours from first turnin of new SoI

    local ecosystem = xi.ecosystem.ERROR
    if (subjectsOfInterestKey >= 0 and subjectsOfInterestKey <= 3) then
        ecosystem = xi.ecosystem.AQUAN
    elseif (subjectsOfInterestKey >= 4 and subjectsOfInterestKey <= 7) then
        ecosystem = xi.ecosystem.AMORPH
    elseif (subjectsOfInterestKey >= 8 and subjectsOfInterestKey <= 9) then
        ecosystem = xi.ecosystem.ARCANA
    elseif (subjectsOfInterestKey >= 10 and subjectsOfInterestKey <= 12) or (subjectsOfInterestKey == 60) then
        ecosystem = xi.ecosystem.UNDEAD
    elseif (subjectsOfInterestKey >= 13 and subjectsOfInterestKey <= 21) then
        ecosystem = xi.ecosystem.VERMIN
    elseif (subjectsOfInterestKey == 22 or subjectsOfInterestKey == 61) then
        ecosystem = xi.ecosystem.DEMON
    elseif (subjectsOfInterestKey >= 23 and subjectsOfInterestKey <= 25) then
        ecosystem = xi.ecosystem.DRAGON
    elseif (subjectsOfInterestKey >= 26 and subjectsOfInterestKey <= 31) then
        ecosystem = xi.ecosystem.BIRD
    elseif (subjectsOfInterestKey >= 32 and subjectsOfInterestKey <= 35) then
        ecosystem = xi.ecosystem.BEAST
    elseif (subjectsOfInterestKey >= 36 and subjectsOfInterestKey <= 40) then
        ecosystem = xi.ecosystem.PLANTOID
    elseif (subjectsOfInterestKey >= 41 and subjectsOfInterestKey <= 44) then
        ecosystem = xi.ecosystem.LIZARD
    elseif (subjectsOfInterestKey >= 45 and subjectsOfInterestKey <= 51) then
        ecosystem = xi.ecosystem.ELEMENTAL
    elseif (subjectsOfInterestKey >= 52 and subjectsOfInterestKey <= 59) then
        ecosystem = xi.ecosystem.BEASTMEN
    end

    SetServerVariable('[ZNM]Ecosystem', ecosystem)
end

local function updateSubOfInterestLimit(zeni)
    local remainingLimit = GetServerVariable('[ZNM]SubOfInterestLimit')
    local timeLimit = GetServerVariable('[ZNM]SubOfInterestTimeLimit')
    remainingLimit = remainingLimit - zeni
    if (remainingLimit > 0 or timeLimit < os.time()) then
        SetServerVariable('[ZNM]SubOfInterestLimit', remainingLimit)
    else
        xi.znm.changeSubjectsOfInterest()
    end
end
-----------------------------------
-- Sanraku's Fauna - Specific NMs/Mobs
-----------------------------------
xi.znm.faunaKeys = xi.znm.faunaKeys or {}
-- Please update this whenever new content is added that enabled new fauna.  New assaults, salvage, einherjar, ISNM, Ashu Talif, etc
xi.znm.faunaKeys = {0, 1, 2, 3, 8, 34, 35, 36, 37, 38, 39, 52, 53, 54} 

xi.znm.fauna = xi.znm.fauna or {}
--== HNMs ==
xi.znm.fauna[0] = {17101201} -- a khimaira that dwells in Caederva Mire.
xi.znm.fauna[1] = {17027458} -- a cerberus that dwells in Mount Zhayolm.
xi.znm.fauna[2] = {16986355} -- a hydra that dwells in the Wajaom Woodlands.

--== Assault - Ilrusi Atoll ==
xi.znm.fauna[3] = {17002505, 17002506, 17002507, 17002508, 17002509, 17002510,
                    17002511, 17002512, 17002513, 17002514, 17002515, 17002516} -- a mimic that dwells in the Ilrusi Atoll. - Golden Salvage
--[[4 - an imp that dwells in the Ilrusi Atoll. - Demolition Duty
5 - an orobon that dwells in the Ilrusi Atoll. - Desperately Seeking Cephalopods
6 - a khimaira that dwells in the Ilrusi Atoll. - Bellerophon's Bliss
7 - a Moblin that dwells in the Ilrusi Atoll. - Bellerophon's Bliss]]

--== Assault - Periqia ==
xi.znm.fauna[8] = {17006594, 17006595, 17006596, 17006597, 17006598,
                    17006599, 17006600, 17006601, 17006602} -- a crab that dwells in Periqia. - Seagull Grounded 
--[[9 - a ghost that dwells in Periqia. - Requiem 
10 - an imp that dwells in Periqia. - Shooting Down the Baron
11 - a Qiqirn that dwells in Periqia. - Defuse the Threat
12 - a dvergr that dwells in Periqia. - The Price is Right

== Assault - Lebros Cavern ==
13 - a dragon that dwells in the Lebros Cavern. - Evade and Escape
14 - a wamoura that dwells in the Lebros Cavern. - Wamoura Farm Raid
15 - a Cerberus that dwells in the Lebros Cavern. - Better Than One
16 - a fire elemental that dwells in the Lebros Cavern. - Better Than One

== Assault - Mamool Ja Training Grounds ==
17 - a wyvern that dwells in the Mamool Ja Training Grounds. - Blitzkrieg
18 - a cockatrice that dwells in the Mamool Ja Training Grounds. - Blitzkrieg
19 - a marid that dwells in the Mamool Ja Training Grounds. - Marids in the Mist
20 - a Poroggo that dwells in the Mamool Ja Training Grounds. - Azure Ailments
21 - a Qiqirn that dwells in the Mamool Ja Training Grounds. - Azure Ailments
22 - a leech that dwells in the Mamool Ja Training Grounds. - Azure Ailments
23 - a hydra that dwells in the Mamool Ja Training Grounds. - The Susanoo Shuffle

== Assault - Leujaoam Sanctum ==
24 - a rabbit that dwells in the Leujaoam Sanctum. - Shanarha Grass Conservation
25 - an imp that dwells in the Leujaoam Sanctum. - Supplies Recovery
26 - a vampyr that dwells in the Leujaoam Sanctum. - Bloody Rondo

== The Ashu Talif ==
27 - an Opo-opo ithat dwells in the Ashu Talif. - Targeting the Captain

== ISNM ==
28 - an imp that dwells in Talacca Cove. - Call to Arms
29 - a orobon that dwells in Talacca Cove. - Compliments to the Chef
30 - a wamoura larvae that dwells in the Navukgo Execution Chamber. - Tough Nut to Crack
31 - a flan that dwells in the Navukgo Execution Chamber. - Happy Caster
32 - a colibri that dwells in the Jade Sepulcher. - Making a Mockery
33 - a puk that dwells in the Jade Sepulcher. - Shadows of the Mind]]

--== Nyzul Isle ==
xi.znm.fauna[34] = {17092999} -- a adamantoise that dwells in Nyzul Isle.
xi.znm.fauna[35] = {17093000} -- a behemoth that dwells in Nyzul Isle.
xi.znm.fauna[36] = {17093001} -- a wyrm that dwells in Nyzul Isle.
xi.znm.fauna[37] = {17093002} -- a khimaira that dwells in Nyzul Isle.
xi.znm.fauna[38] = {17093004} -- a cerberus that dwells in Nyzul Isle.
xi.znm.fauna[39] = {17093003} -- a hydra that dwells in Nyzul Isle.

--[[== Salvage ==
40 - the legendary creature that dwells deep within the Zhayolm Remnants.
41 - an imp that dwells in the Zhayolm Remnants.
42 - the legendary creature that dwells deep within the Arrapago Remnants.
43 - a flan that dwells in the Arrapago Remnants.
44 - the legendary creature that dwells deep within the Bhaflau Remnants.
45 - a soulflayer that dwells in the Bhaflau Remnants.
46 - the legendary creature that dwells deep within the Silver Sea Remnants.
47 - a Poroggo that dwells in the Silver Sea Remnants.

== Einherjar ==
48 - the creature guarding the first wing of the Hazhalm Testing Grounds.
49 - the creature guarding the second wing of the Hazhalm Testing Grounds.
50 - the creature guarding the third wing of the Hazhalm Testing Grounds.
51 - the legendary creature that dwells deep within the Hazhalm Testing Grounds.]]

--== Besieged Leaders ==
xi.znm.fauna[52] = {17043875} -- the shimmering scales of an overlord of the Mamool Ja Savages.
xi.znm.fauna[53] = {17031592} -- the rippling physique of a general of the Troll Mercenaries.
xi.znm.fauna[54] = {16998862} -- the bewitching beauty of a general of the Undead Swarm.

xi.znm.changeFauna = function()
    local faunaKey = math.random(#xi.znm.faunaKeys)
    SetServerVariable('[ZNM]Fauna', faunaKey)
    SetServerVariable('[ZNM]FaunaLimit', FAUNA_LIMIT)
end

local function updateFaunaLimit(zeni)
    local remainingLimit = GetServerVariable('[ZNM]FaunaLimit')
    remainingLimit = remainingLimit - zeni
    if (remainingLimit > 0) then
        SetServerVariable('[ZNM]FaunaLimit', remainingLimit)
    else
        xi.znm.changeFauna()
    end
end

--------------------------------------------------------------------
-- Gets the Fauna and Subject of Interest that will match on turn in
--------------------------------------------------------------------
local function getMatchingFaunaAndSubjectsOfInterest(target)
    local faunaMatch = 62 -- 61 is max possible match
    local subjectsOfInterestMatch = 55 -- 54 is max possible match
    local familyID = target:getFamily()
    local mobID = target:getID()

    for i=1, #xi.znm.faunaKeys do
        for k,v in pairs(xi.znm.fauna[xi.znm.faunaKeys[i]]) do
            if (mobID == v) then
                faunaMatch = i
            end
        end
    end

    for i=0, #xi.znm.subjectsOfInterest do
        for k,v in pairs(xi.znm.subjectsOfInterest[i]) do
            if (familyID == v) then
                subjectsOfInterestMatch = i
            end
        end
    end

    return faunaMatch, subjectsOfInterestMatch
end

-----------------------------------
-- Soultrapper
-----------------------------------
xi.znm.soultrapper = xi.znm.soultrapper or {}

xi.znm.soultrapper.onItemCheck = function(target, item, param, caster)
    -- Target checks.
    if
        target == nil or -- Players can use a macro to bypass the client side targeting restriction.
        not target:isMob() or
        not caster:isFacing(target)
    then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    -- Equipment checks.
    local id = caster:getEquipID(xi.slot.AMMO)
    if
        id ~= xi.item.BLANK_SOUL_PLATE and
        id ~= xi.item.BLANK_HIGH_SPEED_SOUL_PLATE
    then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    -- Inventory checks.
    if caster:getFreeSlotsCount() == 0 then
        return xi.msg.basic.FULL_INVENTORY
    end

    return 0
end

xi.znm.soultrapper.getZeniValue = function(target, user, item)
    local hpp = target:getHPP()
    local system = target:getEcosystem()
    local isNM = target:isNM()
    local distance = user:checkDistance(target)
    local isFacing = target:isFacing(user)
    local modelSize = target:getModelSize()
    local isBeingIrresponsible = (user:getInstance() ~= nil) or (user:getBattlefield() ~= nil)
    local targetLevel = target:getMainLvl()

    local zeni = 0
    -- no claim  = little to no zeni
    if target:isPet() or hpp == 100 then
        zeni = math.random(1,5)
    else
        -- base for small size mobs
        zeni = 30
        -- large model mobs get a bonus, possibly up to 50 but based on working backwards from known subjects (Genbu, Aw'euvhi, etc it appears to be 2.5x)
        if (modelSize > 0) then
            zeni = zeni * 3
        end

        -- Level Component
        if (targetLevel > 75) then
            zeni = zeni + ((targetLevel - 75) * 5)
        end

        -- NM/Rarity Component -- appears to be very substantial, outweighing even SubjectsOfInterest partial matches
        if isNM then
            local nmBonus = 0
            if (modelSize > 0) then
                nmBonus = 100
            else
                -- seems that small NMs get a bit bigger bonus, perhaps to offset the low base to begin with
                nmBonus = 125
            end
            zeni = zeni + nmBonus

            if isBeingIrresponsible then
                -- what are you doing taking pictures? you are in a battle?!
                -- proto-omega, salvalge bosses, etc all give more points than would be expected
                zeni = zeni + 35
            end
        end

        -- Distance Component
        if (distance > 5) then
            zeni = zeni * 0.5
        end

        -- Angle/Facing Component
        if not isFacing then
            zeni = zeni * 0.5
        end

         -- HP% Component    
        if (hpp > 50) then
            zeni = zeni * 0.25
        elseif (hpp > 25) then
            zeni = zeni * 0.50
        elseif (hpp > 15) then
            zeni = zeni * 0.75
        elseif (hpp > 5) then
            zeni = zeni * 1.00
        end

        -- Bonus for HS Soul Plate
        if user:getEquipID(xi.slot.AMMO) == xi.item.BLANK_HIGH_SPEED_SOUL_PLATE then
        zeni = zeni * 1.5
        end

        -- per bgwiki - https://www.bg-wiki.com/ffxi/Category:Pankration#Purchasing_Items
        -- HS Soul Plate should allow for faster activation - not a bonus on points
        --[[if user:getEquipID(xi.slot.AMMO) == xi.item.BLANK_HIGH_SPEED_SOUL_PLATE then
            zeni = zeni * 1.5
        end]]

        -- safeguard, should never be possible but lets not deduct zeni, eh?
        if (zeni <= 0) then
            zeni = math.random(1, 5)
        end
        -- Sanitize Zeni
        zeni = math.floor(zeni) -- Remove any floating point information
        zeni = utils.clamp(zeni, 1, 100)
    end
    
    if (showDebugMessage) then
        user:printToPlayer(string.format( 'Zeni for Mob %s is %d!', target:getName(), zeni))
        user:printToPlayer(string.format( 'MobSize [%d] HPP: [%d] isFacing: [%s] LevelOffset: [%d] Distance: [%d] isNM: [%s] hasClaim: [%s] isBeingIrresponsible: [%s]',
                                           modelSize, hpp, isFacing, (targetLevel - 75), distance, isNM, not (not user:isMobOwner(target) or hpp == 100), isBeingIrresponsible ))
    end

    return zeni
end

xi.znm.soultrapper.onItemUse = function(target, user, item)
    -- Determine Zeni starting value
    local zeni = xi.znm.soultrapper.getZeniValue(target, user, item)

    -- Pick a skill totally at random
    local skillIndex, skillEntry = utils.randomEntryIdx(xi.pankration.feralSkills)

    local faunaMatch, subjectsOfInterestMatch = getMatchingFaunaAndSubjectsOfInterest(target)

    -- Add plate
    local plate = user:addSoulPlate(target:getName(), faunaMatch, subjectsOfInterestMatch, target:getEcosystem(), zeni, skillIndex, skillEntry.fp)
    local data = plate:getSoulPlateData()
    -- utils.unused(data)
end

-----------------------------------
-- Ryo
-----------------------------------
xi.znm.ryo = xi.znm.ryo or {}

local function calculateZeniBonus(plateData)
    local zeni = plateData.zeni
    local faunaMatch = plateData.fauna
    local subOfInterestMatch = plateData.subOfInterest
    local ecosystem = plateData.ecoSystem

    local faunaKey = GetServerVariable('[ZNM]SubjectsOfInterest')
    local subjectsOfInterestKey = GetServerVariable('[ZNM]Fauna')

    local percBonus = 0

    if (faunaKey == 0) then
        faunaKey = 1 -- if there is no subject of interest var, take the first index for now
    end

    local isCurrentFauna = false
    local isCurrentSubjectsOfInterest = false
    local isCurrentEcoSytem = false
    if (GetServerVariable('[ZNM]SubjectsOfInterest') == subOfInterestMatch) then
        isCurrentSubjectsOfInterest = true
        zeni = zeni + 250
        percBonus = percBonus + 50
    end

    if (GetServerVariable('[ZNM]Ecosystem') == ecosystem) then
        isCurrentEcoSytem = true
        zeni = zeni + 100
        percBonus = percBonus + 25
    end

    if (GetServerVariable('[ZNM]Fauna') == faunaMatch) then
        isCurrentFauna = true
        zeni = zeni + 500
        percBonus = percBonus + 75
    end

    -- Add a little randomness
    -- zeni = zeni + math.random(-10, 10)
    -- clamp - highest reports in era are ~100ish
    -- WINGSCUSTOM include a percentage bonus for matching fauna/SoI/Ecosystem
    zeni = utils.clamp(zeni, 1, 1000) * (1 + (percBonus / 100))

    -- Sanitize Zeni
    zeni = math.floor(zeni) -- Remove any floating point information

    return zeni, isCurrentSubjectsOfInterest, isCurrentFauna, isCurrentEcoSytem
end

xi.znm.ryo.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, xi.item.SOUL_PLATE) then
        -- Cache the soulplate value on the player
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()
        local zeni, isCurrentSubjectsOfInterest, isCurrentFauna, isCurrentEcoSytem = calculateZeniBonus(plateData)
        player:setLocalVar('[ZNM][Ryo]SoulPlateValue', zeni)
        player:startEvent(914)
    end
end

xi.znm.ryo.onTrigger = function(player, npc)
    player:startEvent(913)
end

xi.znm.ryo.onEventUpdate = function(player, csid, option, npc)
    if csid == 914 then
        local zeniValue = player:getLocalVar('[ZNM][Ryo]SoulPlateValue')
        player:setLocalVar('[ZNM][Ryo]SoulPlateValue', 0)
        player:updateEvent(zeniValue)
    elseif csid == 913 then
        if option == 300 then
            player:updateEvent(player:getCurrency('zeni_point'))
        elseif option == 200 then
            -- confirm sanity of expiration of current subject of interest
            if GetServerVariable('[ZNM]SubOfInterestTimeLimit') == 0 then
                SetServerVariable('[ZNM]SubOfInterestTimeLimit', os.time() + 24 * 60 * 60)
            elseif GetServerVariable('[ZNM]SubOfInterestTimeLimit') < os.time()  then
                xi.znm.changeSubjectsOfInterest()
            end
            -- SubjectsOfInterest
            player:updateEvent(GetServerVariable('[ZNM]SubjectsOfInterest'))
            -- convert real time to game days: 2.4 real minutes / vana hour
            local daysRemaining = math.floor((GetServerVariable('[ZNM]SubOfInterestTimeLimit') - os.time()) / (60 * 24 * 2.4))
            player:printToPlayer(string.format('Ryo : Sanraku\'s interest will change in about %u days.', daysRemaining), 0xD)
        elseif option == 201 then
            -- Fauna
            player:updateEvent(GetServerVariable('[ZNM]Fauna'))
        elseif option == 402 then
            -- Islets dialog
             player:setCharVar('[ZNM][Ryo]IsletDiscussion', 1)
        elseif option == 404 then
            -- this is where we can remove elements of Ryo's dialogue - like perhaps the islet discussion once it happens once.
            -- normal bitmask operation, 1-512
            player:updateEvent(0)
        end
    end
end

xi.znm.ryo.onEventFinish = function(player, csid, option, npc)
end

-----------------------------------
-- Sanraku
-----------------------------------
xi.znm.sanraku = xi.znm.sanraku or {}

local platesTradedToday = function(player)
    local currentDay = VanadielUniqueDay()
    local storedDay = player:getCharVar('[ZNM][Sanraku]TradingDay')

    if currentDay ~= storedDay then
        player:setCharVar('[ZNM][Sanraku]TradingDay', 0)
        player:setCharVar('[ZNM][Sanraku]TradedPlates', 0)
        return 0
    end

    return player:getCharVar('[ZNM][Sanraku]TradedPlates')
end

local function calculateZeniBonus(plateData)
    local zeni = plateData.zeni
    local faunaMatch = plateData.fauna
    local subOfInterestMatch = plateData.subOfInterest
    local ecosystem = plateData.ecoSystem

    local faunaKey = GetServerVariable('[ZNM]SubjectsOfInterest')
    local subjectsOfInterestKey = GetServerVariable('[ZNM]Fauna')

    local percBonus = 0

    if (faunaKey == 0) then
        faunaKey = 1 -- if there is no subject of interest var, take the first index for now
    end

    local isCurrentFauna = false
    local isCurrentSubjectsOfInterest = false
    local isCurrentEcoSytem = false

    if (GetServerVariable('[ZNM]SubjectsOfInterest') == subOfInterestMatch) then
        isCurrentSubjectsOfInterest = true
        zeni = zeni + 100 -- 50
        percBonus = percBonus + 45 -- 35
    end

    if (GetServerVariable('[ZNM]Ecosystem') == ecosystem) then
        isCurrentEcoSytem = true
        zeni = zeni + 50 -- 25
        percBonus = percBonus + 35 -- 25
    end

    if (GetServerVariable('[ZNM]Fauna') == faunaMatch) then
        isCurrentFauna = true
        zeni = zeni + 100 -- 50
        percBonus = percBonus + 60 -- 50
    end

    -- Add a little randomness
    zeni = zeni + math.random(-5, 5)
    -- clamp - highest reports in era are ~100ish
    -- WINGSCUSTOM include a percentage bonus for matching fauna/SoI/Ecosystem
    zeni = utils.clamp(zeni, 1, 105) * (1 + (percBonus / 100))

    -- Sanitize Zeni
    zeni = math.floor(zeni) -- Remove any floating point information

    return zeni, isCurrentSubjectsOfInterest, isCurrentFauna, isCurrentEcoSytem
end

xi.znm.sanraku.onTrade = function(player, npc, trade)
    -- if not player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
    if npcUtil.tradeHasExactly(trade, xi.item.SOUL_PLATE) then
        if platesTradedToday(player) >= 10 then
            -- TODO: A message here?
            return
        end
    --[[ else -- If you have the KI, clear out the tracking vars!
        player:setCharVar('[ZNM][Sanraku]TradingDay', 0)
        player:setCharVar('[ZNM][Sanraku]TradedPlates', 0)
    end

    if npcUtil.tradeHasExactly(trade, xi.item.SOUL_PLATE) then]]
        -- Cache the soulplate value on the player
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()
        local zeni, isCurrentSubjectsOfInterest, isCurrentFauna, isCurrentEcoSytem = calculateZeniBonus(plateData)
        local timeLimit = GetServerVariable('[ZNM]SubOfInterestTimeLimit')
        player:setLocalVar('[ZNM][Sanraku]SoulPlateValue', zeni)

        if (isCurrentSubjectsOfInterest or isCurrentEcoSytem or timeLimit < os.time()) then
            updateSubOfInterestLimit(zeni)
        end

        if (isCurrentFauna) then
            updateFaunaLimit(zeni)
        end
        player:startEvent(910, 9000, 1500, 255)
    else
        -- taken from sanraku.lua
        znm = -1
        found = false

        while znm <= 30 and not(found) do
            znm = znm + 1
            found = trade:hasItemQty(trophies[znm + 1],1)
        end

        if (found) then
            znm = znm + 1

            if player:hasKeyItem(seals[znm]) == false then
                player:tradeComplete()
                player:addKeyItem(seals[znm])
                player:startEvent(912, 0, 0, 0, seals[znm])
            else
                player:messageSpecial(ID.text.SANCTION + 8,seals[znm]) -- You already possess .. (not sure this is authentic)
            end
        end
    end
end

------------------------------------------------------------
-- Gets the allowed ZNMs for a player based on KIs
-- pulled from Sanraku.lua
------------------------------------------------------------
local function getAllowedZNMs(player)
    local param = 2140136440 -- Defaut bitmask, Tier 1 ZNM Menu + don't ask option

    -- Tinnin Path
    if player:hasKeyItem(xi.ki.MAROON_SEAL) then
        param = param - 0x38 -- unlocks Tinnin path tier 2 ZNMs.
    end
    if player:hasKeyItem(xi.ki.APPLE_GREEN_SEAL) then
        param = param - 0x1C0 -- unlocks Tinnin path tier 3 ZNMs.
    end
    if player:hasKeyItem(xi.ki.CHARCOAL_GREY_SEAL) and player:hasKeyItem(xi.ki.DEEP_PURPLE_SEAL) and player:hasKeyItem(xi.ki.CHESTNUT_COLORED_SEAL) then
        param = param - 0x200 -- unlocks Tinnin.
    end

    -- Sarameya Path
    if player:hasKeyItem(xi.ki.CERISE_SEAL) then
        param = param - 0xE000 -- unlocks Sarameya path tier 2 ZNMs.
    end
    if player:hasKeyItem(xi.ki.SALMON_COLORED_SEAL) then
        param = param - 0x70000 -- unlocks Sarameya path tier 3 ZNMs.
    end
    if player:hasKeyItem(xi.ki.PURPLISH_GREY_SEAL) and player:hasKeyItem(xi.ki.GOLD_COLORED_SEAL) and player:hasKeyItem(xi.ki.COPPER_COLORED_SEAL) then
        param = param - 0x80000 -- unlocks Sarameya.
    end

    -- Tyger Path
    if player:hasKeyItem(xi.ki.PINE_GREEN_SEAL) then
        param = param - 0x3800000 -- unlocks Tyger path tier 2 ZNMs.
    end
    if player:hasKeyItem(xi.ki.AMBER_COLORED_SEAL) then
        param = param - 0x1C000000 -- unlocks Tyger path tier 3 ZNMs.
    end
    if player:hasKeyItem(xi.ki.TAUPE_COLORED_SEAL) and player:hasKeyItem(xi.ki.FALLOW_COLORED_SEAL) and player:hasKeyItem(xi.ki.SIENNA_COLORED_SEAL) then
        param = param - 0x20000000 -- unlocks Tyger.
    end

    if player:hasKeyItem(xi.ki.LILAC_COLORED_SEAL) and player:hasKeyItem(xi.ki.BRIGHT_BLUE_SEAL) and player:hasKeyItem(xi.ki.LAVENDER_COLORED_SEAL) then
        param = param - 0x40000000 -- unlocks Pandemonium Warden.
    end

    return param
end

xi.znm.sanraku.onTrigger = function(player, npc)
    if (player:getCharVar('[ZNM]SanrakuIntro') == 0) then
        -- 908: First time introduction
        player:startEvent(908)
    else
        -- 909: Further interactions - param0 = 1 - allowed mobs filter param1 = reduce costs from 500 to 50
        local param = getAllowedZNMs(player)
        player:startEvent(909, param)
    end
end

xi.znm.sanraku.onEventUpdate = function(player, csid, option, npc)
    -- taken from sanraku.lua
    if csid == 909 then
        local zeni = player:getCurrency('zeni_point')
        
        -- initialize these so they aren't global and persist across different players...
        local tier = 0
        local salt = 0
        local keyitem1 = nil
        local keyitem2 = nil
        local keyitem3 = nil
    
        if option >= 300 and option <= 302 then
            if option == 300 then
                salt = xi.ki.SICKLEMOON_SALT
            elseif option == 301 then
                salt = xi.ki.SILVER_SEA_SALT
            elseif option == 302 then
                salt = xi.ki.CYAN_DEEP_SALT
            end
            if zeni < 500 then
                player:updateEvent(2,500) -- not enough zeni
            elseif player:hasKeyItem(salt) then
                player:updateEvent(3,500) -- has salt already
            else
                player:updateEvent(1,500,0,salt)
                player:addKeyItem(salt)
                player:delCurrency('zeni_point', 500)
            end
        else -- player is interested in buying a pop item.
            n = option % 10
            if n <= 2 then
                if option == 130 or option == 440 then
                    tier = 5
                else
                    tier = 1
                end
            elseif n >= 3 and n <= 5 then
                tier = 2
            elseif n >= 6 and n <= 8 then
                tier = 3
            else
                tier = 4
            end

            if option >= 100 and option <= 130 then
                item = lures[option-99]
                local itemVarName = string.format('[ZNM]PopItemCost' ..item.. '')
                cost = tier * 1000 +  GetServerVariable(itemVarName)
                player:updateEvent(0,0,0,0,0,0,cost)

            elseif option >= 400 and option <=440 then
                if option == 440 then
                    option = 430
                end

                item = lures[option-399]

                if option == 430 then -- Pandemonium Warden
                    keyitem1 = xi.ki.LILAC_COLORED_SEAL keyitem2 = xi.ki.BRIGHT_BLUE_SEAL keyitem3 = xi.ki.LAVENDER_COLORED_SEAL
                elseif option == 409 then -- Tinnin
                    keyitem1 = xi.ki.CHARCOAL_GREY_SEAL keyitem2 = xi.ki.DEEP_PURPLE_SEAL keyitem3 = xi.ki.CHESTNUT_COLORED_SEAL
                elseif option == 419 then -- Sarameya
                    keyitem1 = xi.ki.PURPLISH_GREY_SEAL keyitem2 = xi.ki.GOLD_COLORED_SEAL keyitem3 = xi.ki.COPPER_COLORED_SEAL
                elseif option == 429 then -- Tyger
                    keyitem1 = xi.ki.TAUPE_COLORED_SEAL keyitem2 = xi.ki.FALLOW_COLORED_SEAL keyitem3 = xi.ki.SIENNA_COLORED_SEAL
                else
                    if tier > 1 then -- If it's tier 2 or above
                        keyitem1 = seals[option - 402] keyitem2 = nil keyitem3 = nil -- select they key item that needs to be deleted to buy the pop
                    end
                end

                if cost > zeni then
                    player:updateEvent(2, cost, item, keyitem1, keyitem2, keyitem3) -- you don't have enough zeni.
                elseif player:addItem(item) then
                    if keyitem1 ~= nil then
                        player:delKeyItem(keyitem1)
                    end
                    if keyitem2 ~= nil then
                        player:delKeyItem(keyitem2)
                    end
                    if keyitem3 ~= nil then
                        player:delKeyItem(keyitem3)
                    end

                    player:updateEvent(1, cost, item, keyitem1, keyitem2, keyitem3)
                    player:delCurrency('zeni_point', cost)
                    local itemVarName = string.format('[ZNM]PopItemCost' ..item.. '')
                    local currentUpcharge = GetServerVariable(itemVarName)
                    SetServerVariable(itemVarName, currentUpcharge + 100)
                else
                    player:updateEvent(4, cost, item, keyitem1, keyitem2, keyitem3) -- Cannot obtain.
                end
            elseif option == 500 or option == 1 then -- player has declined to buy a pop item
                local allowIslet = 0
                allowIslet = player:getCharVar('[ZNM][Ryo]IsletDiscussion') 
                player:updateEvent(allowIslet)
            end
        end
    end
end

xi.znm.sanraku.onEventFinish = function(player, csid, option, npc)
    if csid == 910 then
        player:confirmTrade()
        player:setCharVar('[ZNM][Sanraku]TradingDay', VanadielUniqueDay())
        player:incrementCharVar('[ZNM][Sanraku]TradedPlates', 1)

        local zeniValue = player:getLocalVar('[ZNM][Sanraku]SoulPlateValue')
        player:setLocalVar('[ZNM][Sanraku]SoulPlateValue', 0)

        player:addCurrency('zeni_point', zeniValue)
        -- zeni_fest.onSanrakuPlateTradeComplete(player, zeniValue) Need to port from Wings
    elseif csid == 908 then
        player:setCharVar('[ZNM]SanrakuIntro', 1)
    end
end
