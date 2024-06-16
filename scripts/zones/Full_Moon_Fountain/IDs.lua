-----------------------------------
-- Area: Full_Moon_Fountain
-----------------------------------
zones = zones or {}

zones[xi.zone.FULL_MOON_FOUNTAIN] =
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
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        UNABLE_TO_PROTECT             = 7377, -- You were unable to protect Ajido-Marujido. Now leaving the battlefield.
        PARTY_MEMBERS_HAVE_FALLEN     = 7665, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7672, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        PLAY_TIME_IS_OVER             = 7765, -- Play time is over! Powers of dark mana, answer my call!
        YOU_SHOULD_BE_THANKFUL        = 7766, -- You should be thankful. I'll give you a shortaru trip back to the hell you came from!
        DONT_GIVE_UP                  = 7767, -- Don't give up, adventurer! You are Windurst's guiding star, our beacon of hope!
        MEMBERS_OF_YOUR_PARTY         = 7630, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7631, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7633, -- The time limit for this battle is <number> minutes.


        -- TODO: Shift IDs
        NO_BATTLEFIELD_ENTRY          = 7342, -- A strong magical force is whirling up from the platform.

        TIME_IN_THE_BATTLEFIELD_IS_UP = 7320, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7335, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        ENTERING_THE_BATTLEFIELD_FOR  = 7763, -- Entering the battlefield for [The Moonlit Path/Moon Reading/Waking the Beast/Battaru Royale/The Moonlit Path/Waking the Beast]!
    },
    mob =
    {
        FENRIR_PRIME = GetFirstID('Fenrir_Prime'),
        ACE_OF_CUPS  = GetFirstID('Ace_of_Cups'),
        CARBUNCLE_PRIME_WTB = GetFirstID('Carbuncle_Prime'),
    },
    npc =
    {
    },
    -- Prime avatars in 'Waking the Beast' battlefield along with their respective 2hr ability
    primes =
    {
        {17473558, 17473569, 17473580,   0}, -- Carbuncle (Unused)
        {17473563, 17473574, 17473585, 848}, -- Ifrit (Inferno)
        {17473564, 17473575, 17473586, 884}, -- Shiva (Diamond Dust)
        {17473565, 17473576, 17473587, 875}, -- Garuda (Aerial Blast)
        {17473566, 17473577, 17473588, 857}, -- Titan (Earthen Fury)
        {17473567, 17473578, 17473589, 893}, -- Ramuh (Judgement Bolt)
        {17473568, 17473579, 17473590, 866}, -- Leviathan (Tidal Wave)
    },
}

return zones[xi.zone.FULL_MOON_FOUNTAIN]
