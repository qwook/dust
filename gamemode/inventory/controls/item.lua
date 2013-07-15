
local PANEL = {}

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()
	self:SetText( "N/A (1)" )
end

function PANEL:Paint()

	draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 20, 20, 20 ) )
	draw.RoundedBox( 0, 1, 1, self:GetWide()-2, self:GetTall()-2, Color( 200, 200, 200 ) )
	if self:IsHovered() then
		draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 255, 200, 200, 100 ) )
	end

end

function PANEL:OnMousePressed(key)
	if key == MOUSE_LEFT then
		self.oldSlot = self:GetParent()
		DragX, DragY = self:CursorPos()
		self:SetDrawOnTop( true )
		Dragging = true
		Draggable = self
	end
end

function PANEL:Think()
	if self:IsHovered() then
		DragPanel = self:GetParent()
	else
		if DragPanel == self:GetParent() then
			DragPanel = nil
		end
	end
end

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	self:SetSize( 64, 64 )

end

vgui.Register( "Item", PANEL, "DButton" )