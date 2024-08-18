-----------------------------------
-- Colonization Reive Data
-----------------------------------
xi = xi or {}
xi.reives = xi.reives or {}

local CEIZAK_BATTLEGROUNDS_ID  = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
local CIRDAS_CAVERNS_ID        = zones[xi.zone.CIRDAS_CAVERNS]
local DHO_GATES_ID             = zones[xi.zone.DHO_GATES]
local FORET_DE_HENNETIEL_ID    = zones[xi.zone.FORET_DE_HENNETIEL]
local KAMIHR_DRIFTS_ID         = zones[xi.zone.KAMIHR_DRIFTS]
local MARJAMI_RAVINE_ID        = zones[xi.zone.MARJAMI_RAVINE]
local MOH_GATES_ID             = zones[xi.zone.MOH_GATES]
local MORIMAR_BASALT_FIELDS_ID = zones[xi.zone.MORIMAR_BASALT_FIELDS]
local OUTER_RAKAZNAR_ID        = zones[xi.zone.OUTER_RAKAZNAR]
local RAKAZNAR_INNER_COURT_ID  = zones[xi.zone.RAKAZNAR_INNER_COURT]
local SIH_GATES_ID             = zones[xi.zone.SIH_GATES]
local WOH_GATES_ID             = zones[xi.zone.WOH_GATES]
local YAHSE_HUNTING_GROUNDS_ID = zones[xi.zone.YAHSE_HUNTING_GROUNDS]
local YORCIA_WEALD_ID          = zones[xi.zone.YORCIA_WEALD]

