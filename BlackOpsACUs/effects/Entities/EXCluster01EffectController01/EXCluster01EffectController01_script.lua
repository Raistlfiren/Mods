--****************************************************************************
--**
--**  File     :  /mods/BlackOpsACUs/effects/Entities/EXCluster01EffectController01/EXCluster01EffectController01_script.lua
--**  Author(s):  Gordon Duclos
--**
--**  Summary  :  Nuclear explosion script
--**
--**  Copyright � 2005,2006 Gas Powered Games, Inc.  All rights reserved.
--****************************************************************************

local NullShell = import('/lua/sim/defaultprojectiles.lua').NullShell
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Util = import('/lua/utilities.lua')
local RandomFloat = Util.GetRandomFloat

EXCluster01EffectController01 = Class(NullShell) {
    --NukeOuterRingDamage = 0,
    --NukeOuterRingRadius = 0,
    --NukeOuterRingTicks = 0,
    --NukeOuterRingTotalTime = 0,

    --NukeInnerRingDamage = 0,
    --NukeInnerRingRadius = 0,
    --NukeInnerRingTicks = 0,
    --NukeInnerRingTotalTime = 0,
   
    
    -- NOTE: This script has been modified to REQUIRE that data is passed in!  The nuke won't explode until this happens!
    --OnCreate = function(self)

    PassData = function(self, Data)
    --    if Data.NukeOuterRingDamage then self.NukeOuterRingDamage = Data.NukeOuterRingDamage end
    --    if Data.NukeOuterRingRadius then self.NukeOuterRingRadius = Data.NukeOuterRingRadius end
    --    if Data.NukeOuterRingTicks then self.NukeOuterRingTicks = Data.NukeOuterRingTicks end
    --    if Data.NukeOuterRingTotalTime then self.NukeOuterRingTotalTime = Data.NukeOuterRingTotalTime end
    --    if Data.NukeInnerRingDamage then self.NukeInnerRingDamage = Data.NukeInnerRingDamage end
    --    if Data.NukeInnerRingRadius then self.NukeInnerRingRadius = Data.NukeInnerRingRadius end
    --    if Data.NukeInnerRingTicks then self.NukeInnerRingTicks = Data.NukeInnerRingTicks end
    --    if Data.NukeInnerRingTotalTime then self.NukeInnerRingTotalTime = Data.NukeInnerRingTotalTime end
  
       self:CreateNuclearExplosion()
    end,

    CreateNuclearExplosion = function(self)
        local myBlueprint = self:GetBlueprint()
            
        -- Play the "NukeExplosion" sound
        if myBlueprint.Audio.NukeExplosion then
            self:PlaySound(myBlueprint.Audio.NukeExplosion)
        end
    
    -- Create Damage Threads
    --    self:ForkThread(self.InnerRingDamage)
    --    self:ForkThread(self.OuterRingDamage)

    -- Create thread that spawns and controls effects
        self:ForkThread(self.EffectThread)
    end,    

    --OuterRingDamage = function(self)
    --    local myPos = self:GetPosition()
    --    if self.NukeOuterRingTotalTime == 0 then
    --        DamageArea(self:GetLauncher(), myPos, self.NukeOuterRingRadius, self.NukeOuterRingDamage, 'Normal', true, true)
    --    else
    --        local ringWidth = (self.NukeOuterRingRadius / self.NukeOuterRingTicks)
    --        local tickLength = (self.NukeOuterRingTotalTime / self.NukeOuterRingTicks)
    --        -- Since we're not allowed to have an inner radius of 0 in the DamageRing function,
    --        -- I'm manually executing the first tick of damage with a DamageArea function.
    --        DamageArea(self:GetLauncher(), myPos, ringWidth, self.NukeOuterRingDamage, 'Normal', true, true)
    --        WaitSeconds(tickLength)
    --        for i = 2, self.NukeOuterRingTicks do
    --            --print('Damage Ring: MaxRadius:' .. 2*i)
    --            DamageRing(self:GetLauncher(), myPos, ringWidth * (i - 1), ringWidth * i, self.NukeOuterRingDamage, 'Normal', true, true)
    --            WaitSeconds(tickLength)
    --        end
    --    end
    --end,

    --InnerRingDamage = function(self)
    --    local myPos = self:GetPosition()
    --    if self.NukeInnerRingTotalTime == 0 then
    --        DamageArea(self:GetLauncher(), myPos, self.NukeInnerRingRadius, self.NukeInnerRingDamage, 'Normal', true, true)
    --    else
    --        local ringWidth = (self.NukeInnerRingRadius / self.NukeInnerRingTicks)
    --        local tickLength = (self.NukeInnerRingTotalTime / self.NukeInnerRingTicks)
    --        -- Since we're not allowed to have an inner radius of 0 in the DamageRing function,
    --        -- I'm manually executing the first tick of damage with a DamageArea function.
    --        DamageArea(self:GetLauncher(), myPos, ringWidth, self.NukeInnerRingDamage, 'Normal', true, true)
    --        WaitSeconds(tickLength)
    --        for i = 2, self.NukeInnerRingTicks do
    --            --LOG('Damage Ring: MaxRadius:' .. ringWidth * i)
    --            DamageRing(self:GetLauncher(), myPos, ringWidth * (i - 1), ringWidth * i, self.NukeInnerRingDamage, 'Normal', true, true)
    --            WaitSeconds(tickLength)
    --        end
    --    end
    --end,

    EffectThread = function(self)
        local army = self:GetArmy()
        local position = self:GetPosition()

        -- Create full-screen glow flash
        --CreateLightParticle(self, -1, army, 18, 4, 'glow_02', 'ramp_red_02')-- Exavier Modified 4th Value
        WaitSeconds(0.015625)
        --CreateLightParticle(self, -1, army, 18, 20, 'glow_03', 'ramp_fire_06')-- Exavier Modified 4th Value

        -- Create initial fireball dome effect
        local FireballDomeYOffset = -0.15625-- Exavier Modified Offset
        self:CreateProjectile('/mods/BlackOpsACUs/effects/Entities/EXCluster01Effect01/EXCluster01Effect01_proj.bp',0,FireballDomeYOffset,0,0,0,1)
        
        -- Create projectile that controls plume effects
        local PlumeEffectYOffset = 0.0625-- Exavier Modified Offset
        self:CreateProjectile('/mods/BlackOpsACUs/effects/Entities/EXCluster01Effect02/EXCluster01Effect02_proj.bp',0,PlumeEffectYOffset,0,0,0,1)        
        
        
        for k, v in EffectTemplate.TNukeRings01 do
      CreateEmitterAtEntity(self, army, v):ScaleEmitter(0.03125)-- Exavier Modified Scale
        end
        
        self:CreateInitialFireballSmokeRing()
        self:ForkThread(self.CreateOuterRingWaveSmokeRing)
        self:ForkThread(self.CreateHeadConvectionSpinners)
        self:ForkThread(self.CreateFlavorPlumes)
        
        WaitSeconds(0.034375)
        
        --CreateLightParticle(self, -1, army, 15, 200, 'glow_03', 'ramp_nuke_04')-- Exavier Modified 4th 5th Value
        
        -- Create ground decals
        --local orientation = RandomFloat(0,2*math.pi)
        --CreateDecal(position, orientation, 'Crater01_albedo', '', 'Albedo', 25, 25, 1200, 0, army)-- Exavier Modified 6th 7th Value
        --CreateDecal(position, orientation, 'Crater01_normals', '', 'Normals', 25, 25, 1200, 0, army)-- Exavier Modified 6th 7th Value       
        --CreateDecal(position, orientation, 'nuke_scorch_003_albedo', '', 'Albedo', 30, 30, 1200, 0, army)-- Exavier Modified 6th 7th Value    

    -- Knockdown force rings
        --DamageRing(self, position, 0.1, 25, 1, 'Force', true)-- Exavier Modified 4th Value
        --WaitSeconds(0.1)
        --DamageRing(self, position, 0.1, 25, 1, 'Force', true)-- Exavier Modified 4th Value

        --WaitSeconds(8.9)
        --self:CreateGroundPlumeConvectionEffects(army)
        
    end,
        
    CreateInitialFireballSmokeRing = function(self)
        local sides = 12
        local angle = (2*math.pi) / sides
        local velocity = 0.41667-- Exavier Modified Velocity
        local OffsetMod = 0.25-- Exavier Modified Offset       

        for i = 0, (sides-1) do
            local X = math.sin(i*angle)
            local Z = math.cos(i*angle)
            self:CreateProjectile('/mods/BlackOpsACUs/effects/Entities/EXCluster01Shockwave01/EXCluster01Shockwave01_proj.bp', X * OffsetMod , 0.09375, Z * OffsetMod, X, 0, Z)
                :SetVelocity(velocity):SetAcceleration(-0.015625)-- Exavier Modified Acceleration
        end   
    end,  
    
    CreateOuterRingWaveSmokeRing = function(self)
        local sides = 32
        local angle = (2*math.pi) / sides
        local velocity = 0.21875-- Exavier Modified Velocity
        local OffsetMod = 0.25-- Exavier Modified Offset
        local projectiles = {}

        for i = 0, (sides-1) do
            local X = math.sin(i*angle)
            local Z = math.cos(i*angle)
            local proj =  self:CreateProjectile('/mods/BlackOpsACUs/effects/Entities/EXCluster01Shockwave02/EXCluster01Shockwave02_proj.bp', X * OffsetMod , 0.15625, Z * OffsetMod, X, 0, Z)
                :SetVelocity(velocity)
            table.insert(projectiles, proj)
        end  
        
        WaitSeconds(0.1875)

        -- Slow projectiles down to normal speed
        for k, v in projectiles do
            v:SetAcceleration(-0.0140625)-- Exavier Moddified Acceleration
        end         
    end,      
    
    CreateFlavorPlumes = function(self)
        local numProjectiles = 8
        local angle = (2*math.pi) / numProjectiles
        local angleInitial = RandomFloat(0, angle)
        local angleVariation = angle * 0.75
        local projectiles = {}

        local xVec = 0 
        local yVec = 0
        local zVec = 0
        local velocity = 0

        -- yVec -0.2, requires 2 initial velocity to start
        -- yVec 0.3, requires 3 initial velocity to start
        -- yVec 1.8, requires 8.5 initial velocity to start

        -- Launch projectiles at semi-random angles away from the sphere, with enough
        -- initial velocity to escape sphere core
        for i = 0, (numProjectiles -1) do
            xVec = math.sin(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))
            yVec = RandomFloat(0.2, 1)
            zVec = math.cos(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation)) 
            velocity = 0.10625 + (yVec * RandomFloat(2,5))-- Exavier Modified Velocity
            table.insert(projectiles, self:CreateProjectile('/mods/BlackOpsACUs/effects/Entities/EXCluster01FlavorPlume01/EXCluster01FlavorPlume01_proj.bp', 0, 0, 0, xVec, yVec, zVec):SetVelocity(velocity))
        end

        WaitSeconds(0.1875)

        -- Slow projectiles down to normal speed
        for k, v in projectiles do
            v:SetVelocity(0.0625):SetBallisticAcceleration(-0.0046875)-- Exavier Modified Velocity Acceleration
        end
    end,
    
    CreateHeadConvectionSpinners = function(self)
        local sides = 10
        local angle = (2*math.pi) / sides
        local HeightOffset = -0.15625-- Exavier Modified Offset
        local velocity = 0.03125-- Exavier Modified Velocity
        local OffsetMod = 0.3125-- Exavier Modified Offset
        local projectiles = {}        

        for i = 0, (sides-1) do
            local x = math.sin(i*angle) * OffsetMod
            local z = math.cos(i*angle) * OffsetMod
            local proj = self:CreateProjectile('/mods/BlackOpsACUs/effects/Entities/EXCluster01Effect03/EXCluster01Effect03_proj.bp', x, HeightOffset, z, x, 0, z)
                :SetVelocity(velocity)
            table.insert(projectiles, proj)
        end   
    
    WaitSeconds(0.0625)
        for i = 0, (sides-1) do
            local x = math.sin(i*angle)
            local z = math.cos(i*angle)
            local proj = projectiles[i+1]
      proj:SetVelocityAlign(false)
      proj:SetOrientation(OrientFromDir(Util.Cross(Vector(x,0,z), Vector(0,1,0))),true)
      proj:SetVelocity(0,0.09375,0)-- Exavier Modified Velocity 
          proj:SetBallisticAcceleration(-0.0015625)-- Exavier Modified Acceleration            
        end   
    end,
    
    CreateGroundPlumeConvectionEffects = function(self,army)
    for k, v in EffectTemplate.TNukeGroundConvectionEffects01 do
          CreateEmitterAtEntity(self, army, v):ScaleEmitter(0.03125)-- Exavier Modified Scale 
    end
    
    local sides = 10
    local angle = (2*math.pi) / sides
    local inner_lower_limit = 0.0625-- Exavier Modified
        local outer_lower_limit = 0.0625-- Exavier Modified
        local outer_upper_limit = 0.0625-- Exavier Modified
    
    local inner_lower_height = 0.03125-- Exavier Modified
    local inner_upper_height = 0.09375-- Exavier Modified
    local outer_lower_height = 0.0625-- Exavier Modified
    local outer_upper_height = 0.09375-- Exavier Modified
      
    sides = 8
    angle = (2*math.pi) / sides
    for i = 0, (sides-1)
    do
        local magnitude = RandomFloat(outer_lower_limit, outer_upper_limit)
        local x = math.sin(i*angle+RandomFloat(-angle/2, angle/4)) * magnitude
        local z = math.cos(i*angle+RandomFloat(-angle/2, angle/4)) * magnitude
        local velocity = RandomFloat(1, 3) * 0.09375-- Exavier Modified Last Number
        self:CreateProjectile('/mods/BlackOpsACUs/effects/Entities/EXCluster01Effect05/EXCluster01Effect05_proj.bp', x, RandomFloat(outer_lower_height, outer_upper_height), z, x, 0, z)
            :SetVelocity(x * velocity, 0, z * velocity)
    end 
    end,
}

TypeClass = EXCluster01EffectController01

