#****************************************************************************
#**
#**  File     :  /lua/cybranweapons.lua
#**  Author(s):  David Tomandl, John Comes, Gordon Duclos
#**
#**  Summary  :  Cybran weapon definitions
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local KamikazeWeapon = WeaponFile.KamikazeWeapon
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local OverchargeWeapon = WeaponFile.OverchargeWeapon

local CollisionBeamFile = import('/lua/defaultcollisionbeams.lua')
local Explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate2 = import('/Mods/#Marlos mods compilation/lua/MKEffectTemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Util = import('/lua/utilities.lua')

local MKCollisionBeamFile = import('/Mods/#Marlos mods compilation/lua/MKDefaultCollisionBeams.lua')
local DreadnoughtLaserCollisionBeam = MKCollisionBeamFile.DreadnoughtLaserCollisionBeam

MARVArtilleryWeapon = Class(DefaultProjectileWeapon) {
	FxMuzzleFlash = EffectTemplate2.MARVArtilleryWeaponFX
}

DreadnoughtLaser = Class(DefaultBeamWeapon) {
    BeamType = MKCollisionBeamFile.DreadnoughtLaserCollisionBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 0.0025,

    PlayFxWeaponUnpackSequence = function(self)
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                    CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale):ScaleEmitter(0.0025)

                end
				
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
        end
    end,
}