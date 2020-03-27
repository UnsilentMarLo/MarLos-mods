#****************************************************************************
#**
#**  File     :  /cdimage/units/UES0202/UES0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Cruiser Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponFile.TDFGaussCannonWeapon
local TANTorpedoAngler = import('/lua/terranweapons.lua').TANTorpedoAngler
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon
local TIFCruiseMissileLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileLauncher
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

UES0202 = Class(TSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        FrontTurret = Class(TDFGaussCannonWeapon) {},
        LeftTurret01 = Class(TDFGaussCannonWeapon) {},
        LeftTurret02 = Class(TAAFlakArtilleryCannon) {},
        BackTurret = Class(TDFGaussCannonWeapon) {},
        RightTurret01 = Class(TDFGaussCannonWeapon) {},
        RightTurret02 = Class(TAAFlakArtilleryCannon) {},
        CruiseMissile = Class(TIFCruiseMissileLauncher) {
            FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchBuilding,
        },
        MissileRack01 = Class(TSAMLauncher) {},
        MissileRack02 = Class(TSAMLauncher) {},
        MissileRack03 = Class(TSAMLauncher) {},
        MissileRack04 = Class(TSAMLauncher) {},
        MissileRack05 = Class(TSAMLauncher) {},
	},
}

TypeClass = UES0202
