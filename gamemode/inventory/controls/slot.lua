
local PANEL = {}

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	--[[self.NumPad1 = vgui.Create( "DBinder", self )
	self.Label1 = vgui.Create( "DLabel", self )
	self.Label1:SetDark( true )
	
	self.NumPad2 = vgui.Create( "DBinder", self )
	self.Label2 = vgui.Create( "DLabel", self )
	self.Label2:SetDark( true )
	
	self:SetPaintBackground( false )

	self:SetHeight( 200 )]]

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

	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 100, 100, 100 ) )
	if self:IsHovered() then
		draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 255, 100, 100 ) )
	end

end

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	self:SetSize( 40, 40 )

end

vgui.Register( "Slot", PANEL, "DPanel" )