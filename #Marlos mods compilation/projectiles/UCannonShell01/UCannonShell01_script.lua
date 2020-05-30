local TDFGaussCannonProjectile = import('/Mods/#Marlos mods compilation/lua/MKProjectiles.lua').TDFGaussCannonProjectile
UCannonShell03 = Class(TDFGaussCannonProjectile) {
    
    OnCreate = function(self, inWater)
        TDFGaussCannonProjectile.OnCreate(self, inWater)
        if not inWater then
            self:SetDestroyOnWater(true)
        else
            self:ForkThread(self.DestroyOnWaterThread)
        end
    end,
    
    DestroyOnWaterThread = function(self)
        WaitSeconds(0.2)
        self:SetDestroyOnWater(true)
    end,
}
TypeClass = UCannonShell03

