LOCK TABLES `item_mods` WRITE,
            `item_equipment` WRITE,
            `item_weapon` WRITE,
            `item_mods_pet` WRITE,
            `item_latents` WRITE;

REPLACE INTO `item_equipment` (`itemId`, `name`, `level`, `ilevel`, `jobs`, `MId`, `shieldSize`, `scriptType`, `slot`, `rslot`, `rslotlook`, `su_level`) VALUES

(17042,'bronze_hammer',5,0,1048644,113,0,0,3,0,0,0),
(17144,'bronze_hammer_+1',5,0,1048644,113,0,0,3,0,0,0),
(17043,'brass_hammer',12,0,1048644,114,0,0,3,0,0,0),
(17149,'brass_hammer_+1',12,0,1048644,114,0,0,3,0,0,0),
(17048,'decurions_hammer',18,0,1048644,115,0,0,3,0,0,0),
(17044,'warhammer',20,0,1048644,115,0,0,3,0,0,0),
(17115,'warhammer_+1',20,0,1048644,115,0,0,3,0,0,0),
(17452,'bastokan_hammer',23,0,1048644,115,0,0,3,0,0,0),
(17453,'republic_hammer',23,0,1048644,115,0,0,3,0,0,0),
(17083,'time_hammer',47,0,1048644,115,0,0,3,0,0,0),
(17045,'maul',31,0,1048644,116,0,0,3,0,0,0),
(17121,'maul_+1',31,0,1048644,116,0,0,3,0,0,0),
(17080,'holy_maul',38,0,1048644,116,0,0,3,0,0,0),
(17114,'holy_maul_+1',38,0,1048644,116,0,0,3,0,0,0),
(18392,'sacred_maul',38,0,1048644,116,0,0,3,0,0,0),
(18853,'spirit_maul',38,0,1048644,116,0,0,3,0,0,0),
(17046,'darksteel_maul',65,0,1048644,112,0,0,3,0,0,0),
(17432,'darksteel_maul_+1',65,0,1048644,112,0,0,3,0,0,0),
(18320,'relic_maul',75,0,68,114,0,0,3,0,0,0),
(18321,'battering_maul',75,0,68,114,0,0,3,0,0,0),
(18322,'dynamis_maul',75,0,68,114,0,0,3,0,0,0),
(18870,'dweomer_maul',75,0,68,112,0,0,3,0,0,0),
(17462,'platoon_mace',20,0,1589324,104,0,0,3,0,0,0),
(17450,'healing_mace',52,0,68,104,0,0,3,0,0,0),
(17429,'dominion_mace',59,0,68,105,0,0,3,0,0,0),
(17471,'horrent_mace',70,0,2097345,103,0,0,3,0,0,0),
(17464,'purgatory_mace',70,0,68,103,0,0,3,0,0,0),
(17458,'rsv.cpt._mace',71,0,1590111,105,0,0,3,0,0,0),
(18854,'fourth_mace',71,0,1590111,105,0,0,3,0,0,0),

(18260,'relic_knuckles',75,0,131074,135,0,0,1,0,0,0), -- Add PUP
(18261,'militant_knuckles',75,0,131074,135,0,0,1,0,0,0),
(18262,'dynamis_knuckles',75,0,131074,135,0,0,1,0,0,0),
(18263,'caestus',75,0,131074,135,0,1,1,0,0,0),
(18264,'spharai',75,0,131074,511,0,1,1,0,0,0),

(18266,'relic_dagger',75,0,262704,163,0,0,3,0,0,0), -- Add DNC
(18267,'malefic_dagger',75,0,262704,163,0,0,3,0,0,0),
(18268,'dynamis_dagger',75,0,262704,163,0,0,3,0,0,0),
(18269,'batardeau',75,0,262704,163,0,1,3,0,0,0),
(18270,'mandau',75,0,262704,334,0,1,3,0,0,0),

(18272,'relic_sword',75,0,32848,269,0,0,3,0,0,0), -- Add BLU
(18273,'glyptic_sword',75,0,32848,269,0,0,3,0,0,0),
(18274,'dynamis_sword',75,0,32848,269,0,0,3,0,0,0),
(18275,'caliburn',75,0,32848,269,0,1,3,0,0,0),
(18276,'excalibur',75,0,32848,320,0,1,3,0,0,0),

(18278,'relic_blade',75,0,2097345,72,0,0,1,0,0,0), -- Add RUN
(18279,'gilded_blade',75,0,2097345,72,0,0,1,0,0,0),
(18280,'dynamis_blade',75,0,2097345,72,0,0,1,0,0,0),
(18281,'valhalla',75,0,2097345,64,0,1,1,0,0,0),
(18282,'ragnarok',75,0,2097345,319,0,1,1,0,0,0),

(18320,'relic_maul',75,0,1048644,114,0,0,3,0,0,0), -- Add PLD/GEO
(18321,'battering_maul',75,0,1048644,114,0,0,3,0,0,0),
(18322,'dynamis_maul',75,0,1048644,114,0,0,3,0,0,0),
(18323,'gullintani',75,0,1048644,114,0,1,3,0,0,0),
(18324,'mjollnir',75,0,1048644,307,0,1,3,0,0,0),

(18326,'relic_staff',75,0,540680,295,0,0,1,0,0,0), -- Add SCH
(18327,'sages_staff',75,0,540680,295,0,0,1,0,0,0),
(18328,'dynamis_staff',75,0,540680,295,0,0,1,0,0,0),
(18329,'thyrus',75,0,540680,295,0,1,1,0,0,0),
(18330,'claustrum',75,0,540680,342,0,1,1,0,0,0),

(18332,'relic_gun',75,0,66560,58,0,0,4,0,0,0), -- Add COR
(18333,'marksman_gun',75,0,66560,58,0,0,4,0,0,0),
(18334,'dynamis_gun',75,0,66560,58,0,0,4,0,0,0),
(18335,'ferdinand',75,0,66560,58,0,1,4,0,0,0),
(18336,'annihilator',75,0,66560,85,0,1,4,0,0,0),

