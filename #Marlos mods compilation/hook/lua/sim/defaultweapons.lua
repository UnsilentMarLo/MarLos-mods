do
DefaultBeamWeapon = Class(DefaultProjectileWeapon) {
    BeamType = CollisionBeam,

    OnCreate = function(self)
        self.Beams = {}

        -- Ensure that the weapon blueprint is set up properly for beams
        local bp = self:GetBlueprint()
        if not bp.BeamCollisionDelay then
            local strg = '*ERROR: No BeamCollisionDelay specified for beam weapon, aborting setup.  Weapon: ' .. bp.DisplayName .. ' on Unit: ' .. self.unit:GetUnitId()
            error(strg, 2)
            return
        end
        if not bp.BeamLifetime then
            local strg = '*ERROR: No BeamLifetime specified for beam weapon, aborting setup.  Weapon: ' .. bp.DisplayName .. ' on Unit: ' .. self.unit:GetUnitId()
            error(strg, 2)
            return
        end

        -- Create the beam
        for rk, rv in bp.RackBones do
            for mk, mv in rv.MuzzleBones do
                local beam
                beam = self.BeamType{
                    Weapon = self,
                    BeamBone = 0,
                    OtherBone = mv,
                    CollisionCheckInterval = bp.BeamCollisionDelay * 10,    -- Why is this multiplied by 10? IceDreamer
                }
                local beamTable = {Beam = beam, Muzzle = mv, Destroyables = {}}
                table.insert(self.Beams, beamTable)
                self.unit.Trash:Add(beam)
                beam:SetParentWeapon(self)
                beam:Disable()
            end
        end

        DefaultProjectileWeapon.OnCreate(self)
    end,

    -- This entirely overrides the default
    CreateProjectileAtMuzzle = function(self, muzzle)
        local enabled = false
        for k, v in self.Beams do
            if v.Muzzle == muzzle and v.Beam:IsEnabled() then
                enabled = true
            end
        end
        if not enabled then
            self:PlayFxBeamStart(muzzle)
        end

        local bp = self:GetBlueprint()
        if self.unit:GetCurrentLayer() == 'Water' and bp.Audio.FireUnderWater then
            self:PlaySound(bp.Audio.FireUnderWater)
        elseif bp.Audio.Fire then
            self:PlaySound(bp.Audio.Fire)
        end
    end,

    PlayFxBeamStart = function(self, muzzle)
        local army = self.unit:GetArmy()
        local bp = self:GetBlueprint()
        local beam
        local beamTable
        self.BeamDestroyables = {}

        for k, v in self.Beams do
            if v.Muzzle == muzzle then
                beam = v.Beam
                beamTable = v
            end
        end
        if not beam then
            error('*ERROR: We have a beam created that does not coincide with a muzzle bone.  Internal Error, aborting beam weapon.', 2)
            return
        end

        if beam:IsEnabled() then return end
        beam:Enable()
        self.unit.Trash:Add(beam)

        -- Deal with continuous and non-continuous beams
        if bp.BeamLifetime > 0 then
            self:ForkThread(self.BeamLifetimeThread, beam, bp.BeamLifetime or 1)    -- Non-continuous only
        end
        if bp.BeamLifetime == 0 then
            self.HoldFireThread = self:ForkThread(self.WatchForHoldFire, beam)      -- Continuous only
        end

        -- Deal with beam audio cues
        if bp.Audio.BeamStart then
            self:PlaySound(bp.Audio.BeamStart)
        end
        if bp.Audio.BeamLoop and self.Beams[1].Beam then
            self.Beams[1].Beam:SetAmbientSound(bp.Audio.BeamLoop, nil)
        end
        self.BeamStarted = true
    end,

    -- Kill the beam if hold fire is requested
    WatchForHoldFire = function(self, beam)
        while true do
            WaitSeconds(1)
            --if we're at hold fire, stop beam
            if self.unit and (self.unit:GetFireState() == 1 or self.NumTargets == 0) then
                self.BeamStarted = false
                self:PlayFxBeamEnd(beam)
            end
        end
    end,

    -- Force the beam to last the proper amount of time
    BeamLifetimeThread = function(self, beam, lifeTime)
        WaitSeconds(lifeTime)
        WaitTicks(1)
        self:PlayFxBeamEnd(beam)
    end,

    PlayFxWeaponUnpackSequence = function(self)
        local bp = self:GetBlueprint()
        -- If it's not a continuous beam, or  if it's a continuous beam that's off
        if bp.BeamLifetime > 0 or (bp.BeamLifetime == 0 and not self.ContBeamOn) then
            DefaultProjectileWeapon.PlayFxWeaponUnpackSequence(self)
        end
    end,


    -- Kill the beam
    PlayFxBeamEnd = function(self, beam)
        if not self.unit.Dead then
            local bp = self:GetBlueprint()
            if bp.Audio.BeamStop and self.BeamStarted then
                self:PlaySound(bp.Audio.BeamStop)
            end
            if bp.Audio.BeamLoop and self.Beams[1].Beam then
                self.Beams[1].Beam:SetAmbientSound(nil, nil)
            end
            if beam then
                beam:Disable()
            else
                for k, v in self.Beams do
                    v.Beam:Disable()
                end
            end
            self.BeamStarted = false
        end
        if self.HoldFireThread then
            KillThread(self.HoldFireThread)
        end
    end,

    StartEconomyDrain = function(self)
        local bp = self:GetBlueprint()
        if not self.EconDrain and bp.EnergyRequired and bp.EnergyDrainPerSecond then
            if not self:EconomySupportsBeam() then
                return
            end
        end
        DefaultProjectileWeapon.StartEconomyDrain(self)
    end,

    OnHaltFire = function(self)
        for k,v in self.Beams do
            -- Only halt fire on the beams that are currently enabled
            if not v.Beam:IsEnabled() then
                continue
            end
            self:PlayFxBeamEnd(v.Beam)
        end
    end,

    -- Weapon States Section

    IdleState = State (DefaultProjectileWeapon.IdleState) {
        Main = function(self)
            DefaultProjectileWeapon.IdleState.Main(self)
            self:PlayFxBeamEnd()
            self:ForkThread(self.ContinuousBeamFlagThread)
        end,
    },

    WeaponPackingState = State (DefaultProjectileWeapon.WeaponPackingState) {
        Main = function(self)
            local bp = self:GetBlueprint()
            if bp.BeamLifetime > 0 then
                self:PlayFxBeamEnd()
            else
                self.ContBeamOn = true
            end
            DefaultProjectileWeapon.WeaponPackingState.Main(self)
        end,
    },

    ContinuousBeamFlagThread = function(self)
        WaitTicks(1)
        self.ContBeamOn = false
    end,

    RackSalvoFireReadyState = State (DefaultProjectileWeapon.RackSalvoFireReadyState) {
        Main = function(self)
            if not self:EconomySupportsBeam() then
                self:PlayFxBeamEnd()
                ChangeState(self, self.IdleState)
                return
            end
            DefaultProjectileWeapon.RackSalvoFireReadyState.Main(self)
        end,
    },

    EconomySupportsBeam = function(self)
        local aiBrain = self.unit:GetAIBrain()
        local energyIncome = aiBrain:GetEconomyIncome('ENERGY') * 10
        local energyStored = aiBrain:GetEconomyStored('ENERGY')
        local nrgReq = self:GetWeaponEnergyRequired()
        local nrgDrain = self:GetWeaponEnergyDrain()

        if energyStored < nrgReq and energyIncome < nrgDrain then
            return false
        end
        return true
    end,
}
end