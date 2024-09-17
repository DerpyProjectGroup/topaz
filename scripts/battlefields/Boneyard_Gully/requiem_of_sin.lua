-----------------------------------
-- Requiem Of A Sin
-- !pos -345 104 -260 144
-----------------------------------
local boneyardGullyID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.BONEYARD_GULLY,
    battlefieldId    = xi.battlefield.id.REQUIEM_OF_A_SIN,
    maxPlayers       = 6,
    levelCap         = 75,
    timeLimit        = utils.minutes(30),
    index            = 6,
    entryNpc         = '_081',
    exitNpcs         = { '_082', '_084', '_086' },
    requiredKeyItems =
    {
        { 
            xi.ki.LETTER_FROM_SHIKAREE_Y,
            xi.ki.LETTER_FROM_THE_MITHRAN_TRACKERS
        }
    },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.REQUIEM_OF_SIN,

    armouryCrates    =
    {
        boneyardGullyID.mob.SHIKAREE_Z + 104,
        boneyardGullyID.mob.SHIKAREE_Z + 110,
        boneyardGullyID.mob.SHIKAREE_Z + 116,
    },
})

function content:onBattlefieldWin(player, battlefield)
    local _, clearTime, partySize = battlefield:getRecord()

    player:setLocalVar('battlefieldWin', battlefield:getID())
    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), player:getZoneID(), self.index, 0)
    player:addTitle(xi.title.DISCIPLE_OF_JUSTICE)
    player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.REQUIEM_OF_SIN)
end

function content:onBattlefieldLoss(player, battlefield)
    player:startEvent(32002)
    
    -- Allow player to get new key item
    player:setCharVar('CONQUEST_REQUIEM_OF_SIN', 0)
end

content.groups =
{
    {
        mobIds =
        {
            {
                boneyardGullyID.mob.SHIKAREE_Z + 99,  -- Shikaree Z
                boneyardGullyID.mob.SHIKAREE_Z + 100, -- Shikaree Y
                boneyardGullyID.mob.SHIKAREE_Z + 101, -- Shikaree X
            },

            {
                boneyardGullyID.mob.SHIKAREE_Z + 105, -- Shikaree Z
                boneyardGullyID.mob.SHIKAREE_Z + 106, -- Shikaree Y
                boneyardGullyID.mob.SHIKAREE_Z + 107, -- Shikaree X
            },

            {
                boneyardGullyID.mob.SHIKAREE_Z + 111, -- Shikaree Z
                boneyardGullyID.mob.SHIKAREE_Z + 112, -- Shikaree Y
                boneyardGullyID.mob.SHIKAREE_Z + 113, -- Shikaree X
            },
        },

        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
        superlink = true,
    },

    -- Shikaree X Rabbits
    {
        mobIds =
        {
            { boneyardGullyID.mob.SHIKAREE_Z + 103  },
            { boneyardGullyID.mob.SHIKAREE_Z + 109  },
            { boneyardGullyID.mob.SHIKAREE_Z + 115 },
        },
    },

    -- Shikaree Z Wyverns
    {
        mobIds =
        {
            { boneyardGullyID.mob.SHIKAREE_Z + 102  },
            { boneyardGullyID.mob.SHIKAREE_Z + 108  },
            { boneyardGullyID.mob.SHIKAREE_Z + 114 },
        },

        spawned = true,
    },
}

content.loot =
{
    {
        { item = xi.item.NONE,                   weight = 655 },
        { item = xi.item.PIECE_OF_CASSIA_LUMBER, weight = 150 },
        { item = xi.item.UNICORN_HORN,           weight = 120 },
        { item = xi.item.DRAGON_BONE,            weight = 75 },
    },

    {
        { item = xi.item.NONE,                   weight = 655 },
        { item = xi.item.PIECE_OF_CASSIA_LUMBER, weight = 150 },
        { item = xi.item.UNICORN_HORN,           weight = 120 },
        { item = xi.item.DRAGON_BONE,            weight = 75 },
    },
    
    {
        { item = xi.item.NONE,                   weight = 650 },
        { item = xi.item.SQUARE_OF_GALATEIA,     weight = 110 },
        { item = xi.item.POT_OF_VIRIDIAN_URUSHI, weight = 110 },
        { item = xi.item.SQUARE_OF_KEJUSU_SATIN, weight = 120 },
    },

    {
        { item = xi.item.NONE,                   weight = 650 },
        { item = xi.item.SQUARE_OF_GALATEIA,     weight = 110 },
        { item = xi.item.POT_OF_VIRIDIAN_URUSHI, weight = 110 },
        { item = xi.item.SQUARE_OF_KEJUSU_SATIN, weight = 120 },
    },

    {
        { item = xi.item.NONE, weight = 835 },
        { item = 18019,        weight = 110 }, -- X's Knife
        { item = 18057,        weight = 110 }, -- Y's Scythe
        { item = 18101,        weight = 120 }, -- Z's Trident
    },

    {
        { item = xi.item.SLAB_OF_GRANITE,         weight = 50 },
        { item = xi.item.DIVINE_LOG,              weight = 10 },
        { item = xi.item.SQUARE_OF_SHINING_CLOTH, weight = 10 },
        { item = xi.item.SQUARE_OF_RAXA,          weight = 75 },
        { item = xi.item.PETRIFIED_LOG,           weight = 75 },
    },

    {
        { item = xi.item.PHOENIX_FEATHER,    weight = 110 },
        { item = xi.item.PHILOSOPHERS_STONE, weight = 45 },
        { item = xi.item.LACQUER_TREE_LOG,   weight = 10 },
    },
}

return content:register()