(16555,'ridill',70,0,36257,259,0,0,3,0,0,0), -- Add BLU

-- Lv 75+ Treasure Casket Items
(10924,'chocobo_torque',70,0,4194303,0,0,0,512,0,0,0),     -- Lv 81 -> Lv 70
(10925,'fishers_torque',70,0,4194303,0,0,0,512,0,0,0),     -- Lv 81 -> Lv 70
(10926,'field_torque',70,0,4194303,0,0,0,512,0,0,0),       -- Lv 81 -> Lv 70
(11767,'chocobo_rope',70,0,4194303,0,0,0,1024,0,0,0),      -- Lv 81 -> Lv 70
(11768,'fishers_rope',70,0,4194303,0,0,0,1024,0,0,0),      -- Lv 81 -> Lv 70
(11769,'field_rope',70,0,4194303,0,0,0,1024,0,0,0),        -- Lv 81 -> Lv 70
(11920,'melaco_mittens',75,0,2472947,14,0,0,64,0,0,0),     -- Lv 90 -> Lv 75
(11038,'dragonkin_earring',75,0,8641,0,0,0,6144,0,0,0),    -- Lv 95 -> Lv 75
(11823,'cocoon_band',72,0,4194303,0,0,0,16,0,0,0),         -- Lv 88 -> Lv 72
(10991,'rancorous_mantle',75,0,4194303,0,0,0,32768,0,0,0), -- Lv 98 -> Lv 75
(18812,'ossa_grip',75,0,4194303,0,0,0,2,0,0,0),            -- Lv 88 -> Lv 75
(16202,'dagdas_shield',75,0,193,26,3,0,2,0,0,0),           -- Lv 90 -> Lv 75
(18784,'metasoma_katars',75,0,131219,118,0,0,1,0,0,0),     -- Lv 88 -> Lv 75
(11041,'liminus_earring',70,0,4194303,0,0,0,6144,0,0,0),   -- Lv 91 -> Lv 70
(18624,'numen_staff',72,0,1590047,291,0,0,1,0,0,0),        -- Lv 79 -> Lv 72
(11039,'brachyura_earring',72,0,4194303,0,0,0,6144,0,0,0), -- Lv 91 -> Lv 72
(18816,'wizzan_grip',72,0,4194303,0,0,0,2,0,0,0),          -- Lv 91 -> Lv 72
(18817,'furtive_grip',72,0,4194303,0,0,0,2,0,0,0),         -- Lv 93 -> Lv 72
(11575,'grapevine_cape',72,0,1753628,0,0,0,32768,0,0,0),   -- Lv 86 -> Lv 72
(19780,'mana_ampulla',72,0,1589788,0,0,0,8,0,0,0),         -- Lv 97 -> Lv 72
(11040,'terminus_earring',70,0,4194303,0,0,0,6144,0,0,0),  -- Lv 91 -> Lv 70
(11576,'bond_cape',70,0,1753628,0,0,0,32768,0,0,0),        -- Lv 90 -> Lv 70
(19779,'potestas_bomblet',75,0,2500642,0,0,0,8,0,0,0),     -- Lv 96 -> Lv 75
(11677,'prouesse_ring',70,0,4194303,0,0,0,24576,0,0,0),    -- Lv 77 -> Lv 70

-- Bst Jugs
(17902,'lucky_broth',75,0,256,0,0,0,8,0,0,0),                -- Lv 86 -> Lv 75
(17874,'cng._brain_broth',72,0,256,0,0,0,8,4,0,0),         -- Lv 76 -> Lv 72
(17883,'mlw._bird_broth',74,0,256,0,0,0,8,4,0,0),          -- Lv 86 -> Lv 74
(17878,'l._carrot_broth',65,0,256,0,0,0,8,4,0,0),          -- Lv 86 -> Lv 74
(17893,'wool_grease',68,0,256,0,0,0,8,0,0,0),
(17904,'briny_broth',69,0,256,0,0,0,8,0,0,0),
(17881,'deepbed_soil',33,0,256,0,0,0,8,0,0,0),
(17879,'c._plasma_broth',62,0,256,0,0,0,8,4,0,0),
(17875,'rzr._brain_broth',75,0,256,0,0,0,8,4,0,0),
(17903,'shadowy_broth',75,0,256,0,0,0,8,0,0,0),
(17901,'b._carrion_broth',75,0,256,0,0,0,8,0,0,0),
(17900,'cl._wheat_broth',73,0,256,0,0,0,8,0,0,0),
-- (17907,'swirling_broth',70,0,256,0,0,0,8,0,0,0),
-- (17909,'spicy_broth',70,0,256,0,0,0,8,0,0,0),
-- (17917,'bubbly_broth',75,0,256,0,0,0,8,0,0,0),
-- (17911,'salubrious_broth',75,0,256,0,0,0,8,0,0,0),
-- (17918,'windy_greens',75,0,256,0,0,0,8,0,0,0),
-- (21450,'electrified_broth',75,0,256,0,0,0,8,0,0,0),
-- (21451,'bug-ridden_broth',75,0,256,0,0,0,8,0,0,0),
-- (17912,'fizzy_broth',75,0,256,0,0,0,8,0,0,0),
-- (17919,'tant._broth',75,0,256,0,0,0,8,0,0,0),

-- Dynamis HNM Drops
(10973,'oneiros_cape',75,0,1753628,0,0,0,32768,0,0,0),
(11773,'oneiros_belt',75,0,2472947,0,0,0,1024,0,0,0),
(10972,'oneiros_cappa',75,0,2473971,0,0,0,32768,0,0,0),
(11772,'oneiros_sash',75,0,1589276,0,0,0,1024,0,0,0),
(19790,'oneiros_lance',75,0,8192,209,0,0,1,0,0,0),
(11774,'oneiros_cest',75,0,2473969,0,0,0,1024,0,0,0),
(11816,'oneiros_helm',75,0,2106337,144,0,0,16,0,0,0),
(11671,'oneiros_ring',75,0,474915,0,0,0,24576,0,0,0),
(11030,'oneiros_earring',75,0,212705,0,0,0,6144,0,0,0),
(11672,'mujin_band',75,0,4194303,0,0,0,24576,0,0,0),
(10932,'oneiros_torque',75,0,2472947,0,0,0,512,0,0,0),
(19295,'mujin_tanto',75,0,4096,313,0,0,3,0,0,0),
(10933,'mujin_necklace',75,0,8385,0,0,0,512,0,0,0),
(11818,'oneiros_headgear',75,0,1720860,145,0,0,16,0,0,0),
(11775,'oneiros_rope',75,0,4194303,0,0,0,1024,0,0,0),
(11776,'mujin_obi',75,0,3719388,0,0,0,1024,0,0,0),
(17358,'oneiros_harp',75,0,512,80,0,0,4,0,0,0),
(19767,'oneiros_pebble',75,0,2385,0,0,0,8,0,0,0),
(18519,'oneiros_axe',75,0,1,93,0,0,1,0,0,0),
(11670,'oneiros_annulet',75,0,4194303,0,0,0,24576,0,0,0),
(11817,'oneiros_barbut',75,0,65,147,0,0,16,0,0,0),
(10974,'mujin_mantle',75,0,474915,0,0,0,32768,0,0,0),
(19762,'oneiros_tathlum',75,0,2098561,0,0,0,8,0,0,0),
(11031,'oneiros_pearl',75,0,1024,0,0,0,6144,0,0,0),
(11032,'mujin_stud',75,0,2465590,0,0,0,6144,0,0,0),
(19141,'oneiros_knife',75,0,5680,158,0,0,3,0,0,0),
(18811,'oneiros_grip',75,0,4194303,0,0,0,2,0,0,0),
(11819,'oneiros_coif',75,0,3072,146,0,0,16,0,0,0),
(11456,'ryuga_sune-ate',75,0,2369954,106,0,0,256,0,0,0),
(11820,'khthonios_mask',75,0,1589788,16,0,0,16,0,0,0),
(11821,'khthonios_helm',75,0,931241,53,0,0,16,0,0,0),
(11918,'khthonios_gloves',75,0,3265,21,0,0,64,0,0,0),
(11919,'avesta_bangles',75,0,4179646,0,0,0,64,0,0,0),
(18623,'chtonic_staff',75,0,4194303,293,0,0,1,0,0,0),
(19763,'oneiros_cluster',75,0,2360608,0,0,0,8,0,0,0),
(11777,'demonry_sash',75,0,1589788,0,0,0,1024,0,0,0),
(19764,'demonry_core',75,0,2569522,0,0,0,8,0,0,0),
(11673,'demonry_ring',75,0,2369954,0,0,0,24576,0,0,0),
(19765,'demonry_stone',75,0,2473971,0,0,0,8,0,0,0),
(17669,'sagasinger',75,0,336465,528,0,0,3,0,0,0),
(10975,'archon_cape',75,0,4194303,0,0,0,32768,0,0,0),
(11674,'archon_ring',75,0,4194303,0,0,0,24576,0,0,0),
(18903,'talekeeper',75,0,336465,528,0,0,3,0,0,0),
(10754,'moepapa_ring',75,0,4194303,0,0,0,24576,0,0,0),
(10943,'moepapa_medal',75,0,4194303,0,0,0,512,0,0,0),
(17069,'moepapa_mace',75,0,1048645,107,0,0,3,0,0,0),
(10755,'moepapa_annulet',75,0,4194303,0,0,0,24576,0,0,0),
(10940,'moepapa_pendant',75,0,1589788,0,0,0,512,0,0,0),
(10984,'tjukurrpa_mantle',75,0,66592,0,0,0,32768,0,0,0),
(11923,'tjukurrpa_gauntlets',75,0,193,55,0,0,64,0,0,0),
(18541,'tjukurrpa_axe',75,0,256,82,0,0,3,0,0,0),
(10941,'tjukurrpa_medal',75,0,4194303,0,0,0,512,0,0,0),
(10818,'tjukurrpa_belt',75,0,2363683,0,0,0,1024,0,0,0),
(10757,'tjukurrpa_annulet',75,0,4194303,0,0,0,24576,0,0,0),
(10756,'tjukurrpa_ring',75,0,4194303,0,0,0,24576,0,0,0),
(10942,'aifes_medal',75,0,4194303,0,0,0,512,0,0,0),
(10983,'aifes_mantle',75,0,2473971,0,0,0,32768,0,0,0),
(19738,'aifes_bow',75,0,1024,37,0,0,4,0,0,0),
(10759,'aifes_annulet',75,0,4194303,0,0,0,24576,0,0,0),
(10758,'aifes_ring',75,0,4194303,0,0,0,24576,0,0,0),
(11461,'aifes_pumps',75,0,1589788,57,0,0,256,0,0,0),
(10760,'portus_ring',75,0,4194303,0,0,0,24576,0,0,0),
(10761,'portus_annulet',75,0,4194303,0,0,0,24576,0,0,0),
(10944,'portus_collar',75,0,2473969,0,0,0,512,0,0,0),
(11924,'alucinor_mitts',75,0,2593459,242,0,0,64,0,0,0);

REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES
-- Melaco Mittens
(11920,1,19),     -- DEF: 19
(11920,13,3),     -- MND: 3
(11920,161,-300), -- DMGPHYS: -300
(11920,225,5),    -- BIRD_KILLER: 5

-- Dragonkin Earring
(11038,23,5), -- ATT: 5

-- Cocoon Band
(11823,1,20),   -- DEF: 20
(11823,17,-10), -- WIND_RES: -10

