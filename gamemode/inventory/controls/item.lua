
local PANEL = {}

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:Init()
	self:SetText( "N/A (1)" )
	self._x = 0
	self._y = 0
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
	
	if self.GoalParent then
		if self._x == self.GoalX and self._y == self.GoalY then
			self:SetDrawOnTop( false )
			self:SetParent( self.GoalParent )
			self:SetPos(0, 0)
			self.GoalParent = nil
		else
			local n = Vector(self.GoalX, self.GoalY, 0) - Vector(self._x, self._y, 0)
			local d = n:Distance(Vector(0,0,0))
			n = n:GetNormal()
		
			self._x = math.Approach(self._x, self.GoalX, n.x * FrameTime() * (d + 1)*20)
			self._y = math.Approach(self._y, self.GoalY, n.y * FrameTime() * (d + 1)*20)
			self:SetPos(self._x, self._y)
		end
	end
	
end

function PANEL:MoveInto( slot )
	
	self._x, self._y = self:LocalToScreen(0, 0)
	self:SetPos( self._x, self._y )
	self:SetParent()
	self:SetDrawOnTop( true )
	
	self.GoalParent = slot
	self.GoalX, self.GoalY = self.GoalParent:LocalToScreen(0, 0)
	
end

--[[---------------------------------------------------------
   Name: Init
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	self:SetSize( 64, 64 )

end

vgui.Register( "Item", PANEL, "DButton" )