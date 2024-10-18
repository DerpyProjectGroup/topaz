-- Dynamis procs mixin

require('scripts/globals/mixins')
require('scripts/globals/dynamis')

g_mixins = g_mixins or {}

g_mixins.dynamis_beastmen = function(dynamisBeastmenMob)
    local procjobs =
    {
        [xi.job.WAR] = 'ws',
        [xi.job.MNK] = 'ja',
        [xi.job.WHM] = 'ma',
        [xi.job.BLM] = 'ma',
        [xi.job.RDM] = 'ma',
        [xi.job.THF] = 'ja',
        [xi.job.PLD] = 'ws',
        [xi.job.DRK] = 'ws',
        [xi.job.BST] = 'ja',
        [xi.job.BRD] = 'ma',
        [xi.job.RNG] = 'ja',
        [xi.job.SAM] = 'ws',
        [xi.job.NIN] = 'ja',
        [xi.job.DRG] = 'ws',
        [xi.job.SMN] = 'ma'
    }

    local familyCurrency =
    {
        [334] = xi.item.ORDELLE_BRONZEPIECE, -- OrcNM (bronzepiece)
        [337] = xi.item.ONE_BYNE_BILL,       -- QuadavNM (1 byne bill)
        [360] = xi.item.TUKUKU_WHITESHELL,   -- YagudoNM (whiteshell)
        [93] = xi.item.ORDELLE_BRONZEPIECE,  -- OrcStatue (bronzepiece)
        [94] = xi.item.ONE_BYNE_BILL,        -- QuadavStatue (1 byne bill)
        [95] = xi.item.TUKUKU_WHITESHELL,    -- YagudoStatue (whiteshell)
    }

    -- Converts ItemID to a string for message print.
    local currencyName = {
        [1449] = "Tukuku Whiteshell",
        [1450] = "Lungo Nango Jadeshell",
        [1451] = "Rimilala Stripeshell",
        [1452] = "Ordelle Bronzepiece",
        [1453] = "Montiont Silverpiece",
        [1454] = "Ranperre_Goldpiece",
        [1455] = "One Byne Bill",
        [1456] = "One Hundred Byne Bill",
        [1457] = "Ten Thousand Byne Bill",
    }

    -- With Treasure Hunter on every procced monster, you can expect approximately 1.7 coins per kill on average.
    -- Without Treasure Hunter, you can expect about 1.25 coins per kill on average.
    -- Without a proc, the coin drop rate is very low (~10%)
    local thCurrency =
    {
        [0] = { single = 100, hundred = 15 }, -- 100, 5
        [1] = { single = 115, hundred = 25 }, -- 115, 10
        [2] = { single = 145, hundred = 35 }, -- 145, 20
        [3] = { single = 190, hundred = 45 }, -- 190, 35
        [4] = { single = 250, hundred = 55 }, -- 250, 50
        [5] = { single = 275, hundred = 65 }, -- 275, 60
    }

    dynamisBeastmenMob:addListener('MAGIC_TAKE', 'DYNAMIS_MAGIC_PROC_CHECK', function(target, caster, spell)
        if
            procjobs[target:getMainJob()] == 'ma' and
            math.random(0, 99) < 8 and
            target:getLocalVar('dynamis_proc') == 0
        then
            xi.dynamis.procMonster(target, caster)
        end
    end)

    dynamisBeastmenMob:addListener('WEAPONSKILL_TAKE', 'DYNAMIS_WS_PROC_CHECK', function(target, user, wsid)
        if
            procjobs[target:getMainJob()] == 'ws' and
            math.random(0, 99) < 25 and
            target:getLocalVar('dynamis_proc') == 0
        then
            xi.dynamis.procMonster(target, user)
        end
    end)

    dynamisBeastmenMob:addListener('ABILITY_TAKE', 'DYNAMIS_ABILITY_PROC_CHECK', function(mob, user, ability, action)
        if
            procjobs[mob:getMainJob()] == 'ja' and
            math.random(0, 99) < 20 and
            mob:getLocalVar('dynamis_proc') == 0
        then
            xi.dynamis.procMonster(mob, user)
        end
    end)

    dynamisBeastmenMob:addListener('DEATH', 'DYNAMIS_ITEM_DISTRIBUTION', function(mob, killer)
        if killer then
            local th       = thCurrency[math.min(mob:getTHlevel(), 5)]
            local family   = mob:getFamily()
            local currency = familyCurrency[family]

            if currency == nil then -- if currency type not defined in mob family, pick randomly.
                currency = 1449 + math.random(0, 2) * 3
            end

            local singleChance   = th.single
            local hundredChance  = th.hundred

            if mob:getMainLvl() > 77 then
                singleChance = math.floor(singleChance * 1.5)
            end

            -- White (special) adds 100% hundred slot
            if mob:getLocalVar('dynamis_proc') >= 4 then
                killer:addTreasure(currency + 1, mob)
            end

            -- Base hundred slot
            if mob:isNM() then
                killer:addTreasure(currency + 1, mob, hundredChance)
            end

            -- red (high) adds 100% single slot
            if mob:getLocalVar('dynamis_proc') >= 3 then
                rollBonus = rollBonus + 2
                killer:addTreasure(currency + 1, mob, hundredChance)
            end

            -- yellow (medium) adds single slot
            if mob:getLocalVar('dynamis_proc') >= 2 then
                killer:addTreasure(currency, mob, singleChance)
                killer:addTreasure(currency, mob, singleChance)
                killer:addTreasure(currency + 1, mob, (hundredChance * 0.50))
            end

            -- blue (low) adds single slot
            if mob:getLocalVar('dynamis_proc') >= 1 then
                killer:addTreasure(currency, mob, singleChance)
            end

            -------------------------
            -- Cactuar Changes Below
            -------------------------
            local party          = killer:getParty() -- Get the players in the killer's party.
            local rollBonus      = 0
            local partySizeBonus = 0
            local membersInZone = {}

            -- Create a list of party members in the same zone when the mob dies.
            for i = 1, #party do
                if mob:getZoneID() == party[i]:getZoneID() then
                    table.insert(membersInZone, party[i])
                end
            end

            -- Trash Mob
            if not mob:isNM() then

                local currencyText        = currencyName[currency] or tostring(currency) -- Used for print messaging. Converts itemID to name string.
                local totalCurrencyChange = 0 -- Variable to store the total currency change during the loop
                
                if mob:getMainLvl() > 77 then
                    rollBonus = rollBonus + 5 -- Higher level tier mobs give more rolls.
                end
                
                -- Creates a list of current party members and ensures each member gets at least 1 currency.
                local memberTotalCurrencyChange = {}

                -- Calculate party size bonus
                if #membersInZone > 1 then
                    partySizeBonus = math.floor(1.25 * #membersInZone)
                end

                -- Ensure each member gets at least 1 currency
                for _, member in ipairs(membersInZone) do
                    local partyMemberCurrency = member:getCharVar('Dynamis_Currency[' .. currency .. ']')
                    partyMemberCurrency = partyMemberCurrency + 1 -- Give 1 currency to each member
                    totalCurrencyChange = totalCurrencyChange + 1 -- Update total currency change
                    member:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency) -- Add the currency to the player's bank.

                    -- Update memberTotalCurrencyChange for the selected party member
                    memberTotalCurrencyChange[member] = (memberTotalCurrencyChange[member] or 0) + 1
                end

                -- Distribute the remaining currency randomly among party members in the same zone
                local remainingDrops = (10 + rollBonus) - #membersInZone -- Calculate how many remaining drops after each member gets at least 1
                for _ = 1, remainingDrops do -- Distribute remaining drops randomly
                    local randomIndex = math.random(1, #membersInZone) -- Randomly select a party member
                    local partyMember = membersInZone[randomIndex] -- Fetch from membersInZone
                    local partyMemberCurrency = partyMember:getCharVar('Dynamis_Currency[' .. currency .. ']')
                    partyMemberCurrency = partyMemberCurrency + 1 -- Increment the currency for the selected party member
                    totalCurrencyChange = totalCurrencyChange + 1 -- Update total currency change
                    partyMember:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency) -- Add the currency to the player's bank.
                
                    -- Update memberTotalCurrencyChange for the selected party member
                    memberTotalCurrencyChange[partyMember] = (memberTotalCurrencyChange[partyMember] or 0) + 1
                end
                
                -- Handle party bonus drops
                if #membersInZone > 1 then
                    for _, v in pairs(membersInZone) do -- Use membersInZone here for party members in the same zone
                        for _ = 1, partySizeBonus do
                            local partyMemberCurrency = v:getCharVar('Dynamis_Currency[' .. currency .. ']')
                            partyMemberCurrency = partyMemberCurrency + 1 -- Increment the currency for the selected party member
                            memberTotalCurrencyChange[v] = (memberTotalCurrencyChange[v] or 0) + 1 -- Update memberTotalCurrencyChange for the selected party member
                            v:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                        end
                    end
                end
                
                -- Print messages for each party member's totalCurrencyChange
                for partyMember, change in pairs(memberTotalCurrencyChange) do
                    if change > 0 then
                        partyMember:printToPlayer(string.format('[%s][%s] dropped. Total:%i', change, currencyText, partyMember:getCharVar('Dynamis_Currency[' .. currency .. ']')), xi.msg.channel.SYSTEM_3)
                    end
                end                

                killer:addTreasure(currency + 1, mob, hundredChance) -- Chance for a 100 drop.
            end

            -- Timed/Lottery
            if
                mob:isNM() and
                (mob:getLocalVar('[isDynamis_Megaboss]') ~= 1 or   -- Is not a megaboss
                mob:getLocalVar('[isDynamis_Arch_Megaboss]') ~= 1) -- Is not an arch megaboss
            then
                local currencyText = currencyName[currency + 1] or tostring(currency+ 1) -- Used for print messaging. Converts itemID to name string.
                local totalCurrencyChange = 0 -- Variable to store the total currency change during the loop
                if killer then
                    for _, v in pairs(membersInZone) do -- For every party member, do loot roll.
                        if v:getZoneID() == mob:getZoneID() then -- If a party member is not in same zone as mob, exclude their loot roll.

                            -- 1 guaranteed hundred.
                            local partyMemberCurrency = v:getCharVar('Dynamis_Currency[' .. currency .. ']')
                            partyMemberCurrency = partyMemberCurrency + 100 -- Increment the currency for the selected party member
                            totalCurrencyChange = totalCurrencyChange + 100 -- Update total currency change
                            v:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                            if totalCurrencyChange > 0 then
                                v:printToPlayer(string.format('[%s] dropped. Total:%i', currencyText, partyMemberCurrency), xi.msg.channel.SYSTEM_3)
                            end

                             -- 2 loot rolls for chance of hundreds.
                            for _ = 1, 2 do
                                if math.random(0, 1000) < hundredChance then -- Drop rate of loot rolls.
                                    partyMemberCurrency = v:getCharVar('Dynamis_Currency[' .. currency .. ']')
                                    partyMemberCurrency = partyMemberCurrency + 100 -- Increment the currency for the selected party member
                                    totalCurrencyChange = totalCurrencyChange + 100 -- Update total currency change
                                    v:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                                    if totalCurrencyChange > 0 then
                                        v:printToPlayer(string.format('[%s] dropped. Total:%i', currencyText, partyMemberCurrency), xi.msg.channel.SYSTEM_3)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- Megaboss NM
            if
                mob:isNM() and
                mob:getLocalVar('[isDynamis_Megaboss]') == 1 
            then
                local currencyText = currencyName[currency + 1] or tostring(currency+ 1) -- Used for print messaging. Converts itemID to name string.
                local totalCurrencyChange = 0 -- Variable to store the total currency change during the loop
                if killer then
                    for _, v in pairs(membersInZone) do -- For every party member, do loot roll.
                        if v:getZoneID() == mob:getZoneID() then -- If a party member is not in same zone as mob, exclude their loot roll.

                            -- 1 guaranteed hundred.
                            local partyMemberCurrency = v:getCharVar('Dynamis_Currency[' .. currency .. ']')
                            partyMemberCurrency = partyMemberCurrency + 100 -- Increment the currency for the selected party member
                            totalCurrencyChange = totalCurrencyChange + 100 -- Update total currency change
                            v:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                            if totalCurrencyChange > 0 then
                                v:printToPlayer(string.format('[%s] dropped. Total:%i', currencyText, partyMemberCurrency), xi.msg.channel.SYSTEM_3)
                            end

                             -- 3 loot rolls for chance of hundreds.
                            for _ = 1, 3 do
                                if math.random(0, 1000) < hundredChance then -- Drop rate of loot rolls.
                                    partyMemberCurrency = partyMemberCurrency + 100 -- Increment the currency for the selected party member
                                    totalCurrencyChange = totalCurrencyChange + 100 -- Update total currency change
                                    v:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                                    if totalCurrencyChange > 0 then
                                        v:printToPlayer(string.format('[%s] dropped. Total:%i', currencyText, partyMemberCurrency), xi.msg.channel.SYSTEM_3)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- Arch Megaboss NM
            if
                mob:isNM() and
                mob:getLocalVar('[isDynamis_Arch_Megaboss]') == 1
            then
                local currencyText = currencyName[currency + 1] or tostring(currency+ 1) -- Used for print messaging. Converts itemID to name string.
                local totalCurrencyChange = 0 -- Variable to store the total currency change during the loop
                if killer then
                    for _, v in pairs(membersInZone) do -- For every party member, do loot roll.
                        if v:getZoneID() == mob:getZoneID() then -- If a party member is not in same zone as mob, exclude their loot roll.

                            -- 2 guaranteed hundred.
                            local partyMemberCurrency = v:getCharVar('Dynamis_Currency[' .. currency .. ']')
                            partyMemberCurrency = partyMemberCurrency + 200 -- Increment the currency for the selected party member
                            totalCurrencyChange = totalCurrencyChange + 200 -- Update total currency change
                            v:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                            if totalCurrencyChange > 0 then
                                v:printToPlayer(string.format('[%s] dropped. Total:%i', currencyText, partyMemberCurrency), xi.msg.channel.SYSTEM_3)
                            end

                             -- 3 loot rolls for chance of hundreds.
                            for _ = 1, 3 do
                                if math.random(0, 1000) < hundredChance then -- Drop rate of loot rolls.
                                    partyMemberCurrency = partyMemberCurrency + 100 -- Increment the currency for the selected party member
                                    totalCurrencyChange = totalCurrencyChange + 100 -- Update total currency change
                                    v:setCharVar('Dynamis_Currency[' .. currency .. ']', partyMemberCurrency)
                                    if totalCurrencyChange > 0 then
                                        v:printToPlayer(string.format('[%s] dropped. Total:%i', currencyText, partyMemberCurrency), xi.msg.channel.SYSTEM_3)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

return g_mixins.dynamis_beastmen