-- Rancorous Mantle
(10991,1,8),   -- DEF: 8
(10991,23,10), -- ATT: 10

-- Potestas Bomblet
(19779,23,10), -- ATT: 10
(19779,8,1),   -- STR: 1

-- Grapevine Cape
(11575,1,7),     -- DEF: 5
(11575,12,2),    -- INT: 2
(11575,13,2),    -- MND: 2
(11575,2026,30), -- Refresh Duration +30s

-- Sniping Bow
(17188,11,4),  -- AGI +4
(17188,27,-1), -- Enmity -1
(17188,26,10), -- RACC +10
(17188,24,5),  -- RATT +5

-- Razor Axe
(16678,8,2),   -- STR +2
(16678,288,2), -- Double Attack +2

-- Beat Cesti
(17478,9,2),   -- DEX +2
(17478,10,2),  -- VIT +2
(17478,25,3),  -- ACC +3
(17478,291,2), -- Counter +2

-- Blessed Hammer
(17422,5,10),   -- MP +10
(17422,13,2),   -- MND +2
(17422,374,5),  -- Cure Potency +5% 
(18391,431,1),  -- ITEM_ADDEFFECT_TYPE: 1
(18391,499,7),  -- ITEM_SUBEFFECT: 7
(18391,500,10), -- ITEM_ADDEFFECT_DMG: 21
(18391,501,10), -- ITEM_ADDEFFECT_CHANCE: 20
(18391,950,7),  -- ITEM_ADDEFFECT_ELEMENT: 7

-- Casting Wand
(17423,5,20),  -- MP +20
(17423,12,2),  -- INT +2
(17423,28,3),  -- MATT +3
(17423,487,5), -- Magic Burst Potency +5%

-- Marauder's Knife
(16764,9,2),   -- DEX +2
(16764,11,2),  -- AGI +2
(16764,298,3), -- Steal +1
(16764,68,2),  -- EVA +2

-- Honor Sword
(17643,10,2),   -- VIT +2
(17643,13,2),   -- MND +2
(17643,27,1),   -- Enmity +1
(17643,387,-2), -- Physical damage taken -2%

-- Raven Scythe
(16798,8,2),    -- STR +2
(16798,12,2),   -- INT +2
(16798,25,1),   -- ACC +1
(16798,23,2),   -- ATT +2
(16798,315,10), -- DRAIN/ASPIR +10%

-- Barbaroi Axe
(16680,8,2),  -- STR +2
(16680,14,2), -- CHR +2

-- Paper Knife
(16766,11,2),  -- AGI +2
(16766,14,2),  -- CHR +2
(16766,454,5), -- Song Effect Duration +5%

-- Sniping Bow
(17188,11,4),  -- AGI +4 Sniping Bow Cactuar Edit 
(17188,27,-1), -- Enmity -1
(17188,26,10), -- RACC +10
(17188,24,5),  -- RATT +5

-- Anju
(17771,8,-1), -- STR -1
(17771,9,2),  -- DEX +2
(17771,68,2), -- EVA +2

-- Zushio
(17772,8,2),  -- STR +2
(17772,9,-1), -- DEX -1
(17772,23,3), -- ATT +3

-- Magoroku
(17812,8,2),  -- STR +2
(17812,11,2), -- AGI +2
(17812,73,3), -- StoreTP +3

-- Immortals Scimitar
(17717,5,10), -- MP +10
(17717,8,1),  -- STR +1
(17717,12,1), -- INT +1
(17717,25,2), -- ACC +2
(17717,28,2), -- MATT +2

-- Trump Gun
(18702,11,2), -- AGI +2
(18702,26,3), -- RACC +3
(18702,30,1), -- MACC +1
(18702,28,1), -- MATT +1

-- War Hoop
(19203,14,3),  -- CHR +3
(19203,491,5), -- Waltz Potency +3

-- Murasame
(16961,3,-5),   -- HPP: -5
(16961,15,16),  -- FIRE_RES: 16
(16961,431,1),  -- ITEM_ADDEFFECT_TYPE: 1
(16961,499,6),  -- ITEM_SUBEFFECT: 6
(16961,500,9),  -- ITEM_ADDEFFECT_DMG: 30
(16961,501,10), -- ITEM_ADDEFFECT_CHANCE: 25
(16961,950,6),  -- ITEM_ADDEFFECT_ELEMENT: 6
(16961,421,5),  -- Crit DMG +5%

-- Reaver Grip
(19046,5,10),  -- MP: 10
(19046,11,1),  -- AGI: 1
(19046,315,5), -- ENH_DRAIN_ASPIR: 5

-- Reaver Grip +1
(19047,5,12),  -- MP: 12
(19047,11,2),  -- AGI: 2
(19047,315,7), -- ENH_DRAIN_ASPIR: 7

-- Pachamac's Collar
(13172,1,2),   -- DEF: 2
(13172,71,1),  -- MPHEAL: 1
(13172,72,1),  -- HPHEAL: 1
(13172,860,1), -- CURE2MP_PERCENT: 1

-- Flagellant's Crossbow
(17234,17,3), -- WIND_RES: 3

-- Lightning Mantle
(13617,1,7),   -- DEF: 7
(13617,19,6),  -- THUNDER_RES: 6
(13617,471,5), -- Lightning Null: 15%

-- Sukesada
(16980,23,7),  -- ATT: 7
(16980,430,1), -- QUAD_ATTACK: 1

-- Shadow Mask
(13912,1,20),   -- DEF: 20
(13912,5,10),   -- MP: 10
(13912,8,2),    -- STR: 2
(13912,10,-2),  -- VIT: -2
(13912,21,-20), -- LIGHT_RES: -20
(13912,22,20),  -- DARK_RES: 20

-- Fowlers Mantle
(11535,1,7),   -- DEF: 7
(11535,11,2),  -- AGI: 2
(11535,24,12), -- RATT: 12
(11535,359,3), -- RAPID_SHOT +3

