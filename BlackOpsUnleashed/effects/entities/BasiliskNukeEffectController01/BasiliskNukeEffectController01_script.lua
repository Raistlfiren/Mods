--------------------------------------------------------------------------------------------------------------
-- File     :  \data\effects\Entities\CybranNukeEffectController0101\CybranNukeEffectController0101_script.lua
-- Author(s):  Greg Kohne
-- Summary  :  Ohwalli Bomb effect controller script, non-damaging
-- Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------------------------------------

local NullShell = import('/lua/sim/defaultprojectiles.lua').NullShell
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
local RandomInt = import('/lua/utilities.lua').GetRandomInt
local EffectTemplate = import('/lua/EffectTemplates.lua')
local BlackOpsEffectTemplate = import('/mods/BlackOpsUnleashed/lua/BlackOpsEffectTemplates.lua')
local Util = import('/lua/utilities.lua')
local BasiliskNukeEffect04 = '/projectiles/MGQAIPlasmaArty01/MGQAIPlasmaArty01_proj.bp' 
local BasiliskNukeEffect05 = '/effects/Entities/BasiliskNukeEffect05/CybranNukeEffect05_proj.bp'

BasiliskNukeEffectController01 = Class(NullShell) {
    PassData = function(self, Data)  
        self:CreateNuclearExplosion()
    end,

    CreateNuclearExplosion = function(self)
        local bp = self:GetBlueprint()
        local army = self:GetArmy()
        
        CreateLightParticle(self, -1, self:GetArmy(), 50, 100, 'beam_white_01', 'ramp_blue_16')
        self:ShakeCamera(75, 3, 0, 10)
        self:ForkThread(self.EffectThread)
        self:ForkThread(self.CreateEffectInnerPlasma)
    end,    
    
    OuterRingDamage = function(self)
        local myPos = self:GetPosition()
        if self.NukeOuterRingTotalTime == 0 then
            DamageArea(self:GetLauncher(), myPos, self.NukeOuterRingRadius, self.NukeOuterRingDamage, 'Normal', true, true)
        else
            local ringWidth = (self.NukeOuterRingRadius / self.NukeOuterRingTicks)
            local tickLength = (self.NukeOuterRingTotalTime / self.NukeOuterRingTicks)
            
            -- Since we're not allowed to have an inner radius of 0 in the DamageRing function,
            -- I'm manually executing the first tick of damage with a DamageArea function.
            DamageArea(self:GetLauncher(), myPos, ringWidth, self.NukeOuterRingDamage, 'Normal', true, true)
            WaitSeconds(tickLength)
            for i = 2, self.NukeOuterRingTicks do
                DamageRing(self:GetLauncher(), myPos, ringWidth * (i - 1), ringWidth * i, self.NukeOuterRingDamage, 'Normal', true, true)
                WaitSeconds(tickLength)
            end
        end
    end,

    InnerRingDamage = function(self)
        local myPos = self:GetPosition()
        if self.NukeInnerRingTotalTime == 0 then
            DamageArea(self:GetLauncher(), myPos, self.NukeInnerRingRadius, self.NukeInnerRingDamage, 'Normal', true, true)
        else
            local ringWidth = (self.NukeInnerRingRadius / self.NukeInnerRingTicks)
            local tickLength = (self.NukeInnerRingTotalTime / self.NukeInnerRingTicks)
            
            -- Since we're not allowed to have an inner radius of 0 in the DamageRing function,
            -- I'm manually executing the first tick of damage with a DamageArea function.
            DamageArea(self:GetLauncher(), myPos, ringWidth, self.NukeInnerRingDamage, 'Normal', true, true)
            WaitSeconds(tickLength)
            for i = 2, self.NukeInnerRingTicks do
                DamageRing(self:GetLauncher(), myPos, ringWidth * (i - 1), ringWidth * i, self.NukeInnerRingDamage, 'Normal', true, true)
                WaitSeconds(tickLength)
            end
        end
    end,   
    
    
    -- Create inner explosion plasma
    CreateEffectInnerPlasma = function(self)
        local vx, vy, vz = self:GetVelocity()
        local num_projectiles = 20        
        local horizontal_angle = (2*math.pi) / num_projectiles
        local angleInitial = RandomFloat(0, horizontal_angle)  
        local xVec, zVec
        local offsetMultiple = 5.0
        local px, pz

        for i = 0, (num_projectiles -1) do            
            xVec = (math.sin(angleInitial + (i*horizontal_angle)))
            zVec = (math.cos(angleInitial + (i*horizontal_angle)))
            px = (offsetMultiple*xVec)
            pz = (offsetMultiple*zVec)
            
            local proj = self:CreateProjectile(BasiliskNukeEffect05, px, -10, pz, xVec, 0, zVec)
            proj:SetLifetime(4.0)
            proj:SetVelocity(8.0)
            proj:SetAcceleration(-0.35)            
        end
    end,
         
    
    EffectThread = function(self)
        local army = self:GetArmy()
        local position = self:GetPosition()

        -- Knockdown force rings
        DamageRing(self, position, 0.1, 45, 1, 'Force', true)
        WaitSeconds(0.8)
        DamageRing(self, position, 0.1, 45, 1, 'Force', true)
        
        -- Create initial fireball dome effect
        local FireballDomeYOffset = -20
        self:CreateProjectile('/effects/entities/BasiliskNukeEffect01/BasiliskNukeEffect01_proj.bp',0,FireballDomeYOffset,0,0,0,1)
        WaitSeconds(1.1)
        
        -- These include waits
        PlumeGenerate(0.1, 0.1)
        PlumeGenerate(1.5, 0.3)
        PlumeGenerate(0.2, 0.5)
        PlumeGenerate(0.5, 0.7)
        PlumeGenerate(0.5, 0.2)
        
        local army = self:GetArmy()
        CreateDecal(self:GetPosition(), RandomFloat(0,2*math.pi), 'nuke_scorch_001_albedo', '', 'Albedo', 60, 60, 500, 0, army)
        
    end,
    
    PlumeGenerate = function(wait, angle)
        local num_projectiles = 3
        local horizontal_angle = (2*math.pi) / num_projectiles
        local angleInitial = RandomFloat(0, horizontal_angle)  
        local xVec, yVec, zVec
        local px, pz       
        local py = -10
        
        for i = 0, (num_projectiles -1) do            
            xVec = math.sin(angleInitial + (i*horizontal_angle) + RandomFloat(-angle, angle)) 
            yVec = RandomFloat(0.5, 1.7) + 1.2
            zVec = math.cos(angleInitial + (i*horizontal_angle) + RandomFloat(-angle, angle)) 
            px = RandomFloat(0.5, 1.0) * xVec
            pz = RandomFloat(0.5, 1.0) * zVec
            
            local proj = self:CreateProjectile(BasiliskNukeEffect04, px, py, pz, xVec, yVec, zVec)
            proj:SetVelocity(RandomFloat(20, 30 ))
            proj:SetBallisticAcceleration(-9.8)            
        end        
        
        WaitSeconds(wait)
    end,
}

TypeClass = BasiliskNukeEffectController01
