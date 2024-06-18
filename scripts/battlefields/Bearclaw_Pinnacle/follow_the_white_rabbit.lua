-----------------------------------
-- Follow The White Rabbit
-- Bearclaw Pinnacle ENM, Zephyr Fan
-- !addkeyitem ZEPHYR_FAN
-- !pos 121 -171 758 6
-----------------------------------
local ID = zones[xi.zone.BEARCLAW_PINNACLE]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.FOLLOW_THE_WHITE_RABBIT,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'Wind_Pillar_2',
    exitNpc          = 'Wind_Pillar_Exit',
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = ID.text.ZEPHYR_RIPS },
    grantXP          = 3500,
})

content:addEssentialMobs({ 'Bearclaw_Leveret' })
content.groups[1].spawned = false

content:addEssentialMobs({ 'Bearclaw_Rabbit'})

content.loot =
{
    {
        { item = xi.item.NONE,                    weight = 50  },
        { item = xi.item.SQUARE_OF_GALATEIA,      weight = 450 },
        { item = xi.item.SQUARE_OF_KEJUSU_SATIN,  weight = 50  },
        { item = xi.item.POT_OF_VIRIDIAN_URUSHI,  weight = 450 },
    },

    {
        { item = xi.item.NONE,         weight = 950 },
        { item = xi.item.CLOUD_EVOKER, weight = 50  },
    },

    {
        quantity = 2,
        { item = xi.item.NONE,                weight = xi.loot.weight.HIGH },
        { item = xi.item.MARTIAL_SWORD,       weight = xi.loot.weight.LOW  },
        { item = xi.item.SHAMO,               weight = xi.loot.weight.LOW  },
        { item = xi.item.VENTURERS_BELT,     weight = xi.loot.weight.LOW  },
        { item = xi.item.SERENE_RING,       weight = xi.loot.weight.LOW  },
        { item = xi.item.SCROLL_OF_RAISE_III, weight = xi.loot.weight.HIGH },
    },
}

return content:register()