-- Fowlers Mantle +1
(11541,1,8),   -- DEF: 8
(11541,11,3),  -- AGI: 3
(11541,24,15), -- RATT: 15
(11541,359,5), -- RAPID_SHOT +5

-- Lyricists Gonnelle
(11533,14,3),  -- CHR: 3
(11533,23,6),  -- ATT: 6
(11533,119,2), -- SINGING: 2

-- Sinister Mask
(15219,1,12),  -- DEF: 12
(15219,8,2),   -- STR: 2
(15219,10,-2), -- VIT: -2
(15219,12,2),  -- INT: 2
(15219,13,-2), -- MND: -2
(15219,315,7), -- ENH_DRAIN_ASPIR: 7

-- Darksteel Codpiece
(15371,1,27),     -- DEF: 27
(15371,14,3),     -- CHR: 3
(15371,166,-2),   -- ENEMYCRITRATE: -2
(15371,161,-100), -- DMGPHYS: -100

-- Acid Bolt
(18148,431,2),   -- ITEM_ADDEFFECT_TYPE: 2
(18148,499,18),  -- ITEM_SUBEFFECT: 18
(18148,501,35),  -- ITEM_ADDEFFECT_CHANCE: 35
(18148,951,149), -- ITEM_ADDEFFECT_STATUS: 149
(18148,952,12),  -- ITEM_ADDEFFECT_POWER: 12
(18148,953,60),  -- ITEM_ADDEFFECT_DURATION: 60

-- Metasoma Katars
(18784,23,12),   -- ATT: 12
(18784,431,20),  -- ITEM_ADDEFFECT_TYPE: 20
(18784,499,18),  -- ITEM_SUBEFFECT: 18
(18784,951,0),   -- ITEM_ADDEFFECT_STATUS: 0
(18784,501,15),  -- ITEM_ADDEFFECT_CHANCE: 15
(18784,952,0),   -- ITEM_ADDEFFECT_POWER: 0
(18784,953,60),  -- ITEM_ADDEFFECT_DURATION: 60

-- Oneiros Cape
(10973,1,8),   -- DEF: 8
(10973,30,4),  -- MACC: 4
(10973,233,2), -- DRAGON_KILLER: 2

-- Oneiros Belt
(11773,1,10),  -- DEF: 10
(11773,2,50),  -- HP: 50
(11773,8,2),   -- STR: 2

-- Oneiros Cappa
(10972,1,10), -- DEF: 10
(10972,10,4), -- VIT: 4

-- Oneiros Sash
(11772,1,5),  -- DEF: 5
(11772,2,15), -- HP: 15
(11772,5,15), -- MP: 15
(11772,28,3), -- MATT: 3

-- Oneiros Lance
(19790,23,20), -- ATT: 20
(19790,27,8),  -- ENMITY: 8
(19790,165,4), -- CRITHITRATE: 4

-- Oneiros Cest
(11774,1,5),  -- DEF: 5
(11774,24,8), -- RATT: 8
(11774,73,3), -- STORETP: 3

-- Oneiros Helm
(11816,1,20),   -- DEF: 20
(11816,9,8),    -- DEX: 8
(11816,288,-3), -- DOUBLE_ATTACK: -3
(11816,302,-3), -- TRIPLE_ATTACK: -3
(11816,421,3),  -- CRIT_DMG_INCREASE: 3

-- Oneiros Ring
(11671,25,1), -- ACC: 1

-- Oneiros Earring
(11030,2,10),  -- HP: 10
(11030,375,4), -- CURE_POTENCY_RCVD: 4

-- Mujin Band
(11672,174,3), -- SKILLCHAINBONUS: 3
(11672,487,4), -- MAG_BURST_BONUS: 4

-- Oneiros Torque
(10932,68,4),     -- EVA: 4
(10932,161,-200), -- DMGPHYS: -200

-- Mujin Tanto
(19295,68,5),   -- EVA: 5
(19295,166,-3), -- ENEMYCRITRATE: -3
(19295,2031,3), -- ENEMYCRITDMG: 3
(19295,289,5),  -- SUBTLE_BLOW: 5

-- Mujin Necklace
(10933,8,4),   -- STR: 4
(10933,306,5), -- ZANSHIN: 5

-- Oneiros Headgear
(11818,1,19),  -- DEF: 19
(11818,5,60),  -- MP: 60
(11818,12,4),  -- INT: 4
(11818,28,6),  -- MATT: 6
(11818,30,-6), -- MACC: -6

-- Oneiros Rope
(11775,1,4),    -- DEF: 4
(11775,73,2),   -- STORETP: 2
(11775,902,30), -- OCCULT_ACUMEN: 30

-- Mujin Obi
(11776,1,4),  -- DEF: 4
(11776,5,55), -- MP: 55

-- Oneiros Harp
(17358,370,1), -- REGEN: 1
(17358,435,3), -- PAEON_EFFECT: 3

-- Oneiros Pebble
(19767,10,4), -- VIT: 4
(19767,25,2), -- ACC: 2

-- Oneiros Axe
(18519,73,-15),  -- STORETP: -15
(18519,77,-12), -- MOVE: -12

-- Oneiros Annulet
(11670,11,-6), -- AGI: -6
(11670,25,8),  -- ACC: 8

-- Oneiros Barbut
(11817,1,35),     -- DEF: 35
(11817,10,8),     -- VIT: 8
(11817,68,-14),   -- EVA: -14
(11817,161,-400), -- DMGPHYS: -400
(11817,77,-10),  -- MOVE: -10

-- Mujin Mantle
(10974,1,9),  -- DEF: 9
(10974,31,5), -- MEVA: 5
(10974,2032,1000), -- NINJUTSU_RECAST_DELAY: 1000 (1 Second)

-- Oneiros Tathlum
(19762,84,2),  -- AXE: 2
(19762,438,4), -- MADRIGAL_EFFECT: 4

