-----------------------------------
-- PET: Luopan
-----------------------------------
xi = xi or {}
xi.pets = xi.pets or {}
xi.pets.luopan = {}

xi.pets.luopan.onMobSpawn = function(mob)
    -- BGWIKI: "Regardless of perpetuation cost reduction, Luopans have a maximum duration of 10 minutes."
    mob:timer(600000, function(mobArg)
        mobArg:setHP(0)
    end)

    mob:setMod(xi.mod.MOVE_SPEED_OVERRIDE, 256) -- this mod > 255 = no movement
end

xi.pets.luopan.onMobDeath = function(mob)
end
