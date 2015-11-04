--Hooking into the main state of the normal class so just switch the order of two lines, giving unit.lua more control over shield parameters.
local oldShield = Shield
Shield = Class(oldShield) {

    OnState = State {
        Main = function(self)

            -- If the shield was turned off; use the recharge time before turning back on
            if self.OffHealth >= 0 then
                self.Owner:SetMaintenanceConsumptionActive()
                self:ChargingUp(0, self.ShieldEnergyDrainRechargeTime)

                -- If the shield has less than full health, allow the shield to begin regening
                if self:GetHealth() < self:GetMaxHealth() and self.RegenRate > 0 then
                    self.RegenThread = ForkThread(self.RegenStartThread, self)
                    self.Owner.Trash:Add(self.RegenThread)
                end
            end

            -- We are no longer turned off
            self.OffHealth = -1

            self:UpdateShieldRatio(-1)

			--Switch the order of these around to make many things possible
            self:CreateShieldMesh()			
            self.Owner:OnShieldEnabled()

            local aiBrain = self.Owner:GetAIBrain()

            WaitSeconds(1.0)
            local fraction = self.Owner:GetResourceConsumed()
            local on = true
            local test = false

            -- Test in here if we have run out of power; if the fraction is ever not 1 we don't have full power
            while on do
                WaitTicks(1)

                self:UpdateShieldRatio(-1)

                fraction = self.Owner:GetResourceConsumed()
                if fraction != 1 and aiBrain:GetEconomyStored('ENERGY') <= 0 then
                    if test then
                        on = false
                    else
                        test = true
                    end
                else
                    on = true
                    test = false
                end
            end

            -- Record the amount of health on the shield here so when the unit tries to turn its shield
            -- back on and off it has the amount of health from before.
            --self.OffHealth = self:GetHealth()
            ChangeState(self, self.EnergyDrainRechargeState)
        end,

        IsOn = function(self)
            return true
        end,
    },

    -- This state happens when the shield has been depleted due to damage
    DamageRechargeState = State {
        Main = function(self)
            self:RemoveShield()
            if self.Owner.OnShieldHpDepleted then -- Not the way to make callbacks
                self.Owner:OnShieldHpDepleted(self)
            end
            # We must make the unit charge up before gettings its shield back
            self:ChargingUp(0, self.ShieldRechargeTime)

            -- Fully charged, get full health
            self:SetHealth(self, self:GetMaxHealth())

            ChangeState(self, self.OnState)
        end,

        IsOn = function(self)
            return false
        end,
    },

    -- This state happens only when the army has run out of power
    EnergyDrainRechargeState = State {
        Main = function(self)
            self:RemoveShield()
            if self.Owner.OnShieldEnergyDepleted then -- Not the way to make callbacks
                self.Owner:OnShieldEnergyDepleted(self)
            end
            self:ChargingUp(0, self.ShieldEnergyDrainRechargeTime)

            -- If the unit is attached to a transport, make sure the shield goes to the off state
            -- so the shield isn't turned on while on a transport
            if not self.Owner:IsUnitState('Attached') then
                ChangeState(self, self.OnState)
            else
                ChangeState(self, self.OffState)
            end
        end,

        IsOn = function(self)
            return false
        end,
    },
}

local oldUnitShield = UnitShield
UnitShield = Class(oldUnitShield) {

    CreateShieldMesh = function(self)
		--Remove the shield collision entirely to allow everything to go through unit.lua
		self:SetCollisionShape('None')	
        self.Owner:SetMesh(self.OwnerShieldMesh,true)
    end,
}