-- Oneiros Pearl
(11031,24,2),  -- RATT: 2
(11031,27,-1), -- ENMITY: -1

-- Mujin Stud
(11032,29,1),  -- MDEF: 1
(11032,289,3), -- SUBTLE_BLOW: 3

-- Oneiros Knife
(19141,11,4),   -- AGI: 4
(19141,421,10), -- CRIT_DMG_INCREASE: 10

-- Oneiros Grip
(18811,370,1), -- REGEN: 1

-- Oneiros Coif
(11819,1,25),   -- DEF: 25
(11819,8,4),    -- STR: 4
(11819,24,10),  -- RATT: 10
(11819,365,-3), -- Snapshot -3
(11819,27,3),   -- ENMITY: 3

-- Ryuga Sune-Ate
(11456,1,19),    -- DEF: 19
(11456,10,4),    -- VIT: 4
(11456,25,4),    -- ACC: 4
(11456,384,300), -- HASTE_GEAR: 300

-- Khthonios Mask
(11820,1,24),    -- DEF: 24
(11820,7,25),    -- CONVHPTOMP: 25
(11820,23,9),    -- ATT: 9
(11820,73,3),    -- STORETP: 3
(11820,384,300), -- HASTE_GEAR: 300

-- Khthonios Gloves
(11918,1,18),  -- DEF: 18
(11918,11,8),  -- AGI: 8
(11918,24,5),  -- RATT: 5
(11918,27,-2), -- ENMITY: -2

-- Khthonios Helm
(11821,1,29),  -- DEF: 29
(11821,2,14),  -- HP: 14
(11821,8,4),   -- STR: 4
(11821,12,4),  -- INT: 4
(11821,116,9), -- DARK: 9

-- Avesta Bangles
(11919,30,3),   -- MACC: 3
(11919,114,8), -- ENFEEBLE: 8
(11919,115,8), -- ELEM: 8
(11919,116,8), -- DARK: 8

-- Oneiros Cluster
(19763,23,-7),   -- ATT: -7
(19763,384,100), -- HASTE_GEAR: 100

-- Demonry Sash
(11777,1,6),  -- DEF: 6
(11777,13,4), -- MND: 4
(11777,14,4), -- CHR: 4
(11777,30,4), -- MACC: 4

-- Demonry Core
(19764,9,3), -- DEX: 3

-- Demonry Ring
(11673,23,3),   -- ATT: 3
(11673,1039,3), -- TRIPLE_ATTACK_DMG: 3

-- Demonry Stone
(19765,5,20), -- MP: 20
(19765,29,2), -- MDEF: 2

-- Sagasinger
(17669,2,44),   -- HP: 45
(17669,5,44),   -- MP: 45
(17669,8,4),    -- STR: 4
(17669,10,4),   -- VIT: 4
(17669,431,10), -- ITEM_ADDEFFECT_TYPE: 10
(17669,499,18), -- ITEM_SUBEFFECT: 18
(17669,501,15), -- ITEM_ADDEFFECT_CHANCE: 15

-- Archon Cape
(10975,1,17),    -- DEF: 14
(10975,2034,12), -- SEVERE_PHYS_DMG_NULL: 12

-- Archon Ring
(11674,47,5),    -- DARKACC: 5
(11674,39,5),    -- DARKATT: 5
(11674,2033,12), -- SEVERE_MAGIC_DMG_NULL: 12

-- Mana Drinker (Formerly Talekeeper)
(18903,2,-50),   -- HP: -50
(18903,5,50),    -- MP: 50
(18903,8,0),     -- STR: 0
(18903,10,0),    -- VIT: 0
(18903,12,4),    -- INT: 4
(18903,13,4),    -- MND: 4
(10894,2038,25), -- ENH_ASPIR: 25
(18903,431,21),  -- ITEM_ADDEFFECT_TYPE: 21
(18903,499,8),   -- ITEM_SUBEFFECT: 8
(18903,500,0),   -- ITEM_ADDEFFECT_DMG: 0
(18903,501,50),  -- ITEM_ADDEFFECT_CHANCE: 50
(18903,950,7),   -- ITEM_ADDEFFECT_ELEMENT: 8

-- Moepapa Stone
(10817,1,5),     -- DEF: 5
(10817,14,3),    -- CHR: 3
(10817,384,300), -- HASTE_GEAR: 300

-- Moepapa Medal
(10943,9,3),   -- DEX: 3
(10943,11,3),  -- AGI: 3
(10943,17,5),  -- WIND_RES: 5
(10943,19,5),  -- THUNDER_RES: 5
(10943,421,1), -- CRIT_DMG_INCREASE: 1

-- Moepapa Mace
(17069,431,2),   -- ITEM_ADDEFFECT_TYPE: 2
(17069,499,12),  -- ITEM_SUBEFFECT: 12
(17069,501,10),  -- ITEM_ADDEFFECT_CHANCE: 15
(17069,951,155), -- ITEM_ADDEFFECT_STATUS: 155
(17069,953,12),  -- ITEM_ADDEFFECT_DURATION: 12

-- Moepapa Ring
(10754,11,3),  -- AGI: 3
(10754,85,2),  -- GAXE: 2
(10754,105,2), -- MARKSMAN: 2

-- Moepapa Annulet
(10755,14,3), -- CHR: 3
(10755,83,2), -- GSWORD: 2
(10755,89,2), -- GKATANA: 2

-- Moepapa Pendant
(10940,12,6),  -- INT: 6
(10940,27,-2), -- ENMITY: -2

-- Wit Pendant
(16300,12,4),   -- INT: 4
(16300,902,10), -- OCCULT_ACUMEN: 10

-- Tjukurrpa Mantle
(10984,1,9),  -- DEF: 9
(10984,11,4), -- AGI: 4
(10984,28,4), -- MATT: 4

-- Tjukurrpa Gauntlets
(11923,1,30),     -- DEF: 22
(11923,27,3),     -- ENMITY: 3
(11923,163,-400), -- DMGMAGIC: -400

