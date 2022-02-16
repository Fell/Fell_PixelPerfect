local f = CreateFrame("Frame", nil, UIParent)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self, event)
	
	local ENABLED = 1
	local DEBUG = 0
	local MAGIC_X = -0.25
	local MAGIC_Y = 0.4

	-- This draws some 1 pixel crosshairs on the screen to test the pixel alignment of UIParent
	if DEBUG >= 1 then
		AddCrosshairs("CENTER", 0, 0)
		AddCrosshairs("TOPLEFT", 10, -10)
		AddCrosshairs("TOPRIGHT", -10, -10)
	end

	-- Calculate pixel perfect UI scale for the current resolution
	local scale = 768.0 / string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")
	
	if DEBUG >= 2 then
		print("Detected Window Height = " .. string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
		print("Setting Scale = " .. scale)
		print("New Width = " .. GetScreenWidth())
		print("New Height = " .. GetScreenHeight())
		print("Effective Scale = " .. UIParent:GetEffectiveScale())
	end

	-- Deactivate the UI scale option
	SetCVar("UseUIScale", 0)

	-- Apply calculated pixel perfect scale
	UIParent:SetScale(scale)
	
	if ENABLED > 0 then
		
		-- Apply "magic" offsets to the entire UI for pixel alignment
		UIParent:SetPoint("TOPLEFT", MAGIC_X, MAGIC_Y)
		UIParent:SetPoint("BOTTOMRIGHT", MAGIC_X+1, MAGIC_Y-1)

		-- Align other UI elements
		MainMenuExpBar:SetPoint("TOP", 0.5, 0)
		ReputationWatchStatusBar:SetPoint("TOP", 0.5, 0)
		CharacterMicroButton:SetPoint("BOTTOMLEFT", 554, 2.5)
		MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", -6.5, 2)
		MainMenuBarArtFrame:SetPoint("TOPLEFT", -1.0, 0)
		ActionBarUpButton:SetPoint("CENTER", MainMenuBarArtFrame, "TOPLEFT", 521, -22)
		ActionBarDownButton:SetPoint("CENTER", MainMenuBarArtFrame, "TOPLEFT", 521, -42)
		MultiCastActionBarFrame:SetPoint("TOPLEFT", 30.5, 0)
		ShapeshiftBarFrame:SetPoint("TOPLEFT", 30.5, 0)
	end
end)

local function AddCrosshairs(relativeTo, offsetX, offsetY)
    
	local SIZE = 64
	
	local bg = UIParent:CreateTexture()
	bg:SetTexture(0,0,0,1)
	bg:SetSize(SIZE,SIZE)
	bg:SetPoint(relativeTo, 0, 0)

	local line0 = UIParent:CreateTexture()
	line0:SetTexture(1,1,1,1)
	line0:SetSize(1,SIZE)
	line0:SetPoint(relativeTo, offsetX-1, offsetY)

	local line1 = UIParent:CreateTexture()
	line1:SetTexture(1,1,1,1)
	line1:SetSize(1,SIZE)
	line1:SetPoint(relativeTo, offsetX+1, offsetY)

	local line2 = UIParent:CreateTexture()
	line2:SetTexture(1,1,1,1)
	line2:SetSize(SIZE,1)
	line2:SetPoint(relativeTo, offsetX, offsetY-1)

	local line3 = UIParent:CreateTexture()
	line3:SetTexture(1,1,1,1)
	line3:SetSize(SIZE,1)
	line3:SetPoint(relativeTo, offsetX, offsetY+1)
end

-- // Other debugging stuff for reference
-- local text = UIParent:CreateFontString(nil, UIParent, "GameFontHighlight")
-- text:SetPoint("CENTER", 0, 20)
-- text:SetText("Hello World")
-- local MySlider = CreateFrame("Slider", "MySlider", UIParent, "OptionsSliderTemplate")
-- MySlider:SetWidth(500)
-- MySlider:SetHeight(20)
-- MySlider:Show()
-- MySlider:SetPoint("CENTER", 0, 0)
-- MySlider:SetMinMaxValues(-2, 2)
-- f:SetScript("OnUpdate", function(self, elapsed)
-- 
-- 	local value = MySlider:GetValue()
-- 	text:SetText(value)
-- 
-- end)
-- 
-- function PrintChildren(element)
-- 	
-- 	local children = { element:GetChildren() }
-- 	for i, child in ipairs(children) do
-- 		print(child:GetName())
-- 	end
-- 
-- end