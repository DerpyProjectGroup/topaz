-----------------------------------
--
-- Contains global functions and variables
-- related to area specific things
--
-----------------------------------

xi = xi or {}

xi.zoneType =
{
    NONE           = 0,
    CITY           = 1,
    OUTDOORS       = 2,
    DUNGEON        = 3,
    BATTLEFIELD    = 4,
    DYNAMIS        = 5,
    INSTANCED      = 6,
}

xi.continent =
{
    THE_MIDDLE_LANDS        = 1,
    THE_ARADJIAH_CONTINENT  = 2,
    THE_SHADOWREIGN_ERA     = 3,
    OTHER_AREAS             = 4,
}

xi.region =
{
    RONFAURE         = 0,
    ZULKHEIM         = 1,
    NORVALLEN        = 2,
    GUSTABERG        = 3,
    DERFLAND         = 4,
    SARUTABARUTA     = 5,
    KOLSHUSHU        = 6,
    ARAGONEU         = 7,
    FAUREGANDI       = 8,
    VALDEAUNIA       = 9,
    QUFIMISLAND      = 10,
    LITELOR          = 11,
    KUZOTZ           = 12,
    VOLLBOW          = 13,
    ELSHIMOLOWLANDS  = 14,
    ELSHIMOUPLANDS   = 15,
    TULIA            = 16,
    MOVALPOLOS       = 17,
    TAVNAZIANARCH    = 18,
    SANDORIA         = 19,
    BASTOK           = 20,
    WINDURST         = 21,
    JEUNO            = 22,
    DYNAMIS          = 23,
    TAVNAZIAN_MARQ   = 24,
    PROMYVION        = 25,
    LUMORIA          = 26,
    LIMBUS           = 27,
    WEST_AHT_URHGAN  = 28,
    MAMOOL_JA_SAVAGE = 29,
    HALVUNG          = 30,
    ARRAPAGO         = 31,
    ALZADAAL         = 32,
    RONFAURE_FRONT   = 33,
    NORVALLEN_FRONT  = 34,
    GUSTABERG_FRONT  = 35,
    DERFLAND_FRONT   = 36,
    SARUTA_FRONT     = 37,
    ARAGONEAU_FRONT  = 38,
    FAUREGANDI_FRONT = 39,
    VALDEAUNIA_FRONT = 40,
    ABYSSEA          = 41,
    THE_THRESHOLD    = 42,
    ABDHALJS         = 43,
    ADOULIN_ISLANDS  = 44,
    EAST_ULBUKA      = 45,
    UNKNOWN          = 255,
}

xi.nation =
{
    SANDORIA = 0,
    BASTOK   = 1,
    WINDURST = 2,
    BEASTMEN = 3,
    OTHER    = 4,
}

xi.alliedNation =
{
    NONE     = 0,
    SANDORIA = 1,
    BASTOK   = 2,
    WINDURST = 3,
}