-- Tjukurrpa Axe
(18541,384,200), -- HASTE_GEAR: 200

-- Tjukurrpa Medal
(10941,8,3),   -- STR: 3
(10941,10,3),  -- VIT: 3
(10941,15,5),  -- FIRE_RES: 5
(10941,18,5),  -- EARTH_RES: 5
(10941,291,2), -- COUNTER: 2

-- Tjukurrpa Belt
(10818,1,8),   -- DEF: 8
(10818,8,4),   -- STR: 4
(10818,288,3), -- DOUBLE_ATTACK: 3

-- Tjukurrpa Annulet
(10757,13,3), -- MND: 3
(10757,82,2), -- SWORD: 2
(10757,90,2), -- CLUB: 2

-- Tjukurrpa Ring
(10756,9,3),  -- DEX: 3
(10756,84,2), -- AXE: 2
(10756,88,2), -- KATANA: 2

-- Aifes Medal
(10942,12,3),  -- INT: 3
(10942,13,3),  -- MND: 3
(10942,16,5),  -- ICE_RES: 5
(10942,20,5),  -- WATER_RES: 5
(10942,311,1), -- MAGIC_DAMGE: 1

-- Aifes Mantle
(10983,1,10), -- DEF: 10
(10983,9,4),  -- DEX: 4
(10983,11,4), -- AGI: 4
(10983,25,5), -- ACC: 5

-- Aifes Bow
(19738,27,-4), -- ENMITY: -4
(19738,289,6), -- SUBTLE_BLOW: 6

-- Aifes Annulet
(10759,12,3), -- INT: 3
(10759,86,2), -- SCYTHE: 2
(10759,91,2), -- STAFF: 2

-- Aifes Ring
(10758,8,3),   -- STR: 3
(10758,81,2),  -- DAGGER: 2
(10758,104,2), -- ARCHERY: 2

-- Aifes Pumps
(11461,1,16),  -- DEF: 16
(11461,12,7),  -- INT: 7
(11461,27,-2), -- ENMITY: -2
(11461,30,-5), -- MACC: -5
(11461,296,5), -- CONSERVE_MP: 5

-- Portus Ring
(10760,10,3), -- VIT: 3
(10760,80,2), -- HTH: 2
(10760,87,2), -- POLEARM: 2

-- Portus Annulet
(10761,25,4),  -- ACC: 4
(10761,107,2), -- GUARD: 2
(10761,108,2), -- EVASION: 2
(10761,109,2), -- SHIELD: 2
(10761,110,2), -- PARRY: 2

-- Portus Collar
(10944,25,3),  -- ACC: 3
(10944,288,2), -- DOUBLE_ATTACK: 2

-- Alucinor Mitts
(11924,1,21),    -- DEF: 21
(11924,5,35),    -- MP: 35
(11924,9,4),     -- DEX: 4
(11924,22,25),   -- DARK_RES: 25
(11924,384,400), -- HASTE_GEAR: 400

-- Kraken Club
(17440,432,-8), -- ENSPELL_DMG: -8 343

-- Claustrum
(18330,25,20),   -- ACC: 20
(18330,256,12),  -- AFTERMATH: 12
(18330,355,185), -- ADDS_WEAPONSKILL: 185
(18330,431,10),  -- ITEM_ADDEFFECT_TYPE: 10
(18330,499,8),   -- ITEM_SUBEFFECT: 8
(18330,501,15),  -- ITEM_ADDEFFECT_CHANCE: 15
(18330,506,50),  -- EXTRA_DMG_CHANCE: 50
(18330,507,250), -- OCC_DO_EXTRA_DMG: 250
(18330,566,2),   -- IRIDESCENCE: 2
(18330,347,3),   -- FIRE_AFFINITY_DMG: 3
(18330,348,3),   -- ICE_AFFINITY_DMG: 3
(18330,349,3),   -- WIND_AFFINITY_DMG: 3
(18330,350,3),   -- EARTH_AFFINITY_DMG: 3
(18330,351,3),   -- THUNDER_AFFINITY_DMG: 3
(18330,352,3),   -- WATER_AFFINITY_DMG: 3
(18330,353,3),   -- LIGHT_AFFINITY_DMG: 3
(18330,354,3),   -- DARK_AFFINITY_DMG: 3
(18330,544,3),   -- FIRE_AFFINITY_ACC: 3
(18330,545,3),   -- ICE_AFFINITY_ACC: 3
(18330,546,3),   -- WIND_AFFINITY_ACC: 3
(18330,547,3),   -- EARTH_AFFINITY_ACC: 3
(18330,548,3),   -- THUNDER_AFFINITY_ACC: 3
(18330,549,3),   -- WATER_AFFINITY_ACC: 3
(18330,550,3),   -- LIGHT_AFFINITY_ACC: 3
(18330,551,3),   -- DARK_AFFINITY_ACC: 3
(18330,553,3),   -- FIRE_AFFINITY_PERP: 3
(18330,554,3),   -- ICE_AFFINITY_PERP: 3
(18330,555,3),   -- WIND_AFFINITY_PERP: 3
(18330,556,3),   -- EARTH_AFFINITY_PERP: 3
(18330,557,3),   -- THUNDER_AFFINITY_PERP: 3
(18330,558,3),   -- WATER_AFFINITY_PERP: 3
(18330,559,3),   -- LIGHT_AFFINITY_PERP: 3
(18330,560,3);   -- DARK_AFFINITY_PERP: 3

REPLACE INTO `item_mods_pet` (`itemId`, `modId`, `value`, `petType`) VALUES

-- Barbaroi Axe
(16680,25,2,0), -- ACC +2
(16680,23,3,0), -- ATT +3

-- Peregrine
(16887,2,15,2), -- HP +15
(16887,25,1,2), -- ACC +1
(16887,23,3,2), -- ATT +3

-- Kukulcan's Staff
(17532,25,3,1),  -- ACC +2
(17532,384,3,1), -- Haste +2%

-- Oneiros Cappa
(10972,161,-200,0), -- All Pets - DMGPHYS: -200 (2%)

-- Mujin Obi
(11776,23,8,1),  -- Avatar - ATT: 8

-- Demonry Core
(19764,25,3,0), -- Pets: Acc +3

-- Moepapa Stone
(10817,384,400,0); -- All Pets - HASTE_GEAR: 400

REPLACE INTO `item_weapon` (`itemId`, `name`, `skill`, `subskill`, `ilvl_skill`, `ilvl_parry`, `ilvl_macc`, `dmgType`, `hit`, `delay`, `dmg`, `unlock_points`) VALUES

(18784,'metasoma_katars',1,0,0,0,0,4,1,564,17,0),
(17188,'sniping_bow',25,0,0,0,0,1,1,540,56,0),
(19790,'oneiros_lance',8,0,0,0,0,1,1,492,99,0),
(19295,'mujin_tanto',9,0,0,0,0,2,1,222,40,0),
(18519,'oneiros_axe',6,0,0,0,0,2,1,589,110,0),
(17069,'moepapa_mace',11,0,0,0,0,3,1,300,48,0),
(18541,'tjukurrpa_axe',5,0,0,0,0,2,1,288,47,0),
(19738,'aifes_bow',25,0,0,0,0,1,1,540,84,0),
(18903,'talekeeper',3,0,0,0,0,1,1,224,40,0),
(17669,'sagasinger',3,0,0,0,0,1,1,218,42,0),
(19141,'oneiros_knife',2,0,0,0,0,1,1,150,27,0),
(17207,'expunger',25,0,0,0,0,1,1,500,50,500);

REPLACE INTO `item_latents` (`itemId`, `modId`, `value`, `latentId`, `latentParam`) VALUES
-- Cocoon Band
(11823,1,45,13,13), -- Slow: DEF +45

-- Murasame
(16961,165,5,52,6), -- Rain Weather: Crit rate +5%

-- Gae Bolg
(16885,421,10,52,6), -- Rain Weather: Crit DMG +10%

-- Flagellant's Crossbow
(13248,365,10,13,4), -- Paralysis: Snapshot +10

-- Living Rod
(16885,370,2,52,6), -- Rain Weather: Regen +2

-- Lohar
(17927,129,1,40,0), -- MAINHAND: Smithing +1

-- Sunlight Pole
(17529,370,5,52,1), -- Rain Weather: Regen +5

-- Bond Cape
(11576,30,1,16,3), -- MACC +1~4,party size 3+. Effect strengthens with more members
(11576,30,1,16,4), -- MACC +1~4,party size 3+. Effect strengthens with more members
(11576,30,1,16,5), -- MACC +1~4,party size 3+. Effect strengthens with more members
(11576,30,1,16,6), -- MACC +1~4,party size 3+. Effect strengthens with more members

-- Oneiros Ring
(11671,302,2,55,100),  -- Triple Attack +2% when mp is greater than or equal to 100

-- Oneiros Grip
(18811,369,1,4,750),  -- Refresh MP <= 75%

-- Archon Cape
(10975,23,10,52,8), -- DARK WEATHER:ATT
(10975,25,10,52,8), -- DARK WEATHER:ACC

-- Sprout Beret

(15198,64,7,50,31),      -- Sprout Beret Combat Skill Gain +7 under 31
(15198,65,7,50,31),      -- Sprout Beret Magic Skill Gain +7 under 31
(15198,76,7,50,31),      -- Sprout Beret MovementSpeed +7 under 31
(15198,382,100,50,31),   -- Sprout Beret EXP + 100% under 31

-- Sacrifice Torque

(15528,404,8,21,21),   -- -8HP/Tic
(15528,369,-3,21,21),  -- -3MP/Tic
(15528,2021,10,21,21), -- Avatar: +3 ATT is hot garbage for the cost,bumping it up to 10.

-- Fidelity Earring
(16022,2022,10,22,9),  -- PetACC+10 if BST in party

-- Affinity Earring
(16031,2021,10,22,18), -- PetATT+10 if PUP is in party

-- Lyft Scimitar Buff
(17766,27,1,16,3), -- Enmity +1~4
(17766,27,1,16,4),
(17766,27,1,16,5),
(17766,27,1,16,6),

-- Lyft Sainti Buff
(18771,25,2,16,3),
(18771,25,2,16,4),
(18771,25,2,16,5),
(18771,25,2,16,6),

-- Lyft Ferule Buff
(18872,73,2,16,3),
(18872,73,2,16,4),
(18872,73,2,16,5),
(18872,73,2,16,6),

-- Lyft Scythe Buff
(18958,23,2,16,3),
(18958,23,2,16,4),
(18958,23,2,16,5),
(18958,23,2,16,6),

-- Lyft Claymore Buff
(19161,24,1,16,3),
(19161,24,1,16,4),
(19161,24,1,16,5),
(19161,24,1,16,6),

-- Shigeto Bow
(18142,26,7,8,12), -- RACC +7 for Samurai Sub job

-- Shigeto Bow +1
(18143,26,8,8,12), -- RACC +8 for Samurai Sub job

-- Ritter Shield
(12309,1,2,62,12), -- DEF +2 for PLD Main job
(12309,1,2,8,12), -- DEF +2 for PLD Sub job

-- Ritter Shield +1
(12358,1,2,62,12), -- DEF +2 for PLD Main job
(12358,1,2,8,12), -- DEF +2 for PLD Sub job

-- Expunger
(17207,287,25,47,0),   -- Expunger DMG+25 when broken (500 WS points)
(17207,165,2,47,0),    -- Expunger Crit Rate +2% when broken (500 WS points)
(17207,964,10,47,0);   -- Expunger RANGED_CRIT_DMG_INCREASE + 10 when broken (500 WS points)

UNLOCK TABLES;
