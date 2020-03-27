
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TAALinkedRailgun = WeaponsFile.TAALinkedRailgun
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon
local TDFGaussCannonWeapon = WeaponsFile.TDFShipGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

Mk56 = Class(TSeaUnit) {


    Weapons = {
        RightAAGun01 = Class(TAALinkedRailgun) {},
        RightAAGun02 = Class(TAALinkedRailgun) {},
        AAGun = Class(TAALinkedRailgun) {},
        AAGun2 = Class(TAAFlakArtilleryCannon) {
            PlayOnlyOneSoundCue = true,
        },
        FrontTurret01 = Class(TDFGaussCannonWeapon) {},
        FrontTurret02 = Class(TDFGaussCannonWeapon) {},
        BackTurret = Class(TDFGaussCannonWeapon) {},
		},
		
    EffectsBones = {
        'Exhaust_1',
        'Exhaust_2',
        'Exhaust_3',
        'Exhaust_4',
        'Exhaust_5',
        'Exhaust_6',
        'Exhaust_7',
    },
	
    AirEffects = {'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp',},
	
  --  OnMotionHorzEventChange
	OnStopBeingBuilt = function(self,builder,layer)
		local army = self:GetArmy()
		CreateAttachedEmitter(self,'Exhaust_1',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_2',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_3',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_4',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_5',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_6',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_7',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		TSeaUnit.OnStopBeingBuilt(self, builder, layer)
    end,
}

TypeClass = Mk56