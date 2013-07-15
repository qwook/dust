
local PANEL = {}

function PANEL:Init()

	self.Panel = vgui.Create( "DPanel", self )

	local slots = {}
	
	for i = 0, 6 do
		local slot = vgui.Create( "Slot", self.Panel )
		
		slot:SetPos(5 + (i % 6)*69, 5 + math.floor(i / 6)*69)
		
		table.insert( slots, slot )
	end
	
end

function PANEL:PerformLayout()

	self:SetSize( 69 * 6 + 5, 74 )
	self:SetPos( (ScrW() - 69 * 6 - 5) / 2, ScrH() - 84 )
	
	self.Panel:SetSize( self:GetSize() )

end

vgui.Register( "SlotsMenu", PANEL, "DPanel" )

local function CreateSlotsMenu()

	if ( g_Slots ) then
	
		g_Slots:Remove()
		g_Slots = nil
	
	end
	
	g_Slots = vgui.Create( "SlotsMenu" )

end

-- Hook to create the spawnmenu at the appropriate time (when all sents and sweps are loaded)
hook.Add( "OnGamemodeLoaded", "CreateSlotsMenu", CreateSlotsMenu )
