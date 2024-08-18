-----------------------------------
-- Area: Ceizak Battlegrounds (261)
-----------------------------------
zones = zones or {}

zones[xi.zone.CEIZAK_BATTLEGROUNDS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        WAYPOINT_ATTUNED              = 7591, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3]!
        EXPENDED_KINETIC_UNITS        = 7606, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7607, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7608, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7609, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7610, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7611, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7612, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        HOMEPOINT_SET                 = 7794, -- Home point set!
        LEARNS_SPELL                  = 8037, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 8039, -- You are assaulted by an uncanny sensation.
        ENERGIES_COURSE               = 8040, -- The arcane energies begin to course within your veins.
        MYSTICAL_WARMTH               = 8041, -- You feel a mystical warmth welling up inside you!
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Knotted_Root'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_790'),
    },
    reive =
    {
        -- Bounding Chapuli (I-8)
        [1] =
        {
            mob =
            {
                17846627,
                17846628,
                17846629,
                17846630,
            },
            -- Knotted Vines
            obstacles =
            {
                17846624,
                17846625,
                17846626,
            },
            collision =
            {
                17846760,
                17846761,
            },
        },
        -- Lightfoot Lapinion G-8
        [2] =
        {
            mob =
            {
                17846643,
                17846644,
                17846645,
                17846646,
                17846647,
                17846648,
            },
            -- Knotted Vines
            obstacles =
            {
                17846640,
                17846641,
                17846642,
            },
            collision =
            {
                17846762,
                17846763,
            },
        },

        -- Lavender Twytherim G-9
        [3] =
        {
            mob =
            {
                17846634,
                17846635,
                17846636,
                17846637,
                17846638,
                17846639,
            },
            -- Knotted Vines
            obstacles =
            {
                17846631,
                17846632,
                17846633,
            },
            collision =
            {
                17846764,
                17846765,
            },
        },

        -- Floodplain Spider (F-7)
        [4] =
        {
            mob =
            {
                17846652,
                17846653,
                17846654,
                17846655,
                17846656,
                17846657,
            },
            -- Knotted Roots
            obstacles =
            {
                17846649,
                17846650,
                17846651,
            },
            collision =
            {
                17846766,
                17846767,
            },
        },
    },
}

return zones[xi.zone.CEIZAK_BATTLEGROUNDS]
