-----------------------------------
-- (Harvesting) Pashhow Marshlands
-----------------------------------


local customHelm = require('modules/custom/custom_helm/custom_helm')
-----------------------------------
local m = Module:new('harvesting_pashhow')

xi.helm.helmInfo[xi.helmType.HARVESTING].zone[xi.zone.PASHHOW_MARSHLANDS] =
{
    dynamic = true,

    drops =
    {
        { customHelm.rate.VERY_COMMON, xi.item.INSECT_WING,             'an insect wing'            }, -- Insect Wing    (24%)
        { customHelm.rate.COMMON,      xi.item.FLAX_FLOWER,             'a flax flower'             }, -- Flax Flower    (15%)
        { customHelm.rate.COMMON,      xi.item.TREANT_BULB,             'a treant bulb'             }, -- Treant Bulb    (15%)
        { customHelm.rate.COMMON,      xi.item.PIECE_OF_CRAWLER_COCOON, 'a piece of crawler cocoon' }, -- Crawler Cocoon (15%)
        { customHelm.rate.UNCOMMON,    xi.item.DAHLIA,                  'a dahlia'                  }, -- Dahlia         (10%)
        { customHelm.rate.UNCOMMON,    xi.item.WIJNRUIT,                'a wijnruit'                }, -- Wijnruit       (10%)
        { customHelm.rate.UNCOMMON,    xi.item.CLUMP_OF_BOYAHDA_MOSS,   'a clump of boyahda moss'   }, -- Boyahda Moss   (10%)
        { customHelm.rate.RARE,        xi.item.RAIN_LILY,               'a rain lily'               }, -- Rain Lily      ( 5%)
        { customHelm.rate.RARE,        xi.item.JUG_OF_HUMUS,            'a jug of humus'            }, -- Humus          ( 5%)
        { customHelm.rate.RARE,        xi.item.BAG_OF_TREE_CUTTINGS,    'a bag of tree cuttings'    }, -- Tree Cuttings  ( 5%)
        { customHelm.rate.VERY_RARE,   xi.item.COPPER_FROG,             'a copper frog'             }, -- Copper Frog    ( 1%)
        { customHelm.rate.VERY_RARE,   xi.item.BAG_OF_GRAIN_SEEDS,      'a bag of grain seeds'      }, -- Grain Seeds    ( 1%)
    },

    points =
    {
        { -454.526, 24.339, -227.249 },
        { -401.531, 24.650, -236.616 },
        { -266.914, 24.553, -300.710 },
        { -255.112, 24.401, -331.030 },
        { -267.100, 24.485, -282.657 },

        { -255.182, 24.713, -275.340 },
        { -243.948, 24.263, -249.366 },
        {  333.984, 24.960,    9.257 },
        {  306.661, 24.825,    2.015 },
        {  314.159, 24.563,    5.324 },

        {  291.451, 24.789,    1.971 },
        {  278.543, 24.641,  -16.140 },
        {  271.670, 24.795,    4.534 },
        {  246.478, 24.557,  -30.692 },
        {  275.806, 24.650,  -37.597 },
    }
}

m:addOverride('xi.zones.Pashhow_Marshlands.Zone.onInitialize', function(zone)
    super(zone)
    xi.helm.initZone(zone, xi.helmType.HARVESTING)
end)

m:addOverride('xi.zones.Pashhow_Marshlands.Zone.onZoneWeatherChange', function(weatherType)
    super(weatherType)

    local drops = xi.helm.helmInfo[xi.helmType.HARVESTING].zone[xi.zone.PASHHOW_MARSHLANDS].drops

    -- loop through table and delete all matches
    for k, item in pairs(drops) do
        if
            item[2] == xi.item.RUSTY_PICK or
            item[2] == xi.item.BROKEN_HALCYON_FISHING_ROD or
            item[2] == xi.item.BROKEN_HUME_FISHING_ROD
        then
            table.remove(drops, k)
        end
    end

    -- if raining, add it back in
    if weatherType == xi.weather.RAIN or weatherType == xi.weather.SQUALL then
        table.insert(drops, { customHelm.rate.RARE,      xi.item.RUSTY_PICK,                 'a rusty pick'                 }) ---Rusty Pick         (5%)
        table.insert(drops, { customHelm.rate.VERY_RARE, xi.item.BROKEN_HALCYON_FISHING_ROD, 'a broken halcyon fishing rod' }) -- Broken Halcyon Rod (1%)
        table.insert(drops, { customHelm.rate.VERY_RARE, xi.item.BROKEN_HUME_FISHING_ROD, 'a broken halcyon fishing rod'    }) -- Broken Halcyon Rod (1%)
    end
end)


m:addOverride('xi.zones.Pashhow_Marshlands.Zone.onGameDay', function()
    super()

    local drops = xi.helm.helmInfo[xi.helmType.HARVESTING].zone[xi.zone.PASHHOW_MARSHLANDS].drops

    -- loop through table and delete all matches
    for k, item in pairs(drops) do
        if
            item[2] == xi.item.WATER_CLUSTER or
            item[2] == xi.item.AQUAMARINE
        then
            table.remove(drops, k)
        end
    end

    -- Only available on Watersday
    if VanadielDayOfTheWeek() == xi.day.WATERSDAY then
        table.insert(drops, { customHelm.rate.RARE, xi.item.WATER_CLUSTER, 'a water cluster' }) -- Water Cluster (5%)
    end

    -- Only available on New Moon
    if IsMoonNew() then
        table.insert(drops, { customHelm.rate.SUPER_RARE, xi.item.AQUAMARINE, 'an aquamarine' }) -- Aquamarine (0.5%)
    end
end)

return m
