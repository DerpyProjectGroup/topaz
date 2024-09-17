-----------------------------------
-- Custom Clamming
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')
local customUtil = require('modules/custom/lua/custom_util')
-----------------------------------
local m = Module:new('custom_clamming')


-----------------------------------
-- Settings
-----------------------------------

m.zone = {}

-- Bucket upgrade increases rate of Uncommon or rarer
-- CLAMMING_IMPROVED_RESULTS increases the tier by 1
m.rate =
{
    VERY_COMMON = { 2400, 2400, 2400, 2400, 2400, },
    COMMON      = { 1500, 1500, 1500, 1500, 1500, },
    UNCOMMON    = { 1000, 1200, 1500, 1650, 1800, },
    RARE        = {  500,  600,  700,  750,  800, },
    VERY_RARE   = {  100,  150,  200,  225,  250, },
    SUPER_RARE  = {   50,   75,  100,  120,  140, },
    ULTRA_RARE  = {   10,   20,   30,   35,   40, },
}

-- Chance the bucket will randomly break
-- CLAMMING_REDUCED_INCIDENTS lowers the tier by 1
m.incidents =
{
     0, -- 50 pz
     3, -- 100 pz
     8, -- 150 pz
    12, -- 200 pz
}

m.weight =
{
    VERY_LIGHT  = 3,
    LIGHT       = 6,
    MODERATE    = 7,
    HEAVY       = 11,
    VERY_HEAVY  = 20,
    SUPER_HEAVY = 35,
}

local settings =
{
    DEBUG     = false,                -- IMPORTANT: Should be false on live
    MODEL     = 2424,                 -- Clamming Point model id
    DELAY     = 15,                   -- Seconds before Clamming Point is available again
    REPEAT    = 3,                    -- Seconds before player can trigger Clamming Point again
    ANIMATION = 48,                   -- Animation during clamming
    DURATION  = 1000,                 -- Duration of animation
}

local vars =
{
    ITEM   = '[CLAMMING]Item_',
    WEIGHT = '[CLAMMING]Weight',
    SIZE   = '[CLAMMING]Size',
    BROKEN = '[CLAMMING]Broken',
    NEXT   = '[CLAMMING]Next',
    TARGET = '[CLAMMING]Target',
}

local msg =
{
    POOR   = 'You do not have enough gil.',
    RETURN = 'You return the clamming kit.',
    READY  = 'The area is littered with pieces of broken seashells.',
    DELAY  = 'It looks like someone has been digging here.',
    FIND   = 'You find %s and toss it into your bucket.',
    BROKEN = 'You cannot collect any clams with a broken bucket!',
    REMOVE = 'Lost key item: Clamming kit.',

    BREAK  =
    {
        'You find %s and toss it into your bucket...',
        'But the weight is too much for the bucket and its bottom breaks!',
        ' All your shellfish are washed away...',
    },

    INCIDENT =
    {
        'Something jumps into your bucket and breaks through the bottom!',
        ' All your shellfish are washed away...',
    },

    UPGRADE = {
        'Your clamming capacity has increased to %d ponzes!',
        'Now you may be able to dig a...',
    },
}

local menu =
{
    DIG =
    {
        TITLE   = 'Dig here?',
        AGREE   = 'Yep.',
        DECLINE = 'Nope.',
    },

    UPGRADE =
    {
        TITLE   = 'Move your catch to a new bucket?',
        AGREE   = 'Yes.',
        DECLINE = 'No.',
    },

    READY =
    {
        TITLE   = 'Begin clamming?', -- Ready to get clammin'?
        ACCEPT  = 'Yes.',            -- I was born to clam.
        DECLINE = 'No.',             -- Clamming's for wimps!
        EXPLAIN = 'Please explain.', -- What is all this clamming?
    },

    UPDATE =
    {
        TITLE   = 'Quit clamming?', -- Quit yer clammin'?
        ACCEPT  = 'I\'m done.',      -- I'm all clammed out.
        DECLINE = 'Keep going.',    -- I've still got a few more clams in me.
        EXPLAIN = 'Explain again.', -- Clammin' confuses me...
    },
}

local defaultDialog = {
    BROKEN =
    {
        'You broke the bucket! It\'s over.',
        ' That clamming kit is going to need repairs. I\'ll take it off your hands for now.',
    },

    READY =
    {
        'Would you like to try clamming?',
        ' It\'ll cost you %d gil.',
    },

    DECLINE       = { 'I understand. Clamming isn\'t for everyone.', },
    UPDATE        = { 'Had enough clamming for today?', },
    EXPLAIN_SHORT = { 'Try looking for seashells by the water.', },
    FULL          = { 'You can\'t carry anymore.', },
    INELIGIBLE    = { 'I have nothing to say to you.', },

    NOTHING = { 'There\'s nothing in your bucket yet.', },
    WEIGHT  =
    {
        'Hmm... This weighs around %d ponzes.',
        ' Be careful to not add too much, or you\'ll break the bucket!',
    },

    EXPLAIN_LONG =
    {
        'What\'s clamming? Nearby are prime locations for digging up shellfish and an assortment of other items.',
        'You\'ll need a clamming kit to dig. Collect your finds in the bucket which comes with the kit.',
        'The starter bucket stores up to 50 ponzes. Be careful to not overfill it.',
        'When you\'re done, bring everything back here and I\'ll wrap up your findings to take home.',
    },

    UPGRADE =
    {
        'Wow, you filled the entire bucket!',
        'Now you\'ve proven yourself, how about an upgrade? This new bucket can hold up to %d ponzes!',
    },

    UPGRADE_AFTER =
    {
        'Here\'s your upgraded bucket.',
        ' See what else you can find!',
    },

    FINISH =
    {
        'All right, let\'s get these wrapped up.',
        '...',
        'Here you go! You\'re welcome back any time.',
    },
}

-----------------------------------
-- Helper functions
-----------------------------------

local printTbl = function(player, tbl, param1, param2, param3, param4)
    customUtil.dialogTable(player, tbl, '', { param1, param2, param3, param4 })
end

local printNpc = function(player, tbl, param1, param2, param3, param4)
    local zoneId  = player:getZoneID()
    local npcName = m.zone[zoneId].npc.name

    customUtil.dialogTable(player, tbl, npcName, { param1, param2, param3, param4 })
end

local function doNothing(player)
end

local printOne = function(player, msg, channel, param1, param2, param3, param4)
    if param1 then
        player:printToPlayer(string.format(msg, param1, param2, param3, param4), channel)
    else
        player:printToPlayer(msg, channel)
    end
end

local printMsg = function(player, msg, param1, param2, param3, param4)
    printOne(player, msg, xi.msg.channel.NS_SAY, param1, param2, param3, param4)
end

local debugMsg = function(player, msg, param1, param2, param3, param4)
    if settings.DEBUG then
        printOne(player, msg, xi.msg.channel.SYSTEM_3, param1, param2, param3, param4)
    end
end

-- Returns dialog table, zoneId
local function getInfo(player)
    local zoneId = player:getZoneID()
    return m.zone[zoneId].dialog, zoneId
end

local function delaySendMenu(player, menuNext)
    menu = menuNext
    player:timer(50, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

local pickItem = function(player, drops)
    local bucket = math.floor(player:getCharVar(vars.SIZE) / 50)

    if player:getMod(xi.mod.CLAMMING_IMPROVED_RESULTS) > 0 then
        bucket = bucket + 1
    end

    return customUtil.pickItem(player, drops, bucket)
end

local canUpgrade = function(player)
    local size   = player:getCharVar(vars.SIZE)
    local weight = player:getCharVar(vars.WEIGHT)

    return (
        size ==  50 and weight >=  45 or
        size == 100 and weight >=  95 or
        size == 150 and weight >= 145
    )
end

-----------------------------------
-- Bucket functions
-----------------------------------

m.clearBucket = function(player)
    local zoneId = player:getZoneID()

    for _, v in pairs(m.zone[zoneId].drops) do
        player:setCharVar(vars.ITEM .. v[3], 0)
    end

    player:setCharVar(vars.WEIGHT, 0)
    player:setCharVar(vars.SIZE,   0)
end

m.takeBucket = function(player)
    local zoneId = player:getZoneID()
    local ID     = zones[zoneId]
    local price  = m.zone[zoneId].price

    if player:getGil() < price then
        printMsg(player, msg.POOR)
    else
        player:delGil(price)

        player:setCharVar(vars.BROKEN, 0)
        player:setCharVar(vars.WEIGHT, 0)
        player:setCharVar(vars.SIZE,  50)

        for _, v in pairs(m.zone[zoneId].drops) do
            player:setCharVar(vars.ITEM .. v[3], 0)
        end

        if player:hasKeyItem(xi.ki.CLAMMING_KIT) then
            player:delKeyItem(xi.ki.CLAMMING_KIT)
        end

        player:addKeyItem(xi.ki.CLAMMING_KIT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CLAMMING_KIT)
    end
end

m.bucketUpgrade = function(player)
    if canUpgrade(player) then
        local txt  = getInfo(player)
        local size = player:getCharVar(vars.SIZE) + 50

        printNpc(player, txt.UPGRADE_AFTER)
        printTbl(player, msg.UPGRADE, size)

        player:setCharVar(vars.SIZE, size)
    end
end

m.bucketHandIn = function(player)
    local txt, zoneId = getInfo(player)
    if player:getCharVar(vars.WEIGHT) > 0 then
        printNpc(player, txt.FINISH)

        -- Delay giving items until after dialog
        player:timer(#txt.FINISH * 1000, function(playerArg)
            for _, v in pairs(m.zone[zoneId].drops) do
                local result = player:getCharVar(vars.ITEM .. v[3])
                if result > 0 then
                    if npcUtil.giveItem(player,
                        { { v[3], result } },
                        { multiple = true })
                    then
                        player:setCharVar(vars.ITEM .. v[3], 0)
                    else
                        printNpc(player, txt.FULL)
                        return
                    end
                end
            end
        end)
    end

    player:setCharVar(vars.BROKEN, 0)
    player:setCharVar(vars.WEIGHT, 0)
    player:delKeyItem(xi.ki.CLAMMING_KIT)
    printMsg(player, msg.REMOVE)
end

m.weighBucket = function(player)
    local txt = getInfo(player)
    local weight = player:getCharVar(vars.WEIGHT)

    if weight > 0 then
        printNpc(player, txt.WEIGHT, weight)
    else
        printNpc(player, txt.NOTHING)
    end
end

local MENU_UPGRADE =
{
    title = menu.UPGRADE.TITLE,
    options =
    {
        { menu.UPGRADE.AGREE,   m.bucketUpgrade },
        { menu.UPGRADE.DECLINE, m.bucketHandIn  },
    },
}

m.bucketUpdate = function(player)
    local txt, zoneId = getInfo(player)

    if canUpgrade(player) then
        printNpc(player, txt.UPGRADE, player:getCharVar(vars.SIZE) + 50)
        delaySendMenu(player, MENU_UPGRADE)
        return
    end

    m.bucketHandIn(player)
end

-----------------------------------
-- Clamming point funtions
-----------------------------------

m.getResult = function(player)
    local zoneId       = player:getZoneID()
    local bucket       = math.floor(player:getVar(vars.SIZE) / 50)
    local breakRate    = m.incidents[bucket]
    local result       = pickItem(player, m.zone[zoneId].drops)

    if bucket > 50 and player:getMod(xi.mod.CLAMMING_REDUCED_INCIDENTS) > 0 then
        breakRate = m.incidents[bucket - 1]
    end

    -- Chance of clamming incident
    if math.random(0, 100) < breakRate then
        printTbl(player, msg.INCIDENT, result[4])
        player:setCharVar(vars.BROKEN, 1)
        m.clearBucket(player)
        return
    end

    player:incrementCharVar(vars.ITEM .. result[3], 1)
    player:incrementCharVar(vars.WEIGHT, result[2])

    debugMsg(player, 'Added: %d pz, Total: %d pz', result[2], player:getVar(vars.WEIGHT))

    -- Bucket breaks due to weight
    if player:getVar(vars.WEIGHT) > player:getCharVar(vars.SIZE) then
        printTbl(player, msg.BREAK, result[4])
        player:setCharVar(vars.BROKEN, 1)
        m.clearBucket(player)
    else
        printMsg(player, msg.FIND, result[4])
    end
end

m.startClamming = function(player)
    local npcId = player:getLocalVar(vars.TARGET)

    if npcId then
        local npc = GetNPCByID(npcId)

        if npc then
            npc:setLocalVar(vars.NEXT, os.time() + settings.DELAY)
        end
    end

    player:setLocalVar(vars.NEXT, os.time() + settings.REPEAT)
    player:setLocalVar(vars.TARGET, 0)
    player:setAnimation(settings.ANIMATION)

    player:timer(settings.DURATION, function(playerArg)
        m.getResult(playerArg)
        playerArg:setAnimation(xi.animation.NONE)
    end)
end

-----------------------------------
-- Dialog functions
-----------------------------------

m.declineStart = function(player)
    local txt = getInfo(player)
    printNpc(player, txt.DECLINE)
end

m.shortExplanation = function(player)
    local txt = getInfo(player)
    printNpc(player, txt.EXPLAIN_SHORT)
end

m.longExplanation = function(player)
    local txt = getInfo(player)
    printNpc(player, txt.EXPLAIN_LONG)
end

-----------------------------------
-- Menus
-----------------------------------

local MENU_DIG = {
    title = menu.DIG.TITLE,
    options =
    {
        { menu.DIG.AGREE,   m.startClamming },
        { menu.DIG.DECLINE, doNothing       },
    },
}

local MENU_READY = {
    title = menu.READY.TITLE,
    options =
    {
        { menu.READY.ACCEPT,  m.takeBucket      },
        { menu.READY.DECLINE, m.declineStart    },
        { menu.READY.EXPLAIN, m.longExplanation },
    },
}

local MENU_UPDATE =
{
    title = menu.UPDATE.TITLE,
    options =
    {
        { menu.UPDATE.ACCEPT,  m.bucketUpdate     },
        { menu.UPDATE.DECLINE, m.weighBucket      },
        { menu.UPDATE.EXPLAIN, m.shortExplanation },
    },
}

-----------------------------------
-- Setup Clamming Points and NPC
-----------------------------------

m.onTrigger = function(player, npc)
    local zoneId = player:getZoneID()

    if player:hasKeyItem(xi.ki.CLAMMING_KIT) then
        if player:getCharVar(vars.BROKEN) > 0 then
            printMsg(player, msg.BROKEN)
        else
            local t = os.time()
            if t > player:getLocalVar(vars.NEXT) then
                if t >npc:getLocalVar(vars.NEXT) then
                    player:setLocalVar(vars.TARGET, npc:getID())
                    printMsg(player, msg.READY)
                    delaySendMenu(player, MENU_DIG)
                else
                    printMsg(player, msg.DELAY)
                end
            end
        end
    else
        printMsg(player, msg.READY)
    end
end

m.npcOnTrigger = function(player, npc)
    local txt, zoneId = getInfo(player)

    npc:lookAt(player:getPos())
    npc:timer(10000, function(npcArg)
        npcArg:setRotation(m.zone[zoneId].npc.r)
    end)

    -- If requirement exists and it isn't met, print npc dialog for ineligible
    if m.zone[zoneId].requirement then
        local req = m.zone[zoneId].requirement

        if player:getCharVar(req.var) ~= req.value then
            printNpc(player, txt.INELIGIBLE)
            return
        end
    end

    if player:hasKeyItem(xi.ki.CLAMMING_KIT) then
        if player:getCharVar(vars.BROKEN) == 1 then
            printNpc(player, txt.BROKEN)
            printMsg(player, msg.RETURN)
            player:setCharVar(vars.BROKEN, 0)
            player:delKeyItem(xi.ki.CLAMMING_KIT)
        else
            printNpc(player, txt.UPDATE)
            delaySendMenu(player, MENU_UPDATE)
        end
    else
        printNpc(player, txt.READY, m.zone[zoneId].price)
        delaySendMenu(player, MENU_READY)
    end
end

m.onZoneOut = function(player)
    if player:hasKeyItem(xi.ki.CLAMMING_KIT) then
        m.clearBucket(player)
        player:setCharVar(vars.BROKEN, 1)
    end
end

m.onZoneIn = function(player)
    if player:hasKeyItem(xi.ki.CLAMMING_KIT) then
        player:setCharVar(vars.BROKEN, 1)
    end
end

m.initZone = function(zone)
    local zoneId = zone:getID()

    for i = 1, #m.zone[zoneId].points do
        local dynamicPoint = zone:insertDynamicEntity({
            name      = 'Clamming Point',
            objtype   = xi.objType.NPC,
            look      = settings.MODEL,
            x         = m.zone[zoneId].points[i][1],
            y         = m.zone[zoneId].points[i][2],
            z         = m.zone[zoneId].points[i][3],
            rotation  = 0,
            widescan  = 0,
            onTrigger = m.onTrigger,
        })

        utils.unused(dynamicPoint)
    end

    local dynamicNPC = zone:insertDynamicEntity({
        name      = m.zone[zoneId].npc.name,
        objtype   = xi.objType.NPC,
        look      = m.zone[zoneId].npc.look,
        x         = m.zone[zoneId].npc.x,
        y         = m.zone[zoneId].npc.y,
        z         = m.zone[zoneId].npc.z,
        rotation  = m.zone[zoneId].npc.r,
        widescan  = 0,
        onTrigger = m.npcOnTrigger,
    })

    if m.zone[zoneId].npc.flags then
        dynamicNPC:setNpcFlags(m.zone[zoneId].npc.flags)
    end

    if m.zone[zoneId].npc.spawnAnimation then
        dynamicNPC:setAnimation(m.zone[zoneId].npc.spawnAnimation)
    end

    if not m.zone[zoneId].dialog then
        m.zone[zoneId].dialog = defaultDialog
    end

    utils.unused(dynamicNPC)
end

return m
