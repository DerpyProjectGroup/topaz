-----------------------------------
-- Area: Jade_Sepulcher
-----------------------------------
zones = zones or {}

zones[xi.zone.JADE_SEPULCHER] =
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
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        -- PARTY_MEMBERS_HAVE_FALLEN     = 7669, -- All party members have fallen in battle. Now leaving the battlefield.
        -- THE_PARTY_WILL_BE_REMOVED     = 7676, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        SURRENDER_STRENGTH            = 7741, -- Come, surrender your strength to me and serve the Empire in death!≺Prompt≻
        SOUL_DEVOURED                 = 7742, -- Your soul will be devoured by the power you seek... Serve the Empire to the last by joining your strength to mine!≺Prompt≻
        BEAST_OF_AMBITION             = 7743, -- The beast of ambition has slain you...Rest now in eternal slumber.≺Prompt≻
        STRENGTH_HAS_FAILED_ME        = 7744, -- My strength has failed me...≺Prompt≻
        BLUE_MAGIC_ARSENAL            = 7745, -- Blue magic is but one part of our arsenal.A fact you will soon learn...≺Prompt≻
        SHOW_ME                       = 7746, -- Show me! Show me the power that lurks within you!≺Prompt≻
        BURIED_IN_THE_SHADOW          = 7747, -- You will be buried in the shadow of forgotten history!≺Prompt≻
        AZURE_SAVAGERY                = 7748, -- Now you will bear the full torrent of my azure savagery!≺Prompt≻
        IT_IS_OVER                    = 7749, -- It is over. You have no strength left to resist me. Surrender to your fate!≺Prompt≻
        POWER_YOU_WEILD               = 7750, -- Hahaha... The greater the power you wield, the greater my strength will be when I devour your essence...!≺Prompt≻
        LIMIT_75                      = 7751, -- Your level limit is now 75.≺Prompt≻

        -- TODO: Shift IDs
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7324, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7339, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7363, -- A decorative door. It appears to be locked...
        TESTIMONY_IS_TORN             = 7382, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7383, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7630, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7631, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7633, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7634, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7635, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7669, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7675, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7697, -- Entering the battlefield for [Making a Mockery/Shadows of the Mind/The Beast Within/Moment of Truth/Puppet in Peril/Puppet in Peril/Tateeya's Worries]!
    },
    mob =
    {
        LANCELORD_GAHEEL_JA = GetFirstID('Lancelord_Gaheel_Ja'),
        RAUBAHN = GetFirstID('Raubahn'),
    },
    npc =
    {
    },
}

return zones[xi.zone.JADE_SEPULCHER]
