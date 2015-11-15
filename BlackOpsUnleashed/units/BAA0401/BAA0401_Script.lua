--****************************************************************************
-- File     :  /cdimage/units/BAA0401/BAA0401_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  Aeon Long Range Artillery Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.**************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local ArtemisLaserGenerator = import('/mods/BlackOpsUnleashed/lua/BlackOpsweapons.lua').ArtemisLaserGenerator
local TDFMachineGunWeapon = import('/lua/terranweapons.lua').TDFMachineGunWeapon
local cWeapons = import('/lua/cybranweapons.lua')
local CIFCommanderDeathWeapon = cWeapons.CIFCommanderDeathWeapon


local BlackOpsEffectTemplate = import('/mods/BlackOpsUnleashed/lua/BlackOpsEffectTemplates.lua')
local utilities = import('/lua/utilities.lua')
local explosion = import('/lua/defaultexplosions.lua')

local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local Entity = import('/lua/sim/Entity.lua').Entity

BAA0401 = Class(AAirUnit) {
    DestroyNoFallRandomChance = 1.1,  
    
    ChargeEffects01 = BlackOpsEffectTemplate.ArtemisMuzzleChargeFlash,
    ChargeEffects02 = BlackOpsEffectTemplate.ArtemisMuzzleChargeeffect01,
    ChargeEffects03 = BlackOpsEffectTemplate.ArtemisMuzzleChargeeffect02,

    Weapons = {
        BeamGun = Class(ArtemisLaserGenerator) {
            OnCreate = function(self)
                if not self.unit.SpinManip then 
                    self.unit.SpinManip = CreateRotator(self.unit, 'Ring_1', 'y', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.unit.SpinManip)
                end
                if self.unit.SpinManip then
                    self.unit.SpinManip:SetTargetSpeed(50)
                end
                
                if not self.unit.SpinManip2 then 
                    self.unit.SpinManip2 = CreateRotator(self.unit, 'Ring_2', 'y', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.unit.SpinManip2)
                end
                if self.unit.SpinManip2 then
                    self.unit.SpinManip2:SetTargetSpeed(-60)
                end
                
                if not self.unit.SpinManip3 then 
                    self.unit.SpinManip3 = CreateRotator(self.unit, 'Ring_3', 'y', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.unit.SpinManip3)
                end
                if self.unit.SpinManip3 then
                    self.unit.SpinManip3:SetTargetSpeed(30)
                end
                
                if not self.unit.SpinManip4 then 
                    self.unit.SpinManip4 = CreateRotator(self.unit, 'Ring_4', 'y', nil, 270, 180, 600)
                    self.unit.Trash:Add(self.unit.SpinManip4)
                end
                if self.unit.SpinManip4 then
                    self.unit.SpinManip4:SetTargetSpeed(-150)
                end
                
                if not self.unit.SpinManip5 then 
                    self.unit.SpinManip5 = CreateRotator(self.unit, 'Ring_5', 'y', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.unit.SpinManip5)
                end
                if self.unit.SpinManip5 then
                    self.unit.SpinManip5:SetTargetSpeed(150)
                end
                
                if not self.unit.SpinManip6 then 
                    self.unit.SpinManip6 = CreateRotator(self.unit, 'Ring_6', 'y', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.unit.SpinManip6)
                end
                if self.unit.SpinManip6 then
                    self.unit.SpinManip6:SetTargetSpeed(-150)
                end
                
                if not self.unit.SpinManip7 then 
                    self.unit.SpinManip7 = CreateRotator(self.unit, 'Ring_7', 'y', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.unit.SpinManip7)
                end
                if self.unit.SpinManip7 then
                    self.unit.SpinManip7:SetTargetSpeed(50)
                end
                
                if not self.unit.SpinManip8 then 
                    self.unit.SpinManip8 = CreateRotator(self.unit, 'Ring_8', 'y', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.unit.SpinManip8)
                end
                if self.unit.SpinManip8 then
                    self.unit.SpinManip8:SetTargetSpeed(-80)
                end
                
                if not self.unit.SpinManip9 then 
                    self.unit.SpinManip9 = CreateRotator(self.unit, 'Ring_9', 'y', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.unit.SpinManip9)
                end
                if self.unit.SpinManip9 then
                    self.unit.SpinManip9:SetTargetSpeed(80)
                end
                ArtemisLaserGenerator.OnCreate(self)
            end,
            
            PlayFxRackSalvoChargeSequence = function(self, muzzle)
                local wep = self.unit:GetWeaponByLabel('BeamGun')
                local bp = wep:GetBlueprint()
                if bp.Audio.RackSalvoCharge then
                    wep:PlaySound(bp.Audio.RackSalvoCharge)
                end
                
                if self.unit.SpinManip then
                    self.unit.SpinManip:SetTargetSpeed(1000)
                end
                
                if self.unit.SpinManip2 then
                    self.unit.SpinManip2:SetTargetSpeed(-1000)
                end
                
                if self.unit.SpinManip3 then
                    self.unit.SpinManip3:SetTargetSpeed(1000)
                end
                
                if self.unit.SpinManip4 then
                    self.unit.SpinManip4:SetTargetSpeed(-1000)
                end
                
                if self.unit.SpinManip5 then
                    self.unit.SpinManip5:SetTargetSpeed(1000)
                end
                
                if self.unit.SpinManip6 then
                    self.unit.SpinManip6:SetTargetSpeed(-1000)
                end
                
                if self.unit.SpinManip7 then
                    self.unit.SpinManip7:SetTargetSpeed(1000)
                end
                
                if self.unit.SpinManip8 then
                    self.unit.SpinManip8:SetTargetSpeed(-1000)
                end
                
                if self.unit.SpinManip9 then
                    self.unit.SpinManip9:SetTargetSpeed(1000)
                end
                
                if self.unit.ChargeEffects01Bag then
                    for k, v in self.unit.ChargeEffects01Bag do
                        v:Destroy()
                    end
                    self.unit.ChargeEffects01Bag = {}
                end
                for k, v in self.unit.ChargeEffects01 do
                    table.insert(self.unit.ChargeEffects01Bag, CreateAttachedEmitter(self.unit, 'Nuke_Muzzle01', self.unit:GetArmy(), v):ScaleEmitter(2))
                end
                
                if self.unit.ChargeEffects02Bag then
                    for k, v in self.unit.ChargeEffects02Bag do
                        v:Destroy()
                    end
                    self.unit.ChargeEffects02Bag = {}
                end
                for k, v in self.unit.ChargeEffects02 do
                    table.insert(self.unit.ChargeEffects02Bag, CreateAttachedEmitter(self.unit, 'ChargeEffect01', self.unit:GetArmy(), v):ScaleEmitter(1))
                    table.insert(self.unit.ChargeEffects02Bag, CreateAttachedEmitter(self.unit, 'ChargeEffect02', self.unit:GetArmy(), v):ScaleEmitter(1))
                end
                
                if self.unit.ChargeEffects03Bag then
                    for k, v in self.unit.ChargeEffects03Bag do
                        v:Destroy()
                    end
                    self.unit.ChargeEffects03Bag = {}
                end
                for k, v in self.unit.ChargeEffects03 do
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura01', self.unit:GetArmy(), v):ScaleEmitter(0.1))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura01', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, -0.8, 0))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura01', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, 0.8, 0))
                    
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura02', self.unit:GetArmy(), v):ScaleEmitter(0.1))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura02', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, -0.8, 0))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura02', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, 0.8, 0))
                    
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura03', self.unit:GetArmy(), v):ScaleEmitter(0.1))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura03', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, -0.8, 0))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura03', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, 0.8, 0))
                    
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura04', self.unit:GetArmy(), v):ScaleEmitter(0.1))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura04', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, -0.8, 0))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura04', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, 0.8, 0))
                    
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura05', self.unit:GetArmy(), v):ScaleEmitter(0.1))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura05', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, -0.8, 0))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura05', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, 0.8, 0))
                    
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura06', self.unit:GetArmy(), v):ScaleEmitter(0.1))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura06', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, -0.8, 0))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura06', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, 0.8, 0))
                    
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura07', self.unit:GetArmy(), v):ScaleEmitter(0.1))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura07', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, -0.8, 0))
                    table.insert(self.unit.ChargeEffects03Bag, CreateAttachedEmitter(self.unit, 'ChargeAura07', self.unit:GetArmy(), v):ScaleEmitter(0.1):OffsetEmitter(0, 0.8, 0))
                end
                
                ArtemisLaserGenerator.PlayFxRackSalvoChargeSequence(self, muzzle) 
            end,
            
            
            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.unit.SpinManip then
                    self.unit.SpinManip:SetTargetSpeed(50)
                end
                if self.unit.SpinManip2 then
                    self.unit.SpinManip2:SetTargetSpeed(-50)
                end
                if self.unit.SpinManip3 then
                    self.unit.SpinManip3:SetTargetSpeed(50)
                end
                if self.unit.SpinManip4 then
                    self.unit.SpinManip4:SetTargetSpeed(-50)
                end
                if self.unit.SpinManip5 then
                    self.unit.SpinManip5:SetTargetSpeed(50)
                end
                if self.unit.SpinManip6 then
                    self.unit.SpinManip6:SetTargetSpeed(-50)
                end
                if self.unit.SpinManip7 then
                    self.unit.SpinManip7:SetTargetSpeed(50)
                end
                if self.unit.SpinManip8 then
                    self.unit.SpinManip8:SetTargetSpeed(-50)
                end
                if self.unit.SpinManip9 then
                    self.unit.SpinManip9:SetTargetSpeed(50)
                end
                if self.unit.ChargeEffects03Bag then
                for k, v in self.unit.ChargeEffects03Bag do
                    v:Destroy()
                end
                self.unit.ChargeEffects03Bag = {}
            end
                ArtemisLaserGenerator.PlayFxRackSalvoReloadSequence(self)
            end,
        },
        ArtemisCannon = Class(TDFMachineGunWeapon) {},
        --ArtemisCannon2 = Class(TDFMachineGunWeapon) {},
    },
    --
        SetParent = function(self, parent)
--
                self.Parent = parent
--
        end,
        --[[
    OnDamage = function(self, instigator, amount, vector, damagetype) 
        if not self:IsDead() then
            ------Base script for this script function was developed by Gilbot_x
            --local artemis_DLS = 0.08
            --amount = math.ceil(amount*artemis_DLS)
            if not self:IsDead() then
                self:ForkThread(self.WeaponsThread)
            end
        end
        AAirUnit.OnDamage(self, instigator, amount, vector, damagetype) 
    end,
    ]]--
    OnStopBeingBuilt = function(self)
        --ChangeState(self, self.OpenState)
        --self:SetWeaponEnabledByLabel('ArtemisCannon', false)
        --self:SetWeaponEnabledByLabel('ArtemisCannon2', false)
        self.ChargeEffects01Bag = {}
        self.ChargeEffects02Bag = {}
        self.ChargeEffects03Bag = {}
        AAirUnit.OnStopBeingBuilt(self) 
    end,
    
    
    OpenState = State() {
        Main = function(self)
            self.OpenAnim = CreateAnimator(self)
            WaitSeconds(6)
            
            self.OpenAnim:PlayAnim('/units/BAA0401/BAA0401_Aopen.sca')
            
        end,
    },
    
    
    
    CreateDamageEffects = function(self, bone, army)
        for k, v in BlackOpsEffectTemplate.ArtemisDamageFireSmoke01 do
            CreateAttachedEmitter(self, bone, army, v):ScaleEmitter(6)
        end
    end,
    
    CreateExplosionDebris = function(self, bone, army)
        for k, v in EffectTemplate.ExplosionDebrisLrg01 do
            CreateAttachedEmitter(self, bone, army, v)--:OffsetEmitter(0, 5, 0)
        end
    end,
    --[[
    CreateSCUEffects = function(self, bone, army)
        local sides = 1
        local angle = (1*math.pi) / sides
        local velocity = 2
        local OffsetMod = 1
        local projectiles = {}

        for i = 0, (sides-1) do
            local X = math.sin(i*angle)
            local Z = math.cos(i*angle)
            local proj =  self:CreateProjectile('/effects/Entities/SCUDeath01/SCUDeath01_proj.bp', X * OffsetMod , 2, Z * OffsetMod, X, 0, Z)
                :SetVelocity(velocity)
            table.insert(projectiles, proj)
        end  
    end,
    ]]--
    
    OnKilled = function(self, instigator, type, overkillRatio)
        --LOG('*SINCE I JUST GOT MYSELF SHOT DOWN TELLING THE CARRIER TO MAKE ANOTHER DRONE')
            --
        if self.Parent then
            self.Parent:NotifyOfDroneDeath()
        end
        self.Trash:Destroy()
        self.Trash = TrashBag()
        self:ForkThread(self.DeathEffectsThread)
        AAirUnit.OnKilled(self, instigator, type, overkillRatio)        
    end,
    
    DeathEffectsThread = function(self)
        local army = self:GetArmy()

        -- Create Initial explosion effects
        explosion.CreateFlash(self, 'BAA0401', 4.5, army)
        CreateAttachedEmitter(self, 'Turret', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp'):OffsetEmitter(0, 5, 0)
        CreateAttachedEmitter(self,'Turret', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp'):OffsetEmitter(0, 5, 0)
        CreateAttachedEmitter(self,'Turret', army, '/effects/emitters/distortion_ring_01_emit.bp')


        self:CreateExplosionDebris('DamageBone11', army)
        self:CreateExplosionDebris('Turret', army)
        self:CreateExplosionDebris('DamageBone01', army)

        --WaitSeconds(1)
        
        -- Create damage effects on turret bone
        CreateDeathExplosion(self, 'DamageBone01', 1.5)
        
        self:CreateDamageEffects('DamageBone01', army)
        self:CreateDamageEffects('DamageBone02', army)
        self:CreateDamageEffects('DamageBone03', army)
        self:CreateDamageEffects('DamageBone04', army)
        WaitSeconds(0.8)
        self:CreateDamageEffects('DamageBone05', army)
        self:CreateDamageEffects('DamageBone06', army)
        self:CreateDamageEffects('DamageBone07', army)
        self:CreateDamageEffects('DamageBone08', army)
        WaitSeconds(0.8)
        self:CreateDamageEffects('DamageBone09', army)
        self:CreateDamageEffects('DamageBone10', army)
        self:CreateDamageEffects('DamageBone11', army)
        self:CreateDamageEffects('DamageBone12', army)
        
        CreateDeathExplosion(self, 'DamageBone01', 1)

        CreateDeathExplosion(self, 'DamageBone08', 1)
        WaitSeconds(0.8)
        CreateDeathExplosion(self, 'DamageBone05', 1)
        WaitSeconds(0.5)
        CreateDeathExplosion(self, 'DamageBone11', 1)
        WaitSeconds(0.4)
        CreateDeathExplosion(self, 'DamageBone03', 1)
        CreateDeathExplosion(self, 'DamageBone02', 2)
        CreateDeathExplosion(self, 'DamageBone12', 1)

        WaitSeconds(0.5)
    end,
    
    DeathThread = function(self)
        self:PlayUnitSound('Destroyed')
        local army = self:GetArmy()
        local bp = self:GetBlueprint()
        --[[
        self:CreateDamageEffects('DamageBone01', army)
        self:CreateDamageEffects('DamageBone04', army)
        self:CreateDamageEffects('DamageBone06', army)
        self:CreateDamageEffects('DamageBone08', army)
        self:CreateDamageEffects('DamageBone10', army)
        self:CreateDamageEffects('DamageBone12', army)
        ]]--
        WaitSeconds(0.4)
        CreateDeathExplosion(self, 'DamageBone03', 1)
        WaitSeconds(0.4)
        CreateDeathExplosion(self, 'DamageBone02', 2)
        WaitSeconds(0.2)
        CreateDeathExplosion(self, 'DamageBone08', 1)
        WaitSeconds(0.2)
        CreateDeathExplosion(self, 'DamageBone05', 1)
        LOG('waiting 0.5 seconds')
        WaitSeconds(0.5)
        --[[
        for i, numWeapons in bp.Weapon do
            if(bp.Weapon[i].Label == 'DeathExplosion') then
                self:CreateSCUEffects('BAA0401', army)-- spawns the final explsoion and does the final area damage
                DamageArea(self, self:GetPosition(), bp.Weapon[i].DamageRadius, bp.Weapon[i].Damage, bp.Weapon[i].DamageType, bp.Weapon[i].DamageFriendly)
                break
            end
        end
        ]]--
        CreateDeathExplosion(self, 'BAA0401', 5)
        self:PlayUnitSound('Destroyed')
        self:CreateWreckage(0.1)
        self:Destroy()
    end,
    
}

TypeClass = BAA0401