-----------------------------------------------------------------
-- File     :  /cdimage/units/UAL0401/UAL0401_script.lua
-- Author(s):  John Comes, Gordon Duclos
-- Summary  :  Aeon Galactic Colossus Script
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local MobileUnit = import('/lua/defaultunits.lua').MobileUnit
local TDFHeavyPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFHeavyPlasmaGatlingCannonWeapon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local utilities = import('/lua/utilities.lua')
local explosion = import('/lua/defaultexplosions.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

MK73 = Class(TWalkingLandUnit) {

    Weapons = {
        RocketBackpack = Class(import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02) {},
        MainGun = Class(import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02) 
        {
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects(self.unit, 'Turret_Barrel_Spinner', self.unit.Army, Effects.WeaponSteam01)
                TDFHeavyPlasmaCannonWeapon.PlayFxWeaponPackSequence(self)
            end,

            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Turret_Barrel_Spinner', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
                TDFHeavyPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,

            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects(self.unit, 'Turret_Barrel_Spinner', self.unit.Army, Effects.WeaponSteam01)
                TDFHeavyPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,    
        },
        MissileRack01 = Class(TSAMLauncher) {},
        MissileRack02 = Class(TSAMLauncher) {},
    },

    DeathThread = function(self, overkillRatio , instigator)
        self:PlayUnitSound('Destroyed')
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_01', 12.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_03', 12.0)
        explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
        WaitSeconds(2)
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_03_03', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Torso', 4.0)
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_02_02', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Torso', 4.0)
        WaitSeconds(0.1)
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_04_02', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Torso', 4.0)
        WaitSeconds(0.3)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_02_02', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_03_03', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Torso', 4.0)
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)

        WaitSeconds(1.5)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_02_02', 3.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_01', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_03_03', 5.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_02', 6.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_02', 15.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_01', 15.0)

        if self.DeathAnimManip then
            WaitFor(self.DeathAnimManip)
        end

        local bp = self:GetBlueprint()
        local position = self:GetPosition()
        local qx, qy, qz, qw = unpack(self:GetOrientation())
        local a = math.atan2(2.0 * (qx * qz + qw * qy), qw * qw + qx * qx - qz * qz - qy * qy)
        for i, numWeapons in bp.Weapon do
            if bp.Weapon[i].Label == 'CollossusDeath' then
                position[3] = position[3]+5*math.cos(a)
                position[1] = position[1]+5*math.sin(a)
                DamageArea(self, position, bp.Weapon[i].DamageRadius, bp.Weapon[i].Damage, bp.Weapon[i].DamageType, bp.Weapon[i].DamageFriendly)
                break
            end
        end

        self:DestroyAllDamageEffects()
        self:CreateWreckage(overkillRatio)

        -- CURRENTLY DISABLED UNTIL DESTRUCTION
        -- Create destruction debris out of the mesh, currently these projectiles look like crap,
        -- since projectile rotation and terrain collision doesn't work that great. These are left in
        -- hopes that this will look better in the future.. =)
        if self.ShowUnitDestructionDebris and overkillRatio then
            if overkillRatio <= 1 then
                self.CreateUnitDestructionDebris(self, true, true, false)
            elseif overkillRatio <= 2 then
                self.CreateUnitDestructionDebris(self, true, true, false)
            elseif overkillRatio <= 3 then
                self.CreateUnitDestructionDebris(self, true, true, true)
                self.CreateUnitDestructionDebris(self, true, true, true)
            else -- Vaporized
                self.CreateUnitDestructionDebris(self, true, true, true)
            end
        end

        self:Destroy()
    end,
}

TypeClass = MK73
