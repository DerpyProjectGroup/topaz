-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Cirrate Christelle
-- Note: Mega Boss
-----------------------------------
require('scripts/globals/dynamis')
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen')
}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_SCALE, 400)
    mob:setLocalVar('[isDynamis_Arch_Megaboss]', 1)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(true)
    mob:setLocalVar('itemDebuff_Fungus', 1) -- Miasmic Breath
    mob:setLocalVar('itemDebuff_Root', 1)   -- Vampiric Lash & Putrid Breath
    mob:setLocalVar('itemDebuff_Moss', 1)   -- Fragrant Breath
end

entity.onMobRoam = function(mob)
    mob:setTP(0)
end

entity.onMobFight = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 500)

    for _, member in pairs(target:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 88)
        member:changeMusic(3, 88)
        end
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
        -- Set Locals
    local baseTPMoveChance = 12
    local fragrantbreath = baseTPMoveChance
    local miasmicbreath = baseTPMoveChance
    local putridbreath = baseTPMoveChance
    local vampiriclash = baseTPMoveChance
    local extremelybadbreath = baseTPMoveChance

    -- Set Probabilities of Each Skill Based on NM Kill Status
    -- https://wiki-ffo-jp.translate.goog/html/25159.html?_x_tr_sch=http&_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=it&_x_tr_pto=wapp
    -- tl;dr:
    -- Moss reduces chance of fragrant breath
    -- Fungus reduces chance of miasmic breath
    -- Root reduce chance of extremely bad breath (by doubling chance of all the others)
    if mob:getLocalVar('itemDebuff_Moss') == 0 then
        fragrantbreath = baseTPMoveChance / 2
        vampiriclash = baseTPMoveChance * 2
    end
    if mob:getLocalVar('itemDebuff_Fungus') == 0 then
        miasmicbreath = baseTPMoveChance / 2
        vampiriclash = baseTPMoveChance * 2
    end

    local totalchance = fragrantbreath + miasmicbreath + putridbreath + vampiriclash
    if  mob:getLocalVar('itemDebuff_Root') == 0  then
        -- reduces chance of extremely bad breath
        totalchance = totalchance * 2
    end
    local randomchance = math.random(1, totalchance + extremelybadbreath)

    -- Choose Skill
    if randomchance >= (totalchance - fragrantbreath) then
        return 1607 -- Fragrant Breath
    elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath)) then
        return 1605 -- Miasmic Breath
    elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath + putridbreath)) then
        return 1609 -- Putrid Breath
    elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath + putridbreath + vampiriclash)) then
        return 1611 -- Vampiric Lash
    else
        return 1610 -- Extremely Bad Breath remainder of random range
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:resetLocalVars()
    for _, member in pairs(player:getParty()) do
        if member:getObjType() == xi.objType.PC then
        member:changeMusic(2, 121)
        member:changeMusic(3, 121)
        end
    end
end

return entity
