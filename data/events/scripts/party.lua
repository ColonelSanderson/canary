function Party:onJoin(player)
	local playerId = player:getId()
	addEvent(function()
		player = Player(playerId)
		if not player then
			return
		end
		local party = player:getParty()
		if not party then
			return
		end
		party:refreshHazard()
	end, 100)
	return true
end

function Party:onLeave(player)
	local playerId = player:getId()
	local members = self:getMembers()
	table.insert(members, self:getLeader())
	local memberIds = {}
	for _, member in ipairs(members) do
		if member:getId() ~= playerId then
			table.insert(memberIds, member:getId())
		end
	end

	addEvent(function()
		player = Player(playerId)
		if player then
			player:updateHazard()
		end

		for _, memberId in ipairs(memberIds) do
			local member = Player(memberId)
			if member then
				local party = member:getParty()
				if party then
					party:refreshHazard()
					return -- Only one player needs to refresh the hazard for the party
				end
			end
		end
	end, 100)
	return true
end

function Party:onDisband()
	local members = self:getMembers()
	table.insert(members, self:getLeader())
	local memberIds = {}
	for _, member in ipairs(members) do
		if member:getId() ~= playerId then
			table.insert(memberIds, member:getId())
		end
	end
	addEvent(function()
		for _, memberId in ipairs(memberIds) do
			local member = Player(memberId)
			if member then
				member:updateHazard()
			end
		end
	end, 100)
	return true
end

function Party:onShareExperience(exp)
	local sharedExperienceMultiplier = 1.20 --20%
	local vocationsIds = {}

	local vocationId = self:getLeader():getVocation():getBase():getId()
	if vocationId ~= VOCATION_NONE then
		table.insert(vocationsIds, vocationId)
	end

	for _, member in ipairs(self:getMembers()) do
		vocationId = member:getVocation():getBase():getId()
		if not table.contains(vocationsIds, vocationId) and vocationId ~= VOCATION_NONE then
			table.insert(vocationsIds, vocationId)
		end
	end
    local shareRates = {configManager.getFloat(configKeys.RATE_SHARE_EXPERIENCE2),
        configManager.getFloat(configKeys.RATE_SHARE_EXPERIENCE3),
        configManager.getFloat(configKeys.RATE_SHARE_EXPERIENCE4)}
	local size = #vocationsIds
	if size > 1 then
        -- Get the share rate for the party size, or the last one if the party size exceeds the table size
        local shareRate = shareRates[size - 1] or shareRates[#shareRates] or 1.0
		sharedExperienceMultiplier = (1.0 + ((size * (5 * (size - 1) + 10)) / 100)) * shareRate
	end

	return (exp * sharedExperienceMultiplier) / (#self:getMembers() + 1)
end
