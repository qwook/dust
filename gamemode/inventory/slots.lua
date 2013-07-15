
local PANEL = {}

function PANEL:Init()

	self.Panel = vgui.Create( "DPanel", self )

end

function PANEL:PerformLayout()

	self:SetSize( 50 * 6 + 10, 60 )
	self:SetPos( (ScrW() - 50 * 6 - 10) / 2, ScrH() - 70 )
	
	self.Panel:StretchToParent()

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
