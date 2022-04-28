-----------------------------------
-- func: dynamicmob
-- desc: Summon a fightable mob (no loot)
-- note:
-----------------------------------

cmdprops =
{
    permission = 5,
    parameters = "siii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!dynamicmob <Mob name> {GroupID} {ZoneID} {DropID}")
end

function onTrigger(player, MobName, GroupID, ZoneID, DropID)
    local zone = player:getZone()
    local mob = zone:insertDynamicEntity({
        -- NPC or MOB
        objtype = xi.objType.MOB,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = MobName,

        -- Set the position using in-game x, y and z
        x = player:getXPos(),
        y = player:getYPos(),
        z = player:getZPos(),
        rotation = player:getRotPos(),

        -- Fafnir's entry in mob_groups:
        -- INSERT INTO `mob_groups` VALUES (5,1280,154,'Fafnir',0,128,805,70000,0,90,90,0);
        --                       groupId ---^       ^--- groupZoneId
        groupId = GroupID,
        groupZoneId = ZoneID,

        -- You can provide an onMobDeath function if you want: if you don't
        -- add one, an empty one will be inserted for you behind the scenes.
        onMobDeath = function(mob, playerArg, isKiller)
            -- Do stuff
        end,
    })
        -- validate mob info
        if MobName == nil then
            error(player, "You must provide a mob name.")
            return
        end
        if GroupID == nil then
            error(player, "Invalid GroupID")
            return
        end
        if ZoneID == nil then
            error(player, "invalid ZoneID")
            return
        end
        if DropID == nil then
        error(player, "no DropID set, use 0 for no drops")
        ... return
        end


    -- Use the mob object as you normally would
    mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos())

    mob:setDropID(DropID)

    mob:spawn()

    player:PrintToPlayer(string.format("Spawning %s (Lv: %i, HP: %i)\n%s", MobName, mob:getMainLvl(), mob:getMaxHP(), mob))
end