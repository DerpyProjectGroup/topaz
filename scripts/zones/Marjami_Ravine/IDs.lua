-----------------------------------
-- Area: Marjami_Ravine
-----------------------------------
zones = zones or {}

zones[xi.zone.MARJAMI_RAVINE] =
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
        BAYLD_OBTAINED                = 7007, -- You have obtained <number> bayld!
        YOU_HAVE_LEARNED              = 7015, -- You have learned <keyitem>!
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        WAYPOINT_ATTUNED              = 7697, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3/ at Frontier Bivouac #4]!
        EXPENDED_KINETIC_UNITS        = 7708, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7709, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7710, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7711, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7712, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7713, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7714, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        LEATHER_SCRAPS_STREWN         = 7736, -- Leather scraps are strewn about the ground.
        HOMEPOINT_SET                 = 7879, -- Home point set!
        LEARNS_SPELL                  = 8180, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 8182, -- You are assaulted by an uncanny sensation.
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Monolithic_Boulder'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_7e0'),
    },
    reive =
    {
        [1] =
        {
            mob =
            {
                17867003,
                17867004,
                17867005,
                17867006,
            },
            obstacles =
            {
                17867001,
                17867002,
            },
            collision =
            {
                17867137,
            },
        },
        [2] =
        {
            mob =
            {
                17867009,
                17867010,
                17867011,
                17867012,
            },
            obstacles =
            {
                17867007,
                17867008,
            },
            collision =
            {
                17867138,
            },
        },
        [3] =
        {
            mob =
            {
                17867015,
                17867016,
                17867017,
                17867018,
            },
            obstacles =
            {
                17867013,
                17867014,
            },
            collision =
            {
                17867139,
            },
        },

        [4] =
        {
            mob =
            {
                17867021,
                17867022,
                17867023,
                17867024,
            },
            -- Bedrock Crag
            obstacles =
            {
                17867019,
                17867020,
            },
            collision =
            {
                17867140,
            },
        },
        [5] =
        {
            mob =
            {
                17867027,
                17867028,
                17867029,
                17867030,
            },
            obstacles =
            {
                17867025,
                17867026,
            },
            collision =
            {
                17867141,
            },
        },
        [6] =
        {
            mob =
            {
                17867033,
                17867034,
                17867035,
                17867036,
            },
            obstacles =
            {
                17867031,
                17867032,
            },
            collision =
            {
                17867142,
            },
        },
        [7] =
        {
            mob =
            {
                17867039,
                17867040,
                17867041,
                17867042,
            },
            -- Bedrock Crag
            obstacles =
            {
                17867037,
                17867038,
            },
            collision =
            {
                17867143,
            },
        },
    },
}

return zones[xi.zone.MARJAMI_RAVINE]