xi.zone =
{
    UNKNOWN                         = 0,
    PHANAUET_CHANNEL                = 1,
    CARPENTERS_LANDING              = 2,
    MANACLIPPER                     = 3,
    BIBIKI_BAY                      = 4,
    ULEGUERAND_RANGE                = 5,
    BEARCLAW_PINNACLE               = 6,
    ATTOHWA_CHASM                   = 7,
    BONEYARD_GULLY                  = 8,
    PSOXJA                          = 9,
    THE_SHROUDED_MAW                = 10,
    OLDTON_MOVALPOLOS               = 11,
    NEWTON_MOVALPOLOS               = 12,
    MINE_SHAFT_2716                 = 13,
    HALL_OF_TRANSFERENCE            = 14,
    ABYSSEA_KONSCHTAT               = 15,
    PROMYVION_HOLLA                 = 16,
    SPIRE_OF_HOLLA                  = 17,
    PROMYVION_DEM                   = 18,
    SPIRE_OF_DEM                    = 19,
    PROMYVION_MEA                   = 20,
    SPIRE_OF_MEA                    = 21,
    PROMYVION_VAHZL                 = 22,
    SPIRE_OF_VAHZL                  = 23,
    LUFAISE_MEADOWS                 = 24,
    MISAREAUX_COAST                 = 25,
    TAVNAZIAN_SAFEHOLD              = 26,
    PHOMIUNA_AQUEDUCTS              = 27,
    SACRARIUM                       = 28,
    RIVERNE_SITE_B01                = 29,
    RIVERNE_SITE_A01                = 30,
    MONARCH_LINN                    = 31,
    SEALIONS_DEN                    = 32,
    ALTAIEU                         = 33,
    GRAND_PALACE_OF_HUXZOI          = 34,
    THE_GARDEN_OF_RUHMET            = 35,
    EMPYREAL_PARADOX                = 36,
    TEMENOS                         = 37,
    APOLLYON                        = 38,
    DYNAMIS_VALKURM                 = 39,
    DYNAMIS_BUBURIMU                = 40,
    DYNAMIS_QUFIM                   = 41,
    DYNAMIS_TAVNAZIA                = 42,
    DIORAMA_ABDHALJS_GHELSBA        = 43,
    ABDHALJS_ISLE_PURGONORGO        = 44,
    ABYSSEA_TAHRONGI                = 45,
    OPEN_SEA_ROUTE_TO_AL_ZAHBI      = 46,
    OPEN_SEA_ROUTE_TO_MHAURA        = 47,
    AL_ZAHBI                        = 48,
    AHT_URHGAN_WHITEGATE            = 50,
    WAJAOM_WOODLANDS                = 51,
    BHAFLAU_THICKETS                = 52,
    NASHMAU                         = 53,
    ARRAPAGO_REEF                   = 54,
    ILRUSI_ATOLL                    = 55,
    PERIQIA                         = 56,
    TALACCA_COVE                    = 57,
    SILVER_SEA_ROUTE_TO_NASHMAU     = 58,
    SILVER_SEA_ROUTE_TO_AL_ZAHBI    = 59,
    THE_ASHU_TALIF                  = 60,
    MOUNT_ZHAYOLM                   = 61,
    HALVUNG                         = 62,
    LEBROS_CAVERN                   = 63,
    NAVUKGO_EXECUTION_CHAMBER       = 64,
    MAMOOK                          = 65,
    MAMOOL_JA_TRAINING_GROUNDS      = 66,
    JADE_SEPULCHER                  = 67,
    AYDEEWA_SUBTERRANE              = 68,
    LEUJAOAM_SANCTUM                = 69,
    CHOCOBO_CIRCUIT                 = 70,
    THE_COLOSSEUM                   = 71,
    ALZADAAL_UNDERSEA_RUINS         = 72,
    ZHAYOLM_REMNANTS                = 73,
    ARRAPAGO_REMNANTS               = 74,
    BHAFLAU_REMNANTS                = 75,
    SILVER_SEA_REMNANTS             = 76,
    NYZUL_ISLE                      = 77,
    HAZHALM_TESTING_GROUNDS         = 78,
    CAEDARVA_MIRE                   = 79,
    SOUTHERN_SAN_DORIA_S            = 80,
    EAST_RONFAURE_S                 = 81,
    JUGNER_FOREST_S                 = 82,
    VUNKERL_INLET_S                 = 83,
    BATALLIA_DOWNS_S                = 84,
    LA_VAULE_S                      = 85,
    EVERBLOOM_HOLLOW                = 86,
    BASTOK_MARKETS_S                = 87,
    NORTH_GUSTABERG_S               = 88,
    GRAUBERG_S                      = 89,
    PASHHOW_MARSHLANDS_S            = 90,
    ROLANBERRY_FIELDS_S             = 91,
    BEADEAUX_S                      = 92,
    RUHOTZ_SILVERMINES              = 93,
    WINDURST_WATERS_S               = 94,
    WEST_SARUTABARUTA_S             = 95,
    FORT_KARUGO_NARUGO_S            = 96,
    MERIPHATAUD_MOUNTAINS_S         = 97,
    SAUROMUGUE_CHAMPAIGN_S          = 98,
    CASTLE_OZTROJA_S                = 99,
    WEST_RONFAURE                   = 100,
    EAST_RONFAURE                   = 101,
    LA_THEINE_PLATEAU               = 102,
    VALKURM_DUNES                   = 103,
    JUGNER_FOREST                   = 104,
    BATALLIA_DOWNS                  = 105,
    NORTH_GUSTABERG                 = 106,
    SOUTH_GUSTABERG                 = 107,
    KONSCHTAT_HIGHLANDS             = 108,
    PASHHOW_MARSHLANDS              = 109,
    ROLANBERRY_FIELDS               = 110,
    BEAUCEDINE_GLACIER              = 111,
    XARCABARD                       = 112,
    CAPE_TERIGGAN                   = 113,
    EASTERN_ALTEPA_DESERT           = 114,
    WEST_SARUTABARUTA               = 115,
    EAST_SARUTABARUTA               = 116,
    TAHRONGI_CANYON                 = 117,
    BUBURIMU_PENINSULA              = 118,
    MERIPHATAUD_MOUNTAINS           = 119,
    SAUROMUGUE_CHAMPAIGN            = 120,
    THE_SANCTUARY_OF_ZITAH          = 121,
    ROMAEVE                         = 122,
    YUHTUNGA_JUNGLE                 = 123,
    YHOATOR_JUNGLE                  = 124,
    WESTERN_ALTEPA_DESERT           = 125,
    QUFIM_ISLAND                    = 126,
    BEHEMOTHS_DOMINION              = 127,
    VALLEY_OF_SORROWS               = 128,
    GHOYUS_REVERIE                  = 129,
    RUAUN_GARDENS                   = 130,
    MORDION_GAOL                    = 131,
    ABYSSEA_LA_THEINE               = 132,
    OUTER_RAKAZNAR_U2               = 133,
    DYNAMIS_BEAUCEDINE              = 134,
    DYNAMIS_XARCABARD               = 135,
    BEAUCEDINE_GLACIER_S            = 136,
    XARCABARD_S                     = 137,
    CASTLE_ZVAHL_BAILEYS_S          = 138,
    HORLAIS_PEAK                    = 139,
    GHELSBA_OUTPOST                 = 140,
    FORT_GHELSBA                    = 141,
    YUGHOTT_GROTTO                  = 142,
    PALBOROUGH_MINES                = 143,
    WAUGHROON_SHRINE                = 144,
    GIDDEUS                         = 145,
    BALGAS_DAIS                     = 146,
    BEADEAUX                        = 147,
    QULUN_DOME                      = 148,
    DAVOI                           = 149,
    MONASTIC_CAVERN                 = 150,
    CASTLE_OZTROJA                  = 151,
    ALTAR_ROOM                      = 152,
    THE_BOYAHDA_TREE                = 153,
    DRAGONS_AERY                    = 154,
    CASTLE_ZVAHL_KEEP_S             = 155,
    THRONE_ROOM_S                   = 156,
    MIDDLE_DELKFUTTS_TOWER          = 157,
    UPPER_DELKFUTTS_TOWER           = 158,
    TEMPLE_OF_UGGALEPIH             = 159,
    DEN_OF_RANCOR                   = 160,
    CASTLE_ZVAHL_BAILEYS            = 161,
    CASTLE_ZVAHL_KEEP               = 162,
    SACRIFICIAL_CHAMBER             = 163,
    GARLAIGE_CITADEL_S              = 164,
    THRONE_ROOM                     = 165,
    RANGUEMONT_PASS                 = 166,
    BOSTAUNIEUX_OUBLIETTE           = 167,
    CHAMBER_OF_ORACLES              = 168,
    TORAIMARAI_CANAL                = 169,
    FULL_MOON_FOUNTAIN              = 170,
    CRAWLERS_NEST_S                 = 171,
    ZERUHN_MINES                    = 172,
    KORROLOKA_TUNNEL                = 173,
    KUFTAL_TUNNEL                   = 174,
    THE_ELDIEME_NECROPOLIS_S        = 175,
    SEA_SERPENT_GROTTO              = 176,
    VELUGANNON_PALACE               = 177,
    THE_SHRINE_OF_RUAVITAU          = 178,
    STELLAR_FULCRUM                 = 179,
    LALOFF_AMPHITHEATER             = 180,
    THE_CELESTIAL_NEXUS             = 181,
    WALK_OF_ECHOES                  = 182,
    MAQUETTE_ABDHALJS_LEGION_A      = 183,
    LOWER_DELKFUTTS_TOWER           = 184,
    DYNAMIS_SAN_DORIA               = 185,
    DYNAMIS_BASTOK                  = 186,
    DYNAMIS_WINDURST                = 187,
    DYNAMIS_JEUNO                   = 188,
    OUTER_RAKAZNAR_U3               = 189,
    KING_RANPERRES_TOMB             = 190,
    DANGRUF_WADI                    = 191,
    INNER_HORUTOTO_RUINS            = 192,
    ORDELLES_CAVES                  = 193,
    OUTER_HORUTOTO_RUINS            = 194,
    THE_ELDIEME_NECROPOLIS          = 195,
    GUSGEN_MINES                    = 196,
    CRAWLERS_NEST                   = 197,
    MAZE_OF_SHAKHRAMI               = 198,
    GARLAIGE_CITADEL                = 200,
    CLOISTER_OF_GALES               = 201,
    CLOISTER_OF_STORMS              = 202,
    CLOISTER_OF_FROST               = 203,
    FEIYIN                          = 204,
    IFRITS_CAULDRON                 = 205,
    QUBIA_ARENA                     = 206,
    CLOISTER_OF_FLAMES              = 207,
    QUICKSAND_CAVES                 = 208,
    CLOISTER_OF_TREMORS             = 209,
    GM_HOME                         = 210,
    CLOISTER_OF_TIDES               = 211,
    GUSTAV_TUNNEL                   = 212,
    LABYRINTH_OF_ONZOZO             = 213,
    ABYSSEA_ATTOHWA                 = 215,
    ABYSSEA_MISAREAUX               = 216,
    ABYSSEA_VUNKERL                 = 217,
    ABYSSEA_ALTEPA                  = 218,
    RESIDENTIAL_AREA                = 219,
    SHIP_BOUND_FOR_SELBINA          = 220,
    SHIP_BOUND_FOR_MHAURA           = 221,
    PROVENANCE                      = 222,
    SAN_DORIA_JEUNO_AIRSHIP         = 223,
    BASTOK_JEUNO_AIRSHIP            = 224,
    WINDURST_JEUNO_AIRSHIP          = 225,
    KAZHAM_JEUNO_AIRSHIP            = 226,
    SHIP_BOUND_FOR_SELBINA_PIRATES  = 227,
    SHIP_BOUND_FOR_MHAURA_PIRATES   = 228,
    THRONE_ROOM_V                   = 229,
    SOUTHERN_SAN_DORIA              = 230,
    NORTHERN_SAN_DORIA              = 231,
    PORT_SAN_DORIA                  = 232,
    CHATEAU_DORAGUILLE              = 233,
    BASTOK_MINES                    = 234,
    BASTOK_MARKETS                  = 235,
    PORT_BASTOK                     = 236,
    METALWORKS                      = 237,
    WINDURST_WATERS                 = 238,
    WINDURST_WALLS                  = 239,
    PORT_WINDURST                   = 240,
    WINDURST_WOODS                  = 241,
    HEAVENS_TOWER                   = 242,
    RULUDE_GARDENS                  = 243,
    UPPER_JEUNO                     = 244,
    LOWER_JEUNO                     = 245,
    PORT_JEUNO                      = 246,
    RABAO                           = 247,
    SELBINA                         = 248,
    MHAURA                          = 249,
    KAZHAM                          = 250,
    HALL_OF_THE_GODS                = 251,
    NORG                            = 252,
    ABYSSEA_ULEGUERAND              = 253,
    ABYSSEA_GRAUBERG                = 254,
    ABYSSEA_EMPYREAL_PARADOX        = 255,
    WESTERN_ADOULIN                 = 256,
    EASTERN_ADOULIN                 = 257,
    RALA_WATERWAYS                  = 258,
    RALA_WATERWAYS_U                = 259,
    YAHSE_HUNTING_GROUNDS           = 260,
    CEIZAK_BATTLEGROUNDS            = 261,
    FORET_DE_HENNETIEL              = 262,
    YORCIA_WEALD                    = 263,
    YORCIA_WEALD_U                  = 264,
    MORIMAR_BASALT_FIELDS           = 265,
    MARJAMI_RAVINE                  = 266,
    KAMIHR_DRIFTS                   = 267,
    SIH_GATES                       = 268,
    MOH_GATES                       = 269,
    CIRDAS_CAVERNS                  = 270,
    CIRDAS_CAVERNS_U                = 271,
    DHO_GATES                       = 272,
    WOH_GATES                       = 273,
    OUTER_RAKAZNAR                  = 274,
    OUTER_RAKAZNAR_U1               = 275,
    RAKAZNAR_INNER_COURT            = 276,
    RAKAZNAR_TURRIS                 = 277,
    GWORA_CORRIDOR                  = 278,
    WALK_OF_ECHOES_P2               = 279,
    MOG_GARDEN                      = 280,
    LEAFALLIA                       = 281,
    MOUNT_KAMIHR                    = 282,
    SILVER_KNIFE                    = 283,
    CELENNIA_MEMORIAL_LIBRARY       = 284,
    FERETORY                        = 285,
    MAQUETTE_ABDHALJS_LEGION_B      = 287,
    ESCHA_ZITAH                     = 288,
    ESCHA_RUAUN                     = 289,
    DESUETIA_EMPYREAL_PARADOX       = 290,
    REISENJIMA                      = 291,
    REISENJIMA_HENGE                = 292,
    REISENJIMA_SANCTORIUM           = 293,
    DYNAMIS_SAN_DORIA_D             = 294,
    DYNAMIS_BASTOK_D                = 295,
    DYNAMIS_WINDURST_D              = 296,
    DYNAMIS_JEUNO_D                 = 297,
    WALK_OF_ECHOES_P1               = 298,
    GWORA_THRONE_ROOM               = 299,

    -- Increment this when adding new zones
    MAX_ZONE                        = 300,
}

