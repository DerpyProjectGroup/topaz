-----------------------------------
-- Area: Morimar_Basalt_Fields
-----------------------------------
zones = zones or {}

zones[xi.zone.MORIMAR_BASALT_FIELDS] =
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
        WAYPOINT_ATTUNED              = 7598, -- Your <keyitem> has been attuned to a geomagnetic fount[/ at the frontier station/ at Frontier Bivouac #1/ at Frontier Bivouac #2/ at Frontier Bivouac #3/ at Frontier Bivouac #4/ at Frontier Bivouac #5]!
        EXPENDED_KINETIC_UNITS        = 7607, -- You have expended <number> kinetic unit[/s] and will be transported to another locale.
        INSUFFICIENT_UNITS            = 7608, -- Your stock of kinetic units is insufficient.
        REACHED_KINETIC_UNIT_LIMIT    = 7609, -- You have reached your limit of kinetic units and cannot charge your artifact any further.
        CANNOT_RECEIVE_KINETIC        = 7610, -- There is no response. You apparently cannot receive kinetic units from this item.
        ARTIFACT_HAS_BEEN_CHARGED     = 7611, -- Your artifact has been charged with <number> kinetic unit[/s]. Your current stock of kinetic units totals <number>.
        ARTIFACT_TERMINAL_VOLUME      = 7612, -- Your artifact has been charged to its terminal volume of kinetic units.
        SURPLUS_LOST_TO_AETHER        = 7613, -- A surplus of <number> kinetic unit[/s] has been lost to the aether.
        LEARNS_SPELL                  = 7861, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 7863, -- You are assaulted by an uncanny sensation.
        HOMEPOINT_SET                 = 8177, -- Home point set!
    },
    mob =
    {
        REIVE_MOB_OFFSET = GetFirstID('Bedrock_Crag'),
    },
    npc =
    {
        REIVE_COLLISION_OFFSET = GetFirstID('_7d0'),
    },
    reive =
    {
        -- Bounding Chapuli (I-8)
        [1] =
        {
            mob =
            {
                17863217,
                17863218,
                17863219,
                17863220,
                17863221,
                17863222,
            },
            -- Bedrock Crag
            obstacles =
            {
                17863214,
                17863215,
                17863216,
            },
            collision =
            {
                17863379,
                17863380,
            },
        },
        -- Lightfoot Lapinion G-8
        [2] =
        {
            mob =
            {
                17863226,
                17863227,
                17863228,
                17863229,
                17863230,
                17863231,
            },
            -- Bedrock Crag
            obstacles =
            {
                17863223,
                17863224,
                17863225,
            },
            collision =
            {
                17863377,
                17863378,
            },
        },

        -- Lavender Twytherim G-9
        [3] =
        {
            mob =
            {
                17863235,
                17863236,
                17863237,
                17863238,
                17863239,
                17863240,
            },
            -- Bedrock Crag
            obstacles =
            {
                17863232,
                17863233,
                17863234,
            },
            collision =
            {
                17863385,
                17863386,
            },
        },

        -- Floodplain Spider (F-7)
        [4] =
        {
            mob =
            {
                17863244,
                17863245,
                17863246,
                17863247,
                17863248,
                17863249,
            },
            -- Bedrock Crag
            obstacles =
            {
                17863241,
                17863242,
                17863243,
            },
            collision =
            {
                17863387,
                17863388,
            },
        },
        [5] =
        {
            mob =
            {
                17863262,
                17863263,
                17863264,
                17863265,
                17863266,
                17863267,
            },
            -- Bedrock Crag
            obstacles =
            {
                17863259,
                17863260,
                17863261,
            },
            collision =
            {
                17863381,
                17863382,
            },
        },
        [6] =
        {
            mob =
            {
                17863271,
                17863272,
                17863273,
                17863274,
                17863275,
                17863276,
            },
            -- Bedrock Crag
            obstacles =
            {
                17863268,
                17863269,
                17863270,
            },
            collision =
            {
                17863375,
                17863376,
            },
        },
        [7] =
        {
            mob =
            {
                17863253,
                17863254,
                17863255,
                17863256,
                17863257,
                17863258,
            },
            -- Bedrock Crag
            obstacles =
            {
                17863250,
                17863251,
                17863252,
            },
            collision =
            {
                17863383,
                17863384,
            },
        },
    },
}

return zones[xi.zone.MORIMAR_BASALT_FIELDS]
