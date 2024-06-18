-----------------------------------
-- ID: 4178
-- Item: Buff Token (Party)
-----------------------------------

-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
end

itemObject.onItemUse = function(target)
    target:forMembersInRange(30, function(member)
        local mLvl = target:getMainLvl()

        local buffs = { 
            {effect = xi.effect.REGEN, power = 0, duration = 3600},
            {effect = xi.effect.REFRESH, power = 0, duration = 3600},
            {effect = xi.effect.PROTECT, power = 220, tier = 5, duration = 3600},
            {effect = xi.effect.SHELL, power = 2930, tier = 5, duration = 3600},
            {effect = xi.effect.HASTE, power = 1000, duration = 3600},
            {effect = xi.effect.RERAISE, power = 3, duration = 3600},
        }
    
        for _, v in ipairs(buffs) do
            local effect = v.effect
            local power = v.power
            local duration = v.duration
            local tier = v.tier
    
            if effect == xi.effect.REGEN then
                -- Regen --
                if mLvl >= 1 and mLvl <= 20 then
                    power = 3
                elseif mLvl >= 21 and mLvl <= 36 then
                    power = 5
                elseif mLvl > 37 and mLvl <= 65 then
                    power = 12
                elseif mLvl > 66 and mLvl <= 75 then
                    power = 20
                else
                    power = 30
                end
            elseif effect == xi.effect.REFRESH then
                -- Refresh --
                if mLvl >= 1 and mLvl <= 20 then
                    power = 2
                else
                    power = 3
                end
            elseif effect == xi.effect.PROTECT then
                -- Protect --
                if mLvl < 27 then
                    power = 20
                    tier = 1
                elseif mLvl < 47 then
                    power = 50
                    tier = 2
                elseif mLvl < 63 then
                    power = 90
                    tier = 3
                elseif mLvl < 76 then
                    power = 140
                    tier = 4
                end
    
                local bonus = 0
                if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
                    bonus = 2 -- 2x Tier from MOD
                end
    
                power = power + (bonus * tier)
            elseif effect == xi.effect.SHELL then
                -- Shell --
                if mLvl < 37 then
                    power = 1055
                    tier = 1
                elseif mLvl < 57 then
                    power = 1641
                    tier = 2
                elseif mLvl < 68 then
                    power = 2188
                    tier = 3
                elseif mLvl < 76 then
                    power = 2617
                    tier = 4
                end
    
                local bonus = 0
                if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
                    bonus = 39   -- (1/256 bonus buff per tier of spell)
                end
    
                power = power + (bonus * tier)
            elseif effect == xi.effect.HASTE then
                -- Haste --
            end
    
            target:delStatusEffectSilent(effect)
            xi.itemUtils.addItemEffect(target, effect, power, duration, tier)
        end
    end)
end

itemObject.onEffectGain = function(target, effect)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
