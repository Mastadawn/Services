local event = {};
event.__index = event;

function event.new()
	local self = setmetatable({}, event);
	self.active = true;
	self.connections = {};
	return self;
end

function event:Fire(...)
	if not self.active then return "Event is currently disabled." end;
	for _, e in self.connections do
		task.spawn(e, ...);
	end
end

function event:Connect(connectFunction : Function)
	table.insert(self.connections, connectFunction)
	return {
		Disconnect = function()
			local ind = table.find(self.connections, connectFunction);
			if ind then table.remove(self.connections, ind); end
		end
	}
end

function event:Disconnect()
	self:clean();
	self.active = false;
end

function event:setEnabled(state : boolean)
	self.active = state;
end

function event.clean(t : table)
	for _, e in t do
		if (type(e) == "table") then
			event.clean(e);
		end
		t[_] = nil;
	end
end

return event;
