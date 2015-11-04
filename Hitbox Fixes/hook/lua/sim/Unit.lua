local oldUnit = Unit
Unit = Class(oldUnit) {

    OnStopBeingBuilt = function(self, builder, layer)
		oldUnit.OnStopBeingBuilt(self, builder, layer)
		local bp = self:GetBlueprint()
		if bp.RaiseDistance then
			local Position = self:GetPosition()
			self:SetPosition({Position[1], Position[2] + bp.RaiseDistance, Position[3]}, true)		
		end
	end,

	--Get rid of a broken check mechanism
    ShieldIsOn = function(self)
        if self.MyShield then
            return self.MyShield:IsOn()
        end
    end,

    OnDamage = function(self, instigator, amount, vector, damageType)
        if self.CanTakeDamage then
            self:DoOnDamagedCallbacks(instigator)

			--Pass damage to an active personal shield, as personal shields no longer have collisions
            if self:GetShieldType() == 'Personal' and self:ShieldIsOn() then
                self.MyShield:ApplyDamage(instigator, amount, vector, damageType)
            else
                self:DoTakeDamage(instigator, amount, vector, damageType)
            end
        end
    end,		
	
    CreatePersonalShield = function(self, shieldSpec)
        local bp = self:GetBlueprint()
        local bpShield = shieldSpec
        if not shieldSpec then
            bpShield = bp.Defense.Shield
        end
        if bpShield then
            self:DestroyShield()
            if bpShield.OwnerShieldMesh then
                self.MyShield = UnitShield {
                    Owner = self,
					ImpactEffects = bpShield.ImpactEffects or '',                     
                    CollisionSizeX = bp.SizeX * 0.5 or 1,				--Reduce from 0.75 to 0.5 to make them the same size as the collisionbox
                    CollisionSizeY = bp.SizeY * 0.5 or 1,
                    CollisionSizeZ = bp.SizeZ * 0.5 or 1,
                    CollisionCenterX = bp.CollisionOffsetX or 0,
                    CollisionCenterY = bp.CollisionOffsetY or 0,
                    CollisionCenterZ = bp.CollisionOffsetZ or 0,
                    OwnerShieldMesh = bpShield.OwnerShieldMesh,
                    ShieldMaxHealth = bpShield.ShieldMaxHealth or 250,
                    ShieldRechargeTime = bpShield.ShieldRechargeTime or 10,
                    ShieldEnergyDrainRechargeTime = bpShield.ShieldEnergyDrainRechargeTime or 10,
                    ShieldRegenRate = bpShield.ShieldRegenRate or 1,
                    ShieldRegenStartTime = bpShield.ShieldRegenStartTime or 5,
                    PassOverkillDamage = bpShield.PassOverkillDamage != false, -- default to true
                }
                self:SetFocusEntity(self.MyShield)
                self:EnableShield()
                self.Trash:Add(self.MyShield)
            else
                LOG('*WARNING: TRYING TO CREATE PERSONAL SHIELD ON UNIT ',repr(self:GetUnitId()),', but it does not have an OwnerShieldMesh=<meshBpName> defined in the Blueprint.')
            end
        end
    end,

}