-----------------------------------
-- Area: Talacca Cove
-- BCNM: Puppetmaster Blues
-----------------------------------
local talaccaCoveID = zones[xi.zone.TALACCA_COVE]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId                = xi.zone.TALACCA_COVE,
    battlefieldId         = xi.battlefield.id.PUPPETMASTER_BLUES,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 2,
    entryNpc              = '_1l0',
    exitNpcs              = { '_1l1', '_1l2', '_1l3' },
    questArea             = xi.questLog.AHT_URHGAN,
    quest                 = xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return xi.quest.getVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES, 'Prog') == 2
end

function content:onBattlefieldWin(player, battlefield)
    local _, clearTime, partySize = battlefield:getRecord()

    player:setLocalVar('battlefieldWin', battlefield:getID())
    player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), player:getZoneID(), self.index, 0)
    player:setCharVar("PuppetmasterBluesProgress", 3)
    player:delKeyItem(xi.ki.TOGGLE_SWITCH) -- BCNM entry trigger
    player:delKeyItem(xi.ki.VALKENGS_MEMORY_CHIP) -- Dont need this anymore
end

content.groups =
{
    {
        mobIds =
        {
            { talaccaCoveID.mob.VALKENG      },
            { talaccaCoveID.mob.VALKENG + 1  },
            { talaccaCoveID.mob.VALKENG + 2  },

        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
