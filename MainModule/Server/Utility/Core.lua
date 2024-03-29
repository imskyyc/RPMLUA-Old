--// Core Module Class

local Core = {}

function Core.new(Name, Exports)
	local PackagedCore = {
		Name = Name,
		Exports = Exports,
		Environment = {}
	}
	
	setmetatable(PackagedCore, {
		__index = function(Self, Index)
			return PackagedCore.Exports[Index] or PackagedCore.Environment[Index] or rawget(Self, Index) or Core[Index]
		end
	})
	
	return PackagedCore
end

function Core:SetEnvironment(Environment)
	self.Environment = Environment
end

function Core:GetEnvironment()
	return self.Environment
end

function Core:LoadCore()
	if self.Load then
		self.Load()
	end
end

function Core:Freeze()
	self = table.freeze(self)
end

return Core