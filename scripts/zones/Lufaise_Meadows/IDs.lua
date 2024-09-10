-----------------------------------
-- Area: Lufaise_Meadows
-----------------------------------
zones = zones or {}

zones[xi.zone.LUFAISE_MEADOWS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405, -- You are suddenly overcome with a sense of foreboding...
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        CONQUEST                      = 7228, -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7562, -- You can't fish here.
        KI_STOLEN                     = 7691, -- The <keyitem> has been stolen!
        LOGGING_IS_POSSIBLE_HERE      = 7739, -- Logging is possible here if you have <item>.
        SURVEY_THE_SURROUNDINGS       = 7746, -- You survey the surroundings but see nothing out of the ordinary.
        MURDEROUS_PRESENCE            = 7747, -- Wait, you sense a murderous presence...!
        YOU_CAN_SEE_FOR_MALMS         = 7748, -- You can see for malms in every direction.
        SPINE_CHILLING_PRESENCE       = 7750, -- You sense a spine-chilling presence!
        AMALTHEIA_TRIGGER             = 7789, -- A message has been engraved into the rock: �Offer up the ancient shield, and the pact shall be honored.�
        AMALTHEIA_SPAWN1              = 7790, -- Very well, I shall test thy mettle...
        AMALTHEIA_SPAWN2              = 7791, -- I am Amaltheia the Omnipotent. My almighty horns shall seal thy fate this day!
        AMALTHEIA_WRONG_TRADE         = 7792, -- Nothing happens...
        KURREA_TRIGGER                = 7793, -- The stench of rotten flesh fills the air around you. Some scavenger must have made this place its territory.
        KURREA_SPAWN                  = 7794, -- You set <number> <items> on the ground. The smell becomes almost unbearable. Suddenly, a huge creature approaches and starts sniffing around!
        KURREA_WRONG_TRADE            = 7795, -- Nothing happens.
        KURREA_SLURPS                 = 7796, -- Kurrea slurps down the adamantoise soup!
        KURREA_MUSCLES                = 7797, -- Kurrea's muscles bulge crazily!
        KURREA_SHINE                  = 7798, -- Kurrea's scales shine mysteriously!
        KURREA_WIND                   = 7799, -- Kurrea is enveloped by a fierce wind!
        KURREA_RIGID                  = 7800, -- Kurrea's hide grows rigid!
        KURREA_VEIN                   = 7801, -- The veins in Kurrea's head are popping out!
        KURREA_EYES                   = 7802, -- Kurrea's eyes glow weirdly!
        KURREA_CURE                   = 7803, -- Kurrea's wounds disappear!
        KURREA_AURA                   = 7804, -- Kurrea is surrounded by an ominous aura!
        KURREA_GREEN                  = 7805, -- Kurrea's face has turned green...
        KURREA_TEXT                   = 7793, -- The stench of rotten flesh fills the air around you. Some scavenger must have made this place its territory.
        COMMON_SENSE_SURVIVAL         = 8745, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 8809, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        DIG_THROW_AWAY                = 7575, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7577, -- You dig and you dig, but find nothing.
    },
    mob =
    {
        PADFOOT               = GetTableOfIDs('Padfoot'),
        FLOCKBOCK             = GetFirstID('Flockbock'),
        MEGALOBUGARD          = GetFirstID('Megalobugard'),
        LESHY_OFFSET          = GetFirstID('Leshy'),
        COLORFUL_LESHY        = GetFirstID('Colorful_Leshy'),
        SPLINTERSPINE_GRUKJUK = GetFirstID('Splinterspine_Grukjuk'),
        KURREA                = GetFirstID('Kurrea'),
        AMALTHEIA             = GetFirstID('Amaltheia'),
        SENGANN               = 16875690,
        YALUN_EKE             = 16875600,
        BAUMESEL              = 16875777,
        YALUN_EKE_PH          =
        {
            [16875593] = 16875600, -- 236.418, -0.573, -118.742
            [16875604] = 16875600, -- 387.196, 0.060, -115.952
        },
        BITTER_PAST_MOBS =
        {
            16875775,
            16875776,
        },
        BLACKBONE_FRAZDIZ     = GetFirstID('Blackbone_Frazdiz'),
    },
    npc =
    {
        OVERSEER_BASE = GetFirstID('Jemmoquel_RK'),
        LOGGING       = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.LUFAISE_MEADOWS]
