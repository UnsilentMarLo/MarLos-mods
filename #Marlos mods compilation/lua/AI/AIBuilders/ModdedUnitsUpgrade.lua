
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'ModdedUnitsUpgrade',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'MSE UnitUpgrade1',
        PlatoonTemplate = 'T1TankUpgrade',
        Priority = 700,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 10, categories.MODDEDUPGRADEUNIT * categories.TECH1 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 30, categories.MODDEDUPGRADEUNIT2 * categories.TECH2 } },
            { EBC, 'GreaterThanEconIncome', { 12, 300 } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}