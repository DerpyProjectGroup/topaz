-----------------------------------
-- Area: Foret_de_Hennetiel
-----------------------------------
zones = zones or {}

zones[xi.zone.FORET_DE_HENNETIEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED                = 7007, -- You have obtained <number> bayld!
        YOU_HAVE_LEARNED              = 7015, -- You have learned <keyitem>!
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        STARTED_TO_LEARN_BOAT         = 7521, -- You have started to learn a bit about how to operate your boat.
        FIGURED_OUT_BOAT              = 7522, -- You have figured out how to properly use the boat! Report your progress to Choubollet.
        WAYPOINT_ATTUNED              = 7680, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3/ at Frontier Bivouac #4]!
        EXPENDED_KINETIC_UNITS        = 7691, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7692, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7693, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7694, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7695, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7696, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7697, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        LEARNS_SPELL                  = 7934, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 7936, -- You are assaulted by an uncanny sensation.
        HOMEPOINT_SET                 = 8008, -- Home point set!
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Broadleaf_Palm'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_7a0'),
    },
    reive =
    {
        -- Craklaw & Primrose Jagil E-8
        [1] =
        {
            mob =
            {
                17850744,
                17850745,
                17850746,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850743,
            },
            collision =
            {
                17850886,
                17850887,
            },
        },
        -- Cinder Crab & Blood Toad ?-?
        [2] =
        {
            mob =
            {
                17850748,
                17850749,
                17850750,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850747,
            },
            collision =
            {
                17850884,
                17850885,
            },
        },

        -- Cinder Crab & Blood Toad ?-?
        [3] =
        {
            mob =
            {
                17850752,
                17850753,
                17850754,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850751,
            },
            collision =
            {
                17850882,
                17850883,
            },
        },

        -- Cinder Crab & Blood Toad ?-?
        [4] =
        {
            mob =
            {
                17850756,
                17850757,
                17850758,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850755,
            },
            collision =
            {
                17850880,
                17850881,
            },
        },

        -- Cinder Crab & Blood Toad ?-?
        [5] =
        {
            mob =
            {
                17850760,
                17850761,
                17850762,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850759,
            },
            collision =
            {
                17850894,
                17850895,
            },
        },

        -- Primrose Jagil & Wetlands Orobon ?-?
        [6] =
        {
            mob =
            {
                17850764,
                17850765,
                17850766,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850763,
            },
            collision =
            {
                17850892,
                17850893,
            },
        },

        -- Primrose Jagil & Wetlands Orobon ?-?
        [7] =
        {
            mob =
            {
                17850768,
                17850769,
                17850770,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850767,
            },
            collision =
            {
                17850890,
                17850891,
            },
        },

        -- Primrose Jagil & Wetlands Orobon ?-?
        [8] =
        {
            mob =
            {
                17850772,
                17850773,
                17850774,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850771,
            },
            collision =
            {
                17850888,
                17850889,
            },
        },

        -- Primrose Jagil & Wetlands Orobon ?-?
        [9] =
        {
            mob =
            {
                17850776,
                17850777,
                17850778,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850775,
            },
            collision =
            {
                17850878,
                17850879,
            },
        },

        -- Primrose Jagil & Wetlands Orobon ?-?
        [10] =
        {
            mob =
            {
                17850780,
                17850781,
                17850782,
            },
            -- Broadleaf Palm
            obstacles =
            {
                17850779,
            },
            collision =
            {
                17850876,
                17850877,
            },
        },
    },
}

return zones[xi.zone.FORET_DE_HENNETIEL]
