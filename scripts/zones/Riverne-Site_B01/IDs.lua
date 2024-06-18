-----------------------------------
-- Area: Riverne-Site_B01
-----------------------------------
zones = zones or {}

zones[xi.zone.RIVERNE_SITE_B01] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        PARTY_MEMBERS_HAVE_FALLEN     = 7569, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7576, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        SD_VERY_SMALL                 = 7598, -- The spatial displacement is very small. If you only had some item that could make it bigger...
        SD_HAS_GROWN                  = 7599, -- The spatial displacement has grown.
        SPACE_SEEMS_DISTORTED         = 7600, -- The space around you seems oddly distorted and disrupted.
        MONUMENT                      = 7606, -- Something has been engraved on this stone, but the message is too difficult to make out.
        GROUND_GIVING_HEAT            = 7608, -- The ground here is giving off heat.
        BAHAMUT_TAUNT                 = 7676, -- Children of Vana'diel, what do you think to accomplish by fighting for your lives? You know your efforts are futile, yet still you resist...
        HOMEPOINT_SET                 = 7712, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 7770, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]

        -- TODO Shift IDs
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7224, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7239, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        MEMBERS_OF_YOUR_PARTY         = 7530, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7531, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7533, -- The time limit for this battle is <number> minutes.
        ENTERING_THE_BATTLEFIELD_FOR  = 7596, -- Entering the battlefield for [Storms of Fate/The Wyrmking Descends]!
    },
    mob =
    {
        BAHAMUT          = GetFirstID('Bahamut'),
        IMDUGUD          = GetFirstID('Imdugud'),
        UNSTABLE_CLUSTER = GetFirstID('Unstable_Cluster'),
        BOROKA           = 16896131,
        BAHAMUT_V2       = 16896157,
        SPILOSPOK        = 16896152,
        CHEMACHIQ        = 16896153,
        BOKABRAQ         = 16896154,
    },
    npc =
    {
        DISPLACEMENT_OFFSET = GetFirstID('Spatial_Displacement'),
    },
    Bv2 =
    {
        [1] =
        {
            WYRMS = { 16896158, 16896159, 16896160, 16896161 }
        },
    },
    
}

return zones[xi.zone.RIVERNE_SITE_B01]
