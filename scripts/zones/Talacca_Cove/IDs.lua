-----------------------------------
-- Area: Talacca_Cove
-----------------------------------
zones = zones or {}

zones[xi.zone.TALACCA_COVE] =
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
        FISHING_MESSAGE_OFFSET        = 7060, -- You can't fish here.
        VALKENG_MELEE_CHANGE_FRAME    = 7866, -- Confirming status...Damage from melee attacks...≺Numeric Parameter 0≻%.Changing frame...
        VALKENG_RANGED_CHANGE_FRAME   = 7867, -- Confirming status...Damage from ranged attacks...≺Numeric Parameter 0≻%.Changing frame...
        VALKENG_MAGIC_CHANGE_FRAME    = 7868, -- Confirming status...Damage from magic attacks...≺Numeric Parameter 0≻%.Changing frame...
        VALKENG_MELEE_KEEP_FRAME      = 7869, -- Confirming status...Damage from melee attacks...≺Numeric Parameter 0≻%.Executing maneuver...
        VALKENG_RANGED_KEEP_FRAME     = 7870, -- Confirming status...Damage from ranged attacks...≺Numeric Parameter 0≻%.Executing maneuver...
        VALKENG_MAGIC_KEEP_FRAME      = 7871, -- Confirming status...Damage from magic attacks...≺Numeric Parameter 0≻%.Executing maneuver...

        -- TODO: Shift IDs
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7324, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7339, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        NO_BATTLEFIELD_ENTRY          = 7362, -- It appears as if something had been thrust into the rockface here...
        TESTIMONY_IS_TORN             = 7382, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7383, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7630, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7631, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7633, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7634, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7635, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7669, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7676, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7697, -- Entering the battlefield for [Call to Arms/Compliments to the Chef/Puppetmaster Blues/Breaking the Bonds of Fate/Legacy of the Lost/Legacy of the Lost]!
        YOU_CAN_NOW_BECOME_A_CORSAIR  = 7795, -- You can now become a corsair!
    },
    mob =
    {
        GESSHO  = GetFirstID('Gessho'),
        VALKENG = GetFirstID('Valkeng'),
    },
    npc =
    {
    },
}

return zones[xi.zone.TALACCA_COVE]
