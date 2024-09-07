-----------------------------------
-- Area: Carpenters_Landing
-----------------------------------
zones = zones or {}

zones[xi.zone.CARPENTERS_LANDING] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6399, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        YOU_WISH_TO_KNOW_MISTALLE     = 7235, -- You wish to know of the Knights Mistalle?
        SQUASH_ANOTHER_WORM           = 7236, -- You're just like everyone else! A maggot looking for a scandal! Well, it's time for me to squash another worm!
        BEGONE_TRESPASSER             = 7255, -- Begone, trespasser! This land belongs to the Knights Mi- This land belongs to Count Teulomme!
        CRYPTONBERRY_FALLEN_TREE      = 7257, -- A tree has fallen here...
        CRYPTONBERRY_EXECUTOR_POP     = 7258, -- You feel a wave of hatred wash over you!
        FISHING_MESSAGE_OFFSET        = 7281, -- You can't fish here.
        LOGGING_IS_POSSIBLE_HERE      = 7398, -- Logging is possible here if you have <item>.
        BEUGUNGEL_SHOP_DIALOG         = 7430, -- Hello, [sir/ma'am]! I'm selling goods direct from the Carpenters' Guild.
        CRYPTONBERRY_EXECUTOR_DIE     = 7482, -- ...Cleave our foesss with barren hate.
        CRYPTONBERRY_ASSASSIN_2HR     = 7483, -- ..Take up thy lanternsss. The truth we shall illuminate.
        CRYPTONBERRY_EXECUTOR_2HR     = 7484, -- Through this we ssseek our just reward...
        MYCOPHILE_MUSHROOM            = 7501, -- There is a rotten mushroom here. There are 3 openings in its cap.
        HERCULES_TREE_NOTHING_YET     = 7503, -- There is nothing here yet. Check again in the morning.
        UNITY_WANTED_BATTLE_INTERACT  = 7546, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 7568, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.

        STENCH_OF_DECAY               = 7480, -- You are overwhelmed by the putrid stench of decay!
        BULLHEADED_BREATH             = 7486, -- Bullheaded Grosvez pauses to catch his breath.
        NO_GIL                        = 7436, -- I'm sorry You don't have enough gil to purchase a ticket!
        NO_BILLET                     = 7440, -- You were refused passage for failing to present <item>!
        HAVE_BILLET                   = 7445, -- You cannot buy more than one <ticket>. Use the one you currently have to ride the next ship.
        LEFT_BILLET                   = 7449, -- You use your <item>. (<number> trip[/s] remaining)
        END_BILLET                    = 7450, -- You use up your <item>.
        MTICKET_ADDED                 = 7451, -- 10 tickets were added to your 'barge multi-ticket'
        DIG_THROW_AWAY                = 7294, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7256, -- You dig and you dig, but find nothing.
    },
    mob =
    {
        ORCTRAP               = GetFirstID('Orctrap'),
        TEMPEST_TIGON         = GetFirstID('Tempest_Tigon'),
        OVERGROWN_IVY         = GetFirstID('Overgrown_Ivy'),
        CRYPTONBERRY_EXECUTOR = GetFirstID('Cryptonberry_Executor'),
        MYCOPHILE             = GetFirstID('Mycophile'),
        HERCULES_BEETLE       = GetFirstID('Hercules_Beetle'),
        BULLHEADED_GROSVEZ    = 16785721,
    },
    npc =
    {
        HERCULES_BEETLE_TREES = GetTableOfIDs('qm_hercules_beetle'),
        LOGGING               = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.CARPENTERS_LANDING]
