#****************************************************************************
#**
#**  File     :  /data/lua/EffectTemplates.lua
#**  Author(s):  Gordon Duclos, Greg Kohne, Matt Vainio, Aaron Lundquist
#**
#**  Summary  :  Generic templates for commonly used effects
#**
#**  Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
TableCat = import('/lua/utilities.lua').TableCat
EmtBpPath = '/Mods/#Marlos mods compilation/effects/emitters/'
EmitterTempEmtBpPath = '/Mods/#Marlos mods compilation/effects/emitters/temp/'

AColossusLaserImpact01 = {
    EmtBpPath .. 'phason_laser_end_01_emit.bp',
    EmtBpPath .. 'phason_laser_end_02_emit.bp', 
    EmtBpPath .. 'Nuclear_Laser_ring_02_emit.bp',	##	ring11   
}

AColossusLaserMuzzle01 = {
    EmtBpPath .. 'phason_laser_muzzle_01_emit.bp',
    EmtBpPath .. 'phason_laser_muzzle_02_emit.bp',
    EmtBpPath .. 'microwave_laser_charge_02_emit.bp',    
}

MARVArtilleryWeaponFX = {
    EmtBpPath .. 'MARV_artillery_muzzle_01_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_02_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_03_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_04_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_05_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_06_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_08_emit.bp',
}

DefaultProjectileWaterImpact = {
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_ripples_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_plume_01_emit.bp',
}

TAntiNuclearshellHit01 = {
    EmtBpPath .. 'Nuclear_shell_hit_01_emit.bp',	##	glow	
    EmtBpPath .. 'Nuclear_shell_hit_02_emit.bp',	##	flash	     
    EmtBpPath .. 'Nuclear_shell_hit_03_emit.bp', 	##	sparks
    EmtBpPath .. 'Nuclear_shell_hit_04_emit.bp',	##	plume fire
    EmtBpPath .. 'Nuclear_shell_hit_05_emit.bp',	##	plume dark 
    EmtBpPath .. 'Nuclear_shell_hit_06_emit.bp',	##	base fire
    EmtBpPath .. 'Nuclear_shell_hit_07_emit.bp',	##	base dark 
    EmtBpPath .. 'Nuclear_shell_hit_08_emit.bp',	##	plume smoke
    EmtBpPath .. 'Nuclear_shell_hit_09_emit.bp',	##	base smoke
    EmtBpPath .. 'Nuclear_shell_hit_10_emit.bp',	##	plume highlights
    EmtBpPath .. 'Nuclear_shell_hit_11_emit.bp',	##	base highlights
    EmtBpPath .. 'Nuclear_shell_ring_01_emit.bp',	##	ring14
    EmtBpPath .. 'Nuclear_shell_ring_02_emit.bp',	##	ring11	         
}

#------------------------------------------------------------------------
#  TERRAN HEAVY FRAGMENTATION GRENADE EMITTERS MK
#------------------------------------------------------------------------
THeavyFragmentationGrenadeHitMK = {
    EmtBpPath .. 'terran_fragmentation_grenade_hit_MK_01_emit.bp',
    EmtBpPath .. 'terran_fragmentation_grenade_hit_MK_02_emit.bp',
    EmtBpPath .. 'terran_fragmentation_grenade_hit_MK_03_emit.bp',
    EmtBpPath .. 'terran_fragmentation_grenade_hit_MK_04_emit.bp',
    EmtBpPath .. 'terran_fragmentation_grenade_hit_MK_05_emit.bp',
    EmtBpPath .. 'terran_fragmentation_grenade_hit_MK_06_emit.bp',
    EmtBpPath .. 'terran_fragmentation_grenade_hit_MK_07_emit.bp',
    EmtBpPath .. 'terran_fragmentation_grenade_hit_MK_08_emit.bp',
}