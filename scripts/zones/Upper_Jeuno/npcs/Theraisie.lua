-----------------------------------
-- Area: Upper Jeuno
--  NPC: Theraisie
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    --[[local stock =  -- Default Shop
    {
        21444,  200,    -- Livid Broth
        21445,  344,    -- Lyrical Broth
        21446,  519,    -- Airy Broth
        21447, 1016,    -- Crumbly Soil
        17922, 1484,    -- Blackwater Broth
        21448, 1747,    -- Pale Sap
        21498, 1747,    -- Crackling Broth
        17920, 2195,    -- Meaty Broth
        21497, 2371,    -- Rapid Broth
        21499, 2425,    -- Creepy Broth
        17921, 2853,    -- Muddy Broth
        21449, 3004,    -- Dire Broth
        17016,  100,    -- Pet Food Alpha
        17017,  200,    -- Pet Food Beta
        17018,  350,    -- Pet Food Gamma
        17019,  500,    -- Pet Food Delta
        17020,  750,    -- Pet Food Epsilon
        17021, 1000,    -- Pet Food Zeta
        17022, 1500,    -- Pet Food Eta
        17023, 2000,    -- Pet Food Theta
        19251,  300,    -- Pet Roborant
        19252,  250,    -- Pet Poultice
    }]]

    local stock =
    -- ItemID,                            Price
    {
        xi.item.JUG_OF_CARROT_BROTH,       200,
        xi.item.JUG_OF_HERBAL_BROTH,       344,
        xi.item.JUG_OF_HUMUS,              519,
        xi.item.JUG_OF_MEAT_BROTH,         700,
        xi.item.JUG_OF_GRASSHOPPER_BROTH,  675,
        xi.item.JUG_OF_CARRION_BROTH,      630,
        xi.item.JUG_OF_BUG_BROTH,          625,
        xi.item.JUG_OF_MOLE_BROTH,         978,
        xi.item.JUG_OF_TREE_SAP,           601,
        xi.item.JUG_OF_ANTICA_BROTH,       828,
        xi.item.JUG_OF_FISH_BROTH,         604,
        xi.item.JUG_OF_BLOOD_BROTH,       1026,
        xi.item.PET_FOOD_ALPHA_BISCUIT,    100,    -- Pet Food Alpha
        xi.item.PET_FOOD_BETA_BISCUIT,     300,    -- Pet Food Beta
        xi.item.PET_FOOD_GAMMA_BISCUIT,    500,    -- Pet Food Gamma
        xi.item.PET_FOOD_DELTA_BISCUIT,    850,    -- Pet Food Delta
        xi.item.PET_FOOD_EPSILON_BISCUIT, 1000,    -- Pet Food Epsilon
        xi.item.PET_FOOD_ZETA_BISCUIT,    1250,    -- Pet Food Zeta
        -- xi.item.PET_FOOD_ETA_BISCUIT,     1500,    -- Pet Food Eta
        -- xi.item.PET_FOOD_THETA_BISCUIT,   2000,    -- Pet Food Theta
        xi.item.PET_ROBORANT,              500,
        xi.item.PET_POULTICE,              250,
    }

    player:showText(npc, ID.text.MP_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
