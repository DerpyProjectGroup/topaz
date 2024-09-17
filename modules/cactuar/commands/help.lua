-----------------------------------
-- func: !help
-- desc: Opens the Help Menu
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = ''
}

commandObj.onTrigger = function(player)

    if player:getLocalVar('helpMenu') > 0 then
        player:printToPlayer('Menu is already in use.', xi.msg.channel.NS_LINKSHELL3)
        return
    end

    local menu = {
        title = 'Help Menu',
        onStart = function(playerArg)
            -- NOTE: This could be used to lock the player in place
            -- playerArg:printToPlayer('Help Menu Opening', xi.msg.channel.NS_LINKSHELL3)
            playerArg:setLocalVar('helpMenu', 1)
        end,

        options = {},

        onCancelled = function(playerArg)
            -- playerArg:printToPlayer('Help Menu Cancelled', xi.msg.channel.NS_LINKSHELL3)
        end,

        onEnd = function(playerArg)
            -- NOTE: This could be used to release a locked player,
            -- playerArg:printToPlayer('Help Menu Closing', xi.msg.channel.NS_LINKSHELL3)
            playerArg:setLocalVar('helpMenu', 0)
        end
    }

    local refundMerits = player:getVar('refundMerits')
    if refundMerits > 0 then
        table.insert(menu.options, {'Refund Merits' .. '(' .. refundMerits .. ')', function(playerArg)
            local currentMerits = playerArg:getMeritCount()
            local totalMerits = currentMerits + refundMerits
            local remainder = 0
            if totalMerits > 30 then
                remainder = totalMerits - 30
                totalMerits = 30
            end
            playerArg:setMerits(totalMerits)
            playerArg:setVar('refundMerits', remainder)
                playerArg:printToPlayer(string.format('Merits are now set to %i with a balance of %i', totalMerits,
                remainder), xi.msg.channel.SYSTEM_3)
        end})
    end

    local UnstuckUses = player:getVar('UnstuckUses')
    local delay = 60
    table.insert(menu.options, {'Unstuck', function(playerArg)
        local zone = player:getZoneID()
        if (zone == nil or zone < 0 or zone > 297) then
            playerArg:printToPlayer('Unstuck selected but unable to assist', xi.msg.channel.SYSTEM_3)
        elseif zone == 0 then
            playerArg:warp()
        else
            -- playerArg:printToPlayer('Unstuck Selected', xi.msg.channel.NS_LINKSHELL3)
            playerArg:printToPlayer('Unstuck will commence in 60 seconds.', xi.msg.channel.SYSTEM_3)
            playerArg:addStatusEffect(xi.effect.TERROR, delay, 0, delay + 1)
            uses = UnstuckUses + 1
            playerArg:setVar('UnstuckUses', uses)
            playerArg:queue(delay, function(playerArg)
                playerArg:setPos(0, 0, 0, 0, zone, true)
            end)
        end
    end})

    local party = player:getParty()
    if #party > 1 then
        table.insert(menu.options, {'Reset Party List', function(playerArg)
            -- playerArg:printToPlayer('Reset Party Selected', xi.msg.channel.NS_LINKSHELL3)
            playerArg:reloadParty()
        end})
    end

    local ID = zones[player:getZoneID()]
    local lsName = 'Cactuar'
    table.insert(menu.options, {'Add Server LS', function(playerArg)
        -- playerArg:printToPlayer('Add Server Linkshell Selected', xi.msg.channel.NS_LINKSHELL3)
        if playerArg:getFreeSlotsCount() == 0 then
            playerArg:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 515)
        else
            playerArg:addLinkpearl(lsName, false)
            playerArg:messageSpecial(ID.text.ITEM_OBTAINED, 515)
        end
    end})

    local HasAllMaps = player:getCharVar('HasAllMaps')
    if HasAllMaps ~= 1 then
        table.insert(menu.options, {'Add All Maps', function(playerArg)
            -- playerArg:printToPlayer('All Maps Selected', xi.msg.channel.NS_LINKSHELL3)
            if xi.settings.main.ALL_MAPS == 0 then
                playerArg:printToPlayer('This command is disabled on this server.', xi.msg.channel.SYSTEM_3)
                return
            end

            local keyIds = {383, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401,
                            402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419,
                            420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437,
                            438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 1856, 1857, 1858, 1859, 1860, 1861, 1862,
                            1863, 1864, 1865, 1866, 1867, 1868, 1869, 1870, 1871, 1872, 1873, 1874, 1875, 1876, 1877,
                            1878, 1879, 1880, 1881, 1882, 1883, 1884, 1885, 1886, 1887, 1888, 1889, 1890, 1891, 1892,
                            1893, 1894, 1895, 1896, 1897, 1898, 1899, 1900, 1901, 1902, 1903, 1904, 1905, 1906, 1907,
                            1908, 1909, 1910, 1911, 1912, 1913, 1914, 1915, 1916, 1917, 1918, 2302, 2303, 2304, 2305,
                            2307, 2308, 2309}

            for _, v in ipairs(keyIds) do
                playerArg:addKeyItem(v)
            end

            playerArg:setCharVar('HasAllMaps', 1)
            playerArg:printToPlayer('All maps have been obtained.', xi.msg.channel.SYSTEM_3)
        end})
    end

    table.insert(menu.options, {'Exit'})

    player:customMenu(menu)
end

return commandObj
