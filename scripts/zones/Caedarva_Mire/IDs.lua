-----------------------------------
-- Area: Caedarva_Mire
-----------------------------------
zones = zones or {}

zones[xi.zone.CAEDARVA_MIRE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        GIGANTIC_WARHORSE             = 6400, -- You find the hoofprint of a gigantic warhorse...≺Prompt≻
        PLACE_QUARTZ                  = 6401, -- You set the ≺Possible Special Code: 01≻≺Possible Special Code: 05≻3≺BAD CHAR: 8280≻≺BAD CHAR: 80≻≺BAD CHAR: 80≻ in the warhorse hoofprint.≺Prompt≻
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7057, -- You can't fish here.
        STAGING_GATE_CLOSER           = 7317, -- You must move closer.
        STAGING_GATE_INTERACT         = 7318, -- This gate guards an area under Imperial control.
        STAGING_GATE_AZOUPH           = 7319, -- Azouph Isle Staging Point.
        STAGING_GATE_DVUCCA           = 7322, -- Dvucca Isle Staging Point.
        CANNOT_LEAVE                  = 7328, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7337, -- There is no response...
        LOGGING_IS_POSSIBLE_HERE      = 7351, -- Logging is possible here if you have <item>.
        HAND_OVER_TO_IMMORTAL         = 7432, -- You hand over the % to the Immortal.
        YOUR_IMPERIAL_STANDING        = 7433, -- Your Imperial Standing has increased!
        CANNOT_ENTER                  = 7471, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7472, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7476, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 7480, -- One or more party members are too far away from the entrance. Unable to enter area.
        JAZARAATS_HEADSTONE           = 7532, -- The name Sir Jazaraat is engraved on the headstone...
        SEAPRINCES_TOMBSTONE          = 8056, -- It appears to be the grave of a great soul to an age long past.
        SHED_LEAVES                   = 8062, -- The ground is strewn with shed leaves...
        SICKLY_SWEET                  = 8067, -- A sickly sweet fragrance pervades the air...
        STIFLING_STENCH               = 8073, -- A stifling stench pervades the air...
        SHREDDED_SCRAPS               = 8080, -- Shredded scraps of paper are scattered all over...
        DRAWS_NEAR                    = 8089, -- Something draws near!
        HOMEPOINT_SET                 = 8982, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 9040, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 9062, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.

        LEG_STUCK                     = 7358, -- Your leg is stuck in the swampy ground!
        DIG_THROW_AWAY                = 7070, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7072, -- You dig and you dig, but find nothing.
    },
    mob =
    {
        AYNU_KAYSEY           = GetFirstID('Aynu-kaysey'),
        CAEDARVA_TOAD         = GetFirstID('Caedarva_Toad'),
        CHIGOES =
        {
            ['Wild_Karakul'] = GetTableOfIDs('Chigoe', 5),
            ['Mosshorn']     = GetTableOfIDs('Chigoe', 5, 5),
        },
        EXPERIMENTAL_LAMIA    = GetFirstID('Experimental_Lamia'),
        JAZARAAT              = GetFirstID('Jazaraat'),
        KHIMAIRA              = GetFirstID('Khimaira'),
        LAMIA_NO27            = GetFirstID('Lamia_No27'),
        MAHJLAEF_THE_PAINTORN = GetFirstID('Mahjlaef_the_Paintorn'),
        MOSHDAHN              = GetFirstID('Moshdahn'),
        PEALLAIDH             = GetFirstID('Peallaidh'),
        PEALLAIDH_PH_OFFSET   = GetFirstID('Wild_Karakul'), -- These are 270IDs away. Use offset in case of weird shift.
        TYGER                 = GetFirstID('Tyger'),
        VERDELET              = GetFirstID('Verdelet'),

        ZIKKO                 = 17101144,
        VIDHUWA_PH            =
        {
            [17101162] = 17101158, -- 608.020 -9.593 368.036
        },
    },
    npc =
    {
        LOGGING             = GetTableOfIDs('Logging_Point'),
        RUNIC_PORTAL_AZOUPH = GetFirstID('Runic_Portal_Azouph'),
        RUNIC_PORTAL_DVUCCA = GetFirstID('Runic_Portal_Dvucca'),
    },
}

return zones[xi.zone.CAEDARVA_MIRE]
