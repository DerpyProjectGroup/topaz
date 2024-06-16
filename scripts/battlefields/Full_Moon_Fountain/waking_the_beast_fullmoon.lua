-----------------------------------
-- Area: Full Moon Fountain
-- Name: Waking The Beast
-----------------------------------
local fullMoonFountainID = zones[xi.zone.FULL_MOON_FOUNTAIN]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.FULL_MOON_FOUNTAIN,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_FULLMOON,
    canLoseExp       = false,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'MS_Entrance',
    exitNpc          = 'Moon_Spiral',

    --questArea = xi.questLog.OTHER_AREAS,
    --quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:hasKeyItem(xi.ki.EYE_OF_GALES) and
        player:hasKeyItem(xi.ki.EYE_OF_FLAMES) and
        player:hasKeyItem(xi.ki.EYE_OF_FROST) and
        player:hasKeyItem(xi.ki.EYE_OF_STORMS) and
        player:hasKeyItem(xi.ki.EYE_OF_TIDES) and
        player:hasKeyItem(xi.ki.EYE_OF_TREMORS)
end

function content:setupBattlefield(battlefield)
    battlefield:setLocalVar('carbuncleHP', 20000)
    battlefield:setLocalVar('phase', 1)
end

function content:onEventFinishWin(player, csid, option, npc)
    -- Only award players with faded ruby if they have appropriately
    -- progressed through all battlefields.
    local key =
    {
        xi.ki.EYE_OF_FLAMES,
        xi.ki.EYE_OF_FROST,
        xi.ki.EYE_OF_GALES,
        xi.ki.EYE_OF_STORMS,
        xi.ki.EYE_OF_TIDES,
        xi.ki.EYE_OF_TREMORS,
        xi.ki.RAINBOW_RESONATOR,
    }

    local loot =
    {
        xi.item.CARBUNCLES_CUFFS,
        xi.item.IFRITS_BOW,
        xi.item.SHIVAS_SHOTEL,
        xi.item.TITANS_BASELARDE,
        xi.item.GARUDAS_SICKLE,
        xi.item.LEVIATHANS_COUSE,
        xi.item.RAMUHS_MACE,
    }

    local check = true
    local lootChance = 100

    -- Loot has 3 chances to drop. The droprates are as follows: 60% -> 30% -> 15%
    for i = 1, 3 do
        if math.random(1, 100) < lootChance then
            player:addTreasure(loot[math.random(1, 7)])
        end
        
        lootChance = lootChance / 2
        print(lootChance)
    end

    for i = 1, 7 do
        if not player:hasKeyItem(key[i]) then
            check = false
            return
        end
    end

    if check then
        for i = 1, 7 do
            player:delKeyItem(key[i])
        end

        npcUtil.giveKeyItem(player, xi.ki.FADED_RUBY)
        if option == 0 then
            player:setCharVar('Quest[4][32]Option', 1)
        else
            player:setCharVar('Quest[4][32]Option', 0)
        end
    end
end

content.groups =
{
    {
        mobIds =
        {
            { fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB      }, -- Initial Carbuncles
            { fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 11 },
            { fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 22 },
        },
        allDeath = function(battlefield, mob)
            if battlefield:getLocalVar('PrimeCounter') > 6 then
                content:handleAllMonstersDefeated(battlefield, mob)
            end
        end,
    },

    {
        -- Avatars
        mobIds =
        {
            {
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 1,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 2,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 3,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 4,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 5,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 6,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 7,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 8,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 9,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 10,
            },

            {
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 12,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 13,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 14,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 15,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 16,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 17,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 18,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 19,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 20,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 21,
            },

            {
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 23,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 24,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 25,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 26,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 27,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 28,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 29,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 30,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 31,
                fullMoonFountainID.mob.CARBUNCLE_PRIME_WTB + 32,
            },
        },
        allDeath = function(battlefield, mob)
            if battlefield:getLocalVar('PrimeCounter') > 6 then
                content:handleAllMonstersDefeated(battlefield, mob)
            end
        end,
        spawned  = false,
    },
}

return content:register()