xi.expansionRegion = xi.expansionRegion or {}
xi.expansionRegion.ORIGINAL_ROTZ = set{
    xi.region.RONFAURE,
    xi.region.ZULKHEIM,
    xi.region.NORVALLEN,
    xi.region.GUSTABERG,
    xi.region.DERFLAND,
    xi.region.SARUTABARUTA,
    xi.region.KOLSHUSHU,
    xi.region.ARAGONEU,
    xi.region.FAUREGANDI,
    xi.region.VALDEAUNIA,
    xi.region.QUFIMISLAND,
    xi.region.LITELOR,
    xi.region.KUZOTZ,
    xi.region.VOLLBOW,
    xi.region.ELSHIMOLOWLANDS,
    xi.region.ELSHIMOUPLANDS,
    xi.region.SANDORIA,
    xi.region.BASTOK,
    xi.region.WINDURST,
    xi.region.JEUNO,
    xi.region.DYNAMIS,
}

xi.expansionRegion.ABYSSEA = set{
    xi.region.ABYSSEA_KONSCHTAT,
    xi.region.ABYSSEA_TAHRONGI,
    xi.region.ABYSSEA_LA_THEINE,
    xi.region.ABYSSEA_ATTOHWA,
    xi.region.ABYSSEA_MISAREAUX,
    xi.region.ABYSSEA_VUNKERL,
    xi.region.ABYSSEA_ALTEPA,
    xi.region.ABYSSEA_ULEGUERAND,
    xi.region.ABYSSEA_GRAUBERG,
    xi.region.ABYSSEA_EMPYREAL_PARADOX,
}

-----------------------------------
-- SetExplorerMoogles
-----------------------------------

function SetExplorerMoogles(moogle)
    if xi.settings.main.EXPLORER_MOOGLE_LV ~= 0 then
        local npc = GetNPCByID(moogle)
        if npc == nil then
            printf("'SetExplorerMoogles' Error trying to load undefined npc (%d)", moogle)
        else
            npc:setStatus(0)
        end
    end
end