-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Mamool Ja Spearman
-----------------------------------
mixins = { require('scripts/mixins/families/mamool_ja'), require('scripts/mixins/weapon_break') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

return entity