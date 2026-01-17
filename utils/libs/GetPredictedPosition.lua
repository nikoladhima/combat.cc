local PredictionSettings = (...)
if PredictionSettings and type(PredictionSettings) == "table" then
	return function(AimbotType, Position, AssemblyLinearVelocity)
		local PredictionConfiguration = PredictionSettings[AimbotType]
		local AimbotConfiguration = PredictionConfiguration.AimbotConfiguration

		if AimbotConfiguration.AutoPrediction then
			return Position + AssemblyLinearVelocity * (CurrentPing * PredictionConfiguration.AutoPredictionMultiplier)
		end

		local PredictionOffset = AimbotConfiguration.PredictionOffset
		if PredictionOffset > 0 then
			return Position + AssemblyLinearVelocity * PredictionOffset
		end

		return Position
	end
else
    print("[nikoletoscripts/combat.cc]: Failed to find Prediction Settings")
end
