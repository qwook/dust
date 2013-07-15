
local PANEL = {}

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

end

function PANEL:Think()
	if self:IsHovered() then
		DragPanel = self
	else
		if DragPanel == self then
			DragPanel = nil
		end
	end
end

function PANEL:Paint()

	draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0 ) )
	draw.RoundedBox( 0, 0, 0, self:GetWide()-1, self:GetTall()-1, Color( 100, 100, 100 ) )
	if self:IsHovered() then
		draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 255, 100, 100, 100 ) )
	end

end

function PANEL:GetItem()

	return self:GetChildren()[1]

end

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	self:SetSize( 64, 64 )

end

vgui.Register( "Slot", PANEL, "DPanel" )