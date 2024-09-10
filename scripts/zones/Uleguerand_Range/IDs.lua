-----------------------------------
-- Area: Uleguerand_Range
-----------------------------------
zones = zones or {}

zones[xi.zone.ULEGUERAND_RANGE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6397, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6403, -- Obtained: <item>.
        GIL_OBTAINED                  = 6404, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6406, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6417, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6432, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7014, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7015, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7016, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7036, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073, -- Tallying conquest results...
        SOMETHING_GLITTERING          = 7344, -- You see something glittering beneath the surface of the ice.
        WHAT_LIES_BENEATH             = 7345, -- There are many cold <item> scattered around the area. Could someone be trying to melt the ice to retrieve what lies beneath?
        SOMETHING_GLITTERING_BUT      = 7346, -- You see something glittering below the surface here, but the ice encases it completely.
        HOMEPOINT_SET                 = 8338, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 8396, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]

        FLUTTERING_CLOTH              = 7398, -- A scrap of cloth flutters wildly in the wind...<
        SPAWN_GEUSH                   = 7399, -- A huge beast is charging towards the <item>!
        GEUSH_COUNTER                 = 7401, -- Geush Urvan uses Counterstance!
        GEUSH_COUNTER_OFF             = 7402, -- Geush Urvan's Counterstance effect wears off.
        RABBIT_TRACKS                 = 7403, -- There are fresh rabbit tracks here. The creature must still be in the vicinity.
        DIG_THROW_AWAY                = 7245, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7247, -- You dig and you dig, but find nothing.
    },
    mob =
    {
        SKVADER     = GetFirstID('Skvader'),
        MAGNOTAUR   = GetFirstID('Magnotaur'),
        BONNACON    = GetFirstID('Bonnacon'),
        JORMUNGAND  = GetFirstID('Jormungand'),
        GEUSH_URVAN = GetFirstID('Geush_Urvan'),
        WHITE_CONEY = GetFirstID('White_Coney'),
        BLACK_CONEY = GetFirstID('Black_Coney'),

        MAIDEN_PH        = 16797808,
        SNOW_MAIDEN      = 16797809,
        FATHER_FROST     = 16797810,
        MOUNTAIN_WORM_NM = 16798031,
    },
    npc =
    {
        WATERFALL        = GetFirstID('_058'),
        RABBIT_FOOTPRINT = GetFirstID('Rabbit_Footprint'),
    },
}

return zones[xi.zone.ULEGUERAND_RANGE]