--Zone Data
xi.reives.zoneData =
{
    [xi.zone.CEIZAK_BATTLEGROUNDS] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos 120 0.184 -54 261
            [1] =
            {
                mob =
                {
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 3,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 4,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 5,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 6,
                },
                obstacles =
                {
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 1,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    CEIZAK_BATTLEGROUNDS_ID.npc.REIVE_COLLISION_OFFSET,
                    CEIZAK_BATTLEGROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos -134 0.184 39 261
            [2] =
            {
                mob =
                {
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 19,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 20,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 21,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 22,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 23,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 24,
                },
                obstacles =
                {
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 16,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 17,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 18,
                },
                collision =
                {
                    CEIZAK_BATTLEGROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 2,
                    CEIZAK_BATTLEGROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
    
            -- !pos -239 0.184 174 261
            [3] =
            {
                mob =
                {
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 10,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 11,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 12,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 13,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 14,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 15,
                },
                obstacles =
                {
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 7,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 8,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 9,
                },
                collision =
                {
                    CEIZAK_BATTLEGROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 4,
                    CEIZAK_BATTLEGROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },
    
            -- !pos -280.499 0.409 182 261
            [4] =
            {
                mob =
                {
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 28,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 29,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 30,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 31,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 32,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 33,
                },
                obstacles =
                {
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 25,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 26,
                    CEIZAK_BATTLEGROUNDS_ID.mob.REIVE_MOB_OFFSET + 27,
                },
                collision =
                {
                    CEIZAK_BATTLEGROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 6,
                    CEIZAK_BATTLEGROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 7,
                },
            },
        },
    },

    [xi.zone.CIRDAS_CAVERNS] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos -120 19.972 22 270
            [1] =
            {
                mob =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 2,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 3,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 4,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 5,
                },
                obstacles =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 1,
                },
                collision =
                {
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 12,
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 13,
                },
            },

            -- !pos 439 19.972 142 270
            [2] =
            {
                mob =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 8,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 9,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 10,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 6,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 7,
                },
                collision =
                {
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET,
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 98 19.972 -40 270
            [3] =
            {
                mob =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 14,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 15,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 16,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 12,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 13,
                },
                collision =
                {
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 8,
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 9,
                },
            },

            -- !pos -62 19.972 160 270
            [4] =
            {
                mob =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 20,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 21,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 22,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 23,
                },
                obstacles =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 18,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 19,
                },
                collision =
                {
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 10,
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 11,
                },
            },

            -- !pos 160 19.972 301 270
            [5] =
            {
                mob =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 26,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 27,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 28,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 29,
                },
                obstacles =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 24,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 25,
                },
                collision =
                {
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 4,
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },

            -- !pos 220.215 20 40.89 270
            [6] =
            {
                mob =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 32,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 33,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 34,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 35,
                },
                obstacles =
                {
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 30,
                    CIRDAS_CAVERNS_ID.mob.REIVE_MOB_OFFSET + 31,
                },
                collision =
                {
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 2,
                    CIRDAS_CAVERNS_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.FORET_DE_HENNETIEL] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos 183.4 -1.9 220 262
            [1] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 1,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 2,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 3,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 10,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 11,
                },
            },
            -- !pos 136.5 -2.1 258 262
            [2] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 5,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 6,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 7,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 4,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 8,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 9,
                },
            },
    
            -- !pos -16.6 -1.8 380 262
            [3] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 9,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 10,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 8,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 6,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 7,
                },
            },
    
            -- !pos -63 -2.1 418 262
            [4] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 13,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 14,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 15,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 12,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 4,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },
    
            -- !pos 343 -1.8 -299.4 262
            [5] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 17,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 18,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 19,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 16,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 18,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 19,
                },
            },
    
            -- !pos 296 -2.0 -261 262
            [6] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 21,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 22,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 23,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 20,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 16,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 17,
                },
            },
    
            -- !pos -16.5 -1.93 -219 262
            [7] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 25,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 26,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 27,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 24,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 14,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 15,
                },
            },
    
            -- !pos -63.4 -2.1 -181 262
            [8] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 29,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 30,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 31,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 28,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 12,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 13,
                },
            },
    
            -- !pos -380.9 -1.9 23 262
            [9] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 33,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 34,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 35,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 32,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 2,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
    
            -- !pos -418.8 -2 -23.3 262
            [10] =
            {
                mob =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 37,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 38,
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 39,
                },
                obstacles =
                {
                    FORET_DE_HENNETIEL_ID.mob.REIVE_MOB_OFFSET + 36,
                },
                collision =
                {
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET,
                    FORET_DE_HENNETIEL_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },
        },
    },

    [xi.zone.MOH_GATES] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos 240 19 -57.5 269
            [1] =
            {
                mob =
                {
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 3,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 4,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 5,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 6,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 7,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 8,
                },
                obstacles =
                {
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 1,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    MOH_GATES_ID.npc.REIVE_COLLISION_OFFSET + 2,
                    MOH_GATES_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos 102 29.8 -160 269
            [2] =
            {
                mob =
                {
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 12,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 13,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 14,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 15,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 16,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 9,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 10,
                    MOH_GATES_ID.mob.REIVE_MOB_OFFSET + 11,
                },
                collision =
                {
                    MOH_GATES_ID.npc.REIVE_COLLISION_OFFSET,
                    MOH_GATES_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },
        },
    },

    [xi.zone.MORIMAR_BASALT_FIELDS] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos 119.7 -0.08 -54.9 265
            [1] =
            {
                mob =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 3,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 4,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 5,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 6,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 7,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 8,
                },
                obstacles =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 0,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 1,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 4,
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },
            
            -- !pos -3.5 0.106 60 265
            [2] =
            {
                mob =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 12,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 13,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 14,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 15,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 16,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 9,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 10,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 11,
                },
                collision =
                {
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 2,
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos -60 -15.89 -276.5 265
            [3] =
            {
                mob =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 21,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 22,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 23,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 24,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 25,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 26,
                },
                obstacles =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 18,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 19,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 20,
                },
                collision =
                {
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 10,
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 11,
                },
            },
            
            -- !pos -123 -15.89 -419.9 265  -- Need Fix for collision
            [4] =
            {
                mob =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 30,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 31,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 32,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 33,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 34,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 35,
                },
                obstacles =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 27,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 28,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 29,
                },
                collision =
                {
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 12,
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 13,
                },
            },

            -- !pos -363 -31.89 -140 265
            [5] =
            {
                mob =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 48,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 49,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 50,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 51,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 52,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 53,
                },
                obstacles =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 45,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 46,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 47,
                },
                collision =
                {
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 6,
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 7,
                },
            },

            -- !pos -243 -47.89 399.9 265
            [6] =
            {
                mob =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 57,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 58,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 59,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 60,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 61,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 62,
                },
                obstacles =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 54,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 55,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 56,
                },
                collision =
                {
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET,
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos -240.7 -32.45 -219.4 265
            [7] =
            {
                mob =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 39,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 40,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 41,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 42,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 43,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 44,
                },
                obstacles =
                {
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 36,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 37,
                    MORIMAR_BASALT_FIELDS_ID.mob.REIVE_MOB_OFFSET + 38,
                },
                collision =
                {
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 8,
                    MORIMAR_BASALT_FIELDS_ID.npc.REIVE_COLLISION_OFFSET + 9,
                },
            },
        },
    },

    [xi.zone.OUTER_RAKAZNAR] =
    {
        reiveObjRespawnTime = 900, -- 15 minutes
        reiveMobRespawnTime = 60,  -- 1 minute
        reive =
        {

            -- !pos 743.4 100 120.1 274
            [1] =
            {
                mob =
                {
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 3,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 4,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 5,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 6,
                },
                obstacles =
                {
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 1,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    OUTER_RAKAZNAR_ID.npc.REIVE_COLLISION_OFFSET,
                },
            },

            -- !pos 720 100 -175.4 274
            [2] =
            {
                mob =
                {
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 10,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 11,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 12,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 13,
                },
                obstacles =
                {
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 7,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 8,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 9,
                },
                collision =
                {
                    OUTER_RAKAZNAR_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 424 100 -159.9 274
            [3] =
            {
                mob =
                {
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 17,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 18,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 19,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 20,
                },
                obstacles =
                {
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 14,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 15,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 16,
                },
                collision =
                {
                    OUTER_RAKAZNAR_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos 440 100 135.2 274
            [4] =
            {
                mob =
                {
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 24,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 25,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 26,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 27,
                },
                obstacles =
                {
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 21,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 22,
                    OUTER_RAKAZNAR_ID.mob.REIVE_MOB_OFFSET + 23,
                },
                collision =
                {
                    OUTER_RAKAZNAR_ID.npc.REIVE_COLLISION_OFFSET + 2,
                },
            },
        },
    },

    [xi.zone.RAKAZNAR_INNER_COURT] =
    {
        reiveObjRespawnTime = 900, -- 15 minutes
        reiveMobRespawnTime = 60,  -- 1 minute
        reive =
        {
            -- !pos 894.2 100 199.8 276
            [1] =
            {
                mob =
                {
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 3,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 4,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 5,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 6,
                },
                obstacles =
                {
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 1,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    RAKAZNAR_INNER_COURT_ID.npc.REIVE_COLLISION_OFFSET,
                },
            },

            -- !pos 519.9 100 228.6 276
            [2] =
            {
                mob =
                {
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 10,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 11,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 12,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 13,
                },
                obstacles =
                {
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 7,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 8,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 9,
                },
                collision =
                {
                    RAKAZNAR_INNER_COURT_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 506 90 -160 276
            [3] =
            {
                mob =
                {
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 17,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 18,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 19,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 20,
                },
                obstacles =
                {
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 14,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 15,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 16,
                },
                collision =
                {
                    RAKAZNAR_INNER_COURT_ID.npc.REIVE_COLLISION_OFFSET + 2,
                },
            },

            -- !pos 879.9 90 -173.8 276
            [4] =
            {
                mob =
                {
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 24,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 25,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 26,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 27,
                },
                obstacles =
                {
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 21,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 22,
                    RAKAZNAR_INNER_COURT_ID.mob.REIVE_MOB_OFFSET + 23,
                },
                collision =
                {
                    RAKAZNAR_INNER_COURT_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.SIH_GATES] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos -118.8 -10 -99 268
            [1] =
            {
                mob =
                {
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 3,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 4,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 5,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 6,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 7,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 8,
                },
                obstacles =
                {
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 1,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    SIH_GATES_ID.npc.REIVE_COLLISION_OFFSET,
                    SIH_GATES_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos -77.9 -9.8 -259.9 268
            [2] =
            {
                mob =
                {
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 12,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 13,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 14,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 15,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 16,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 9,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 10,
                    SIH_GATES_ID.mob.REIVE_MOB_OFFSET + 11,
                },
                collision =
                {
                    SIH_GATES_ID.npc.REIVE_COLLISION_OFFSET + 2,
                    SIH_GATES_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.WOH_GATES] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos 276 30 99.5 273
            [1] =
            {
                mob =
                {
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 2,
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 3,
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 4,
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 5,
                },
                obstacles =
                {
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET,
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 1,
                },
                collision =
                {
                    WOH_GATES_ID.npc.REIVE_COLLISION_OFFSET,
                    WOH_GATES_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 284 30.6 259.7 273
            [2] =
            {
                mob =
                {
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 8,
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 9,
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 10,
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 6,
                    WOH_GATES_ID.mob.REIVE_MOB_OFFSET + 7,
                },
                collision =
                {
                    WOH_GATES_ID.npc.REIVE_COLLISION_OFFSET + 2,
                    WOH_GATES_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },
    
    [xi.zone.YAHSE_HUNTING_GROUNDS] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {
            -- !pos -155.5 0.3 141.9 260
            [1] =
            {
                mob =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 17,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 18,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 19,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 20,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 21,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 22,
                },
                obstacles =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 14,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 15,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 16,
                },
                collision =
                {
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 8,
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 9,
                },
            },

            -- !pos 116 0.3 -177.9 260
            [2] =
            {
                mob =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 26,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 27,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 28,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 29,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 30,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 31,
                },
                obstacles =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 23,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 24,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 25,
                },
                collision =
                {
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 4,
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 5,
                },
            },
    
            -- !pos 153 0.49 -19.7 260
            [3] =
            {
                mob =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 10,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 11,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 12,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 13,
                },
                obstacles =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 7,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 8,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 9,
                },
                collision =
                {
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 0,
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },
    
            -- !pos -315.7 0.41 -221 260
            [4] =
            {
                mob =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 35,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 36,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 37,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 38,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 39,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 40,
                },
                obstacles =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 32,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 33,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 34,
                },
                collision =
                {
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 6,
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 7,
                },
            },
    
            -- !pos 115 0.27 -176 260
            [5] =
            {
                mob =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 3,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 4,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 5,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 6,
                },
                obstacles =
                {
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 0,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 1,
                    YAHSE_HUNTING_GROUNDS_ID.mob.REIVE_MOB_OFFSET + 2,
                },
                collision =
                {
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 2,
                    YAHSE_HUNTING_GROUNDS_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },
        },
    },

    [xi.zone.YORCIA_WEALD] =
    {
        reiveObjRespawnTime = 3600, -- 60 minutes
        reiveMobRespawnTime = 300,  -- 5 minutes
        reive =
        {

            -- !pos 100 1.6 342 263
            [1] =
            {
                mob =
                {
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 2,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 3,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 4,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 5,
                },
                obstacles =
                {
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 0,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 1,
                },
                collision =
                {
                    YORCIA_WEALD_ID.npc.REIVE_COLLISION_OFFSET + 0,
                },
            },

            -- !pos -102 1.57 180 263
            [2] =
            {
                mob =
                {
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 8,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 9,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 10,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 11,
                },
                obstacles =
                {
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 6,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 7,
                },
                collision =
                {
                    YORCIA_WEALD_ID.npc.REIVE_COLLISION_OFFSET + 3,
                },
            },

            -- !pos 258 1.57 -140 263
            [3] =
            {
                mob =
                {
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 14,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 15,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 16,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 17,
                },
                obstacles =
                {
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 12,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 13,
                },
                collision =
                {
                    YORCIA_WEALD_ID.npc.REIVE_COLLISION_OFFSET + 1,
                },
            },

            -- !pos 60 1.63 -178 263
            [4] =
            {
                mob =
                {
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 20,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 21,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 22,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 23,
                },
                obstacles =
                {
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 18,
                    YORCIA_WEALD_ID.mob.REIVE_MOB_OFFSET + 19,
                },
                collision =
                {
                    YORCIA_WEALD_ID.npc.REIVE_COLLISION_OFFSET + 2,
                },
            },
        },
    },
}
