if not TukuiCF["unitframes"].enable == true then return end


----- [[     Local Variables     ]] -----

local db2 = TukuiCF.fonts
local font, font_size, font_style, font_shadow = db2.unitframe_font, db2.unitframe_font_size, db2.unitframe_font_style, db2.unitframe_font_shadow

local db = TukuiCF["unitframes"]
local font1 = TukuiCF["media"].uffont
local font2 = TukuiCF["media"].font
local normTex = TukuiCF["media"].normTex
local glowTex = TukuiCF["media"].glowTex
local bubbleTex = TukuiCF["media"].bubbleTex
local blank = TukuiCF["media"].blank


----- [[     Layout     ]] -----

local function Shared(self, unit)
	self.colors = TukuiDB.oUF_colors
	
	self:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self.menu = TukuiDB.SpawnMenu
	
	----- [[     Features For All Units     ]] -----

	local InvFrame = CreateFrame("Frame", nil, self)
	InvFrame:SetFrameStrata("HIGH")
	InvFrame:SetFrameLevel(5)
	InvFrame:SetAllPoints()

	local RaidIcon = InvFrame:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetTexture("Interface\\AddOns\\Tukui\\media\\textures\\raidicons.blp") -- thx hankthetank for texture
	RaidIcon:SetHeight(20)
	RaidIcon:SetWidth(20)
	RaidIcon:SetPoint("TOP", 0, 8)
	self.RaidIcon = RaidIcon
	

	----- [[     Player and Target     ]] -----
	
	if (unit == "player" or unit == "target") then
	
		----- [[     Health / Power Bars + Backgrounds / Borders     ]] -----
		
		local health = CreateFrame("StatusBar", nil, self)
		health:SetHeight(TukuiDB.Scale(26))
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(blank)
		self.Health = health

		local hBg = health:CreateTexture(nil, "BORDER")
		hBg:SetAllPoints()
		hBg:SetTexture(.05, .05, .05)
		self.Health.bg = hBg

		local hBorder = CreateFrame("Frame", nil, health)
		hBorder:SetFrameLevel(health:GetFrameLevel() - 1)
		hBorder:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
		hBorder:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
		TukuiDB.SkinPanel(hBorder)
		TukuiDB.Kill(hBorder.bg)
		self.Health.border = hBorder		

		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(TukuiDB.Scale(3))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, TukuiDB.Scale(-7))
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, TukuiDB.Scale(-7))
		power:SetStatusBarTexture(blank)
		self.Power = power
		
		local pBg = power:CreateTexture(nil, "BORDER")
		pBg:SetAllPoints()
		pBg:SetTexture(blank)
		pBg.multiplier = 0.3
		self.Power.bg = pBg
		
		local pBorder = CreateFrame("Frame", nil, power)
		pBorder:SetFrameLevel(power:GetFrameLevel() - 1)
		pBorder:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
		pBorder:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
		TukuiDB.SkinPanel(pBorder)
		TukuiDB.Kill(pBorder.bg)
		self.Power.border = pBorder
		
		
		----- [[     Unit Information Panel     ]] -----

		local panel = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(panel, 1, 17, "BOTTOM", self, "BOTTOM", 0, 0)
		panel:SetFrameLevel(2)
		panel:SetFrameStrata("MEDIUM")
		panel:ClearAllPoints()
		panel:SetPoint("TOPLEFT", pBorder, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
		panel:SetPoint("TOPRIGHT", pBorder, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
		self.panel = panel
		
		
		----- [[     Health and Power Colors / Settings     ]] -----

		health.frequentUpdates = true
		power.frequentUpdates = true

		if db.showsmooth == true then
			health.Smooth = true
			power.Smooth = true
		end
		
		if db.classcolor then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClass = true
			hBg.multiplier = 0.3
			
			power.colorPower = true
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health.colorReaction = false
			health:SetStatusBarColor(.15, .15, .15)
			-- hBg:SetVertexColor(1, .1, .1)		

			power.colorTapping = true
			power.colorDisconnected = true
			power.colorClass = true
			power.colorReaction = true
		end

		
		----- [[     Health and Power Values     ]] -----

		health.value = TukuiDB.SetFontString(panel, font, font_size, font_style)
		health.value:SetPoint("RIGHT", panel, "RIGHT", TukuiDB.Scale(-4), 0)
		health.PostUpdate = TukuiDB.PostUpdateHealth

		power.value = TukuiDB.SetFontString(panel, font, font_size, font_style)
		power.value:SetPoint("LEFT", panel, "LEFT", TukuiDB.Scale(4), 0)
		power.PreUpdate = TukuiDB.PreUpdatePower
		power.PostUpdate = TukuiDB.PostUpdatePower
		
		-- temp
		self:SetAttribute('initial-height', ((health:GetHeight() + 4) + (power:GetHeight() + 4) + (self.panel:GetHeight()) + 6))
		self:SetAttribute('initial-width', TukuiDB.Scale(195))

		
		----- [[     Portraits     ]] -----
		
		if (db.charportrait == true) then
			local portrait = CreateFrame("PlayerModel", nil, self)
			portrait:SetHeight(self:GetAttribute('initial-height'))
			portrait:SetWidth(TukuiDB.Scale(60))
			portrait:SetAlpha(1)
			if unit == "player" then
				portrait:SetPoint("TOPRIGHT", hBorder, "TOPLEFT", TukuiDB.Scale(-3), 0)
			elseif unit == "target" then
				portrait:SetPoint("TOPLEFT", hBorder, "TOPRIGHT", TukuiDB.Scale(3), 0)
			end
			table.insert(self.__elements, TukuiDB.HidePortrait)
			self.Portrait = portrait
		
			local poBg = CreateFrame("Frame", nil, portrait)
			poBg:SetFrameLevel(portrait:GetFrameLevel()-1)
			poBg:SetAllPoints()
			poBg:SetBackdrop({ bgFile = blank, insets = { top = -TukuiDB.mult, left = -TukuiDB.mult, bottom = -TukuiDB.mult, right = -TukuiDB.mult } })
			poBg:SetBackdropColor(unpack(TukuiCF["media"].fadedbackdropcolor))
			portrait.bg = poBg
			
			local pFrame = CreateFrame("Frame", nil, portrait)
			TukuiDB.SkinFadedPanel(pFrame)
			pFrame:SetAllPoints()
			pFrame:SetFrameLevel(portrait:GetFrameLevel()+1)
			pFrame:SetBackdropColor(0, 0, 0, 0)
			portrait.frame = pFrame
		end

		
		----- [[     Player Only Settings     ]] -----

		if (unit == "player") then
		
			----- [[     Combat Icon     ]] -----
			
			local Combat = health:CreateTexture(nil, "OVERLAY")
			Combat:SetHeight(TukuiDB.Scale(19))
			Combat:SetWidth(TukuiDB.Scale(19))
			Combat:SetPoint("LEFT", 0, 1)
			Combat:SetVertexColor(0.69, 0.31, 0.31)
			self.Combat = Combat

			----- [[     Custom Information - Low Mana, etc.     ]] -----
			
			FlashInfo = CreateFrame("Frame", "FlashInfo", self)
			FlashInfo:SetScript("OnUpdate", TukuiDB.UpdateManaLevel)
			FlashInfo.parent = self
			FlashInfo:SetToplevel(true)
			FlashInfo:SetAllPoints(panel)
			FlashInfo.ManaLevel = TukuiDB.SetFontString(FlashInfo, font, font_size, font_style)
			FlashInfo.ManaLevel:SetPoint("CENTER", panel, "CENTER", 0, 0)
			self.FlashInfo = FlashInfo
			
			
			----- [[     PvP Status Text     ]] -----
			
			local status = TukuiDB.SetFontString(panel, font, font_size, font_style)
			status:SetPoint("CENTER", panel, "CENTER", 0, 0)
			status:SetTextColor(0.69, 0.31, 0.31, 0)
			self.Status = status
			self:Tag(status, "[pvp]")
			
			
			----- [[     Leader Icon     ]] -----
			
			local Leader = InvFrame:CreateTexture(nil, "OVERLAY")
			Leader:SetHeight(TukuiDB.Scale(14))
			Leader:SetWidth(TukuiDB.Scale(14))
			Leader:SetPoint("TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(8))
			self.Leader = Leader
			
			
			----- [[     Master Loot Icon     ]] -----
			
			local MasterLooter = InvFrame:CreateTexture(nil, "OVERLAY")
			MasterLooter:SetHeight(TukuiDB.Scale(14))
			MasterLooter:SetWidth(TukuiDB.Scale(14))
			self.MasterLooter = MasterLooter
			self:RegisterEvent("PARTY_LEADER_CHANGED", TukuiDB.MLAnchorUpdate)
			self:RegisterEvent("PARTY_MEMBERS_CHANGED", TukuiDB.MLAnchorUpdate)

			
			----- [[     Threat Bar     ]] -----         NOT DONE!!!
			if (db.showthreat == true) then
				local ThreatBar = CreateFrame("StatusBar", self:GetName()..'_ThreatBar', TukuiInfoLeft)
				-- ThreatBar:SetFrameLevel(5)
				-- ThreatBar:SetPoint("TOPLEFT", TukuiInfoLeft, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				-- ThreatBar:SetPoint("BOTTOMRIGHT", TukuiInfoLeft, TukuiDB.Scale(-2), TukuiDB.Scale(2))
			  
				-- ThreatBar:SetStatusBarTexture(normTex)
				-- ThreatBar:GetStatusBarTexture():SetHorizTile(false)
				-- ThreatBar:SetBackdrop(backdrop)
				-- ThreatBar:SetBackdropColor(0, 0, 0, 0)
		   
				-- ThreatBar.Text = TukuiDB.SetFontString(ThreatBar, font2, 12)
				-- ThreatBar.Text:SetPoint("RIGHT", ThreatBar, "RIGHT", TukuiDB.Scale(-30), 0)
		
				-- ThreatBar.Title = TukuiDB.SetFontString(ThreatBar, font2, 12)
				-- ThreatBar.Title:SetText(tukuilocal.unitframes_ouf_threattext)
				-- ThreatBar.Title:SetPoint("LEFT", ThreatBar, "LEFT", TukuiDB.Scale(30), 0)

				-- ThreatBar.bg = ThreatBar:CreateTexture(nil, 'BORDER')
				-- ThreatBar.bg:SetAllPoints(ThreatBar)
				-- ThreatBar.bg:SetTexture(0.1,0.1,0.1)
		   
				-- ThreatBar.useRawThreat = false
				self.ThreatBar = ThreatBar
			end
			
			
			----- [[     Druid Solar / Lunar Bar and Shapeshift Mana     ]] ----- 
			if TukuiDB.myclass == "DRUID" then
				CreateFrame("Frame"):SetScript("OnUpdate", function() TukuiDB.UpdateDruidMana(self) end)
				local DruidMana = TukuiDB.SetFontString(health, font, font_size, font_style)
				DruidMana:SetTextColor(1, 0.49, 0.04)
				self.DruidMana = DruidMana

				local eclipseBar = CreateFrame('Frame', nil, self)
				eclipseBar:SetPoint("BOTTOMLEFT", hBorder, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(5))
				eclipseBar:SetSize((self:GetAttribute("initial-width") - 2), TukuiDB.Scale(4))
				eclipseBar:SetFrameStrata("MEDIUM")
				eclipseBar:SetFrameLevel(8)
				eclipseBar:SetScript("OnShow", function() TukuiDB.EclipseDisplay(self, false) end)
				eclipseBar:SetScript("OnUpdate", function() TukuiDB.EclipseDisplay(self, true) end) -- just forcing 1 update on login for buffs/shadow/etc.
				eclipseBar:SetScript("OnHide", function() TukuiDB.EclipseDisplay(self, false) end)
			
				local eclipseBarBG = CreateFrame("Frame", nil, eclipseBar)
				eclipseBarBG:SetPoint("TOPLEFT", eclipseBar, "TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
				eclipseBarBG:SetPoint("BOTTOMRIGHT", eclipseBar, "BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
				TukuiDB.SkinPanel(eclipseBarBG)

				local lunarBar = CreateFrame('StatusBar', nil, eclipseBar)
				lunarBar:SetPoint('LEFT', eclipseBar, 'LEFT', 0, 0)
				lunarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
				lunarBar:SetStatusBarTexture(blank)
				lunarBar:SetStatusBarColor(.30, .52, .90)
				eclipseBar.LunarBar = lunarBar

				local solarBar = CreateFrame('StatusBar', nil, eclipseBar)
				solarBar:SetPoint('LEFT', lunarBar:GetStatusBarTexture(), 'RIGHT', 0, 0)
				solarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
				solarBar:SetStatusBarTexture(blank)
				solarBar:SetStatusBarColor(.80, .82,  .60)
				eclipseBar.SolarBar = solarBar

				local eclipseBarText = eclipseBar:CreateFontString(nil, 'OVERLAY')
				eclipseBarText:SetPoint('TOP', panel)
				eclipseBarText:SetPoint('BOTTOM', panel)
				eclipseBarText:SetFont(font, font_size, font_style)
				eclipseBar.PostUpdatePower = TukuiDB.EclipseDirection

				-- hide "low mana" text on load if eclipseBar is show
				if eclipseBar and eclipseBar:IsShown() then FlashInfo.ManaLevel:SetAlpha(0) end

				self.EclipseBar = eclipseBar
				self.EclipseBar.Text = eclipseBarText
			end
			
			
			----- [[     Warlock Shard Bar and Paladin Holy Bar     ]] -----
			
			if (TukuiDB.myclass == "WARLOCK" or TukuiDB.myclass == "PALADIN") then
				local bars = CreateFrame("Frame", nil, self)	
				local barFrame = CreateFrame("Frame", nil, self)
				
				for i = 1, 3 do		
					barFrame[i] = CreateFrame("Frame", nil, self)
					barFrame[i]:SetFrameLevel(health:GetFrameLevel() + 1)
					barFrame[i]:SetHeight(TukuiDB.Scale(8))
					barFrame[i]:SetWidth((self:GetAttribute("initial-width") - 4) / 3)
					TukuiDB.SkinPanel(barFrame[i])
					
					if i == 1 then
						barFrame[i]:SetPoint("BOTTOMLEFT", hBorder, "TOPLEFT", 0, TukuiDB.Scale(3))
					else
						barFrame[i]:SetPoint("TOPLEFT", barFrame[i-1], "TOPRIGHT", TukuiDB.Scale(3), 0)
					end

					bars[i] = CreateFrame("StatusBar", self:GetName().."_Shard"..i, self)
					bars[i]:SetPoint("TOPLEFT", barFrame[i], "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
					bars[i]:SetPoint("BOTTOMRIGHT", barFrame[i], "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
					bars[i]:SetFrameLevel(barFrame:GetFrameLevel() + 1)
					bars[i]:SetStatusBarTexture(blank)			

					bars[i].bg = bars[i]:CreateTexture(nil, 'BORDER')			
					bars[i].bg:SetTexture(bars[i]:GetStatusBarTexture())					
					bars[i].bg:SetAlpha(.15)

					local _, class = UnitClass(unit)
					if TukuiDB.myclass == "WARLOCK" then
						bars[i]:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
					elseif TukuiDB.myclass == "PALADIN" then
						bars[i]:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
					end
				end
				
				if TukuiDB.myclass == "WARLOCK" then
					bars.Override = TukuiDB.UpdateShards				
					self.SoulShards = bars
				elseif TukuiDB.myclass == "PALADIN" then
					bars.Override = TukuiDB.UpdateHoly
					self.HolyPower = bars
				end
			end			

			
			----- [[     Death Knight Runes     ]] -----
			
			if TukuiDB.myclass == "DEATHKNIGHT" and db.runebar == true then
				local Runes = CreateFrame("Frame", nil, self)
				local rB = CreateFrame("Frame", nil, self)
				
				for i = 1, 6 do
					rB[i] = CreateFrame("Frame", nil, self)
					rB[i]:SetFrameLevel(health:GetFrameLevel() + 1)
					rB[i]:SetHeight(TukuiDB.Scale(8))
					rB[i]:SetWidth((self:GetAttribute("initial-width") - 13) / 6)
					if (i == 1) then
						rB[i]:SetPoint("BOTTOMLEFT", hBorder, "TOPLEFT", 0, TukuiDB.Scale(3))
					else
						rB[i]:SetPoint("TOPLEFT", rB[i-1], "TOPRIGHT", TukuiDB.Scale(3), 0)
					end
					TukuiDB.SkinPanel(rB[i])

					Runes[i] = CreateFrame("StatusBar", self:GetName().."_Runes"..i, self)
					Runes[i]:SetPoint("TOPLEFT", rB[i], "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
					Runes[i]:SetPoint("BOTTOMRIGHT", rB[i], "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
					Runes[i]:SetFrameLevel(rB:GetFrameLevel() + 1)
					Runes[i]:SetStatusBarTexture(blank)			
				end

				self.Runes = Runes
			end
			
			
			----- [[     Shaman Totem Timers     ]] -----
			
			if TukuiDB.myclass == "SHAMAN" and db.totemtimer == true then	
				local TotemBar = {}
				TotemBar.Destroy = true
				
				local totemFrame = CreateFrame("Frame", nil, self)
				
				for i = 1, 4 do
					totemFrame[i] = CreateFrame("Frame", nil, self)
					totemFrame[i]:SetFrameLevel(health:GetFrameLevel() + 1)
					totemFrame[i]:SetHeight(TukuiDB.Scale(8))
					totemFrame[i]:SetWidth((self:GetAttribute("initial-width") - 7) / 4)
					TukuiDB.SkinPanel(totemFrame[i])

					if i == 1 then
						totemFrame[i]:SetPoint("BOTTOMLEFT", hBorder, "TOPLEFT", 0, TukuiDB.Scale(3))
					else
						totemFrame[i]:SetPoint("TOPLEFT", totemFrame[i-1], "TOPRIGHT", TukuiDB.Scale(3), 0)
					end
					
					TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, self)
					TotemBar[i]:SetPoint("TOPLEFT", totemFrame[i], "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
					TotemBar[i]:SetPoint("BOTTOMRIGHT", totemFrame[i], "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
					TotemBar[i]:SetFrameLevel(totemFrame:GetFrameLevel() + 2)
					TotemBar[i]:SetStatusBarTexture(blank)
					TotemBar[i]:SetMinMaxValues(0, 1)

					TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "BORDER")
					TotemBar[i].bg:SetAllPoints(TotemBar[i])
					TotemBar[i].bg:SetTexture(normTex) -- sorry this needs to be this texture
					TotemBar[i].bg.multiplier = 0.3
				end
				
				self.TotemBar = TotemBar
			end
			
			
			----- [[     PvP Status / Low Mana Script     ]] -----
			
			self:SetScript("OnEnter", function(self)
				if self.EclipseBar and self.EclipseBar:IsShown() then 
					self.EclipseBar.Text:Hide()
				end
				FlashInfo.ManaLevel:SetAlpha(0) 
				status:SetAlpha(1) 
				UnitFrame_OnEnter(self) 
			end)
			self:SetScript("OnLeave", function(self) 
				if self.EclipseBar and self.EclipseBar:IsShown() then 
					self.EclipseBar.Text:Show()
				end
				FlashInfo.ManaLevel:SetAlpha(1)
				status:SetAlpha(0) 
				UnitFrame_OnLeave(self) 
			end)		
		end
		
		
		----- [[     Target Only Settings     ]] -----

		if (unit == "target") then			
			-- Unit name on target
			local Name = health:CreateFontString(nil, "OVERLAY")
			Name:SetPoint("LEFT", panel, "LEFT", TukuiDB.Scale(4), 0)
			Name:SetJustifyH("LEFT")
			Name:SetFont(font, font_size, font_style)

			if db.classcolor then
				self:Tag(Name, '[Tukui:namelong] [Tukui:diffcolor][level] [shortclassification]')
			else
				self:Tag(Name, '[Tukui:getnamecolor][Tukui:namelong] [Tukui:diffcolor][level] [shortclassification]')
			end
			
			self.Name = Name
		end

	
		----- [[     Auras     ]] -----

		if (unit == "target" and db.targetauras) or (unit == "player" and db.playerauras) then
			local buffs = CreateFrame("Frame", nil, self)
			local debuffs = CreateFrame("Frame", nil, self)
			
			if ((TukuiDB.myclass == "SHAMAN" and db.totemtimer) or (TukuiDB.myclass == "DEATHKNIGHT" and db.runebar) or TukuiDB.myclass == "PALADIN" or TukuiDB.myclass == "WARLOCK") and (db.playerauras) and (unit == "player") then
				buffs:SetPoint("TOPLEFT", self, "TOPLEFT", TukuiDB.Scale(-1), TukuiDB.Scale(37))
			else
				buffs:SetPoint("TOPLEFT", self, "TOPLEFT", TukuiDB.Scale(-1), TukuiDB.Scale(26))
			end
			
			buffs:SetHeight(22)
			buffs:SetWidth(self:GetAttribute('initial-width'))
			buffs.size = 22
			buffs.num = 8

			debuffs:SetHeight(22)
			debuffs:SetWidth(self:GetAttribute('initial-width'))
			debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(3))
			debuffs.size = 22
			debuffs.num = 24

			buffs.spacing = 3
			buffs.initialAnchor = 'TOPLEFT'
			buffs.PostCreateIcon = TukuiDB.PostCreateAura
			buffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Buffs = buffs	

			debuffs.spacing = 3
			debuffs.initialAnchor = 'TOPRIGHT'
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Debuffs = debuffs
		end
		
		
		----- [[     Castbar     ]] -----
		
		if (db.unitcastbar == true) then
			local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
			castbar:SetStatusBarTexture(blank)
			
			if unit == "player" then
				castbar:SetHeight(TukuiDB.Scale(23))
				if db.cbicons then
					castbar:SetPoint("BOTTOMLEFT", TukuiActionBarBackground, "TOPLEFT", TukuiDB.buttonsize + 5, TukuiDB.Scale(5))
				else
					castbar:SetPoint("BOTTOMLEFT", TukuiActionBarBackground, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(5))
				end
				castbar:SetPoint("BOTTOMRIGHT", TukuiActionBarBackground, "TOPRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(5))
			else
				castbar:SetHeight(TukuiDB.Scale(21))
				castbar:SetWidth(TukuiDB.Scale(141))
				castbar:SetPoint("BOTTOM", TukuiActionBarBackground, "TOP", 0, TukuiDB.Scale(180))
			end
			
			local castbarBg = CreateFrame("Frame", nil, castbar)
			castbarBg:SetPoint("TOPLEFT", -TukuiDB.Scale(2), TukuiDB.Scale(2))
			castbarBg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
			castbarBg:SetFrameLevel(castbar:GetFrameLevel() - 1)
			TukuiDB.SkinPanel(castbarBg)
			
			castbar.CustomTimeText = TukuiDB.CustomCastTimeText
			castbar.CustomDelayText = TukuiDB.CustomCastDelayText
			castbar.PostCastStart = TukuiDB.CheckCast
			castbar.PostChannelStart = TukuiDB.CheckChannel

			castbar.time = TukuiDB.SetFontString(castbar, font, font_size, font_style)
			castbar.time:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
			castbar.time:SetPoint("RIGHT", castbar, "RIGHT", TukuiDB.Scale(-4), 1)
			castbar.time:SetTextColor(1, 1, 1)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = TukuiDB.SetFontString(castbar, font, font_size, font_style)
			castbar.Text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
			castbar.Text:SetPoint("LEFT", castbar, "LEFT", TukuiDB.Scale(4), 1)
			castbar.Text:SetTextColor(1, 1, 1)
			
			if unit == "target" then
				castbar.Text:SetWidth(90)
				castbar.Text:SetHeight(20)
			end			

			if db.cbicons == true then
				castbar.button = CreateFrame("Frame", nil, castbar)
				castbar.button:SetHeight(TukuiDB.buttonsize)
				castbar.button:SetWidth(TukuiDB.buttonsize)
				TukuiDB.SetTemplate(castbar.button)
				TukuiDB.CreateShadow(castbar.button)

				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:SetPoint("TOPLEFT", castbar.button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				castbar.icon:SetPoint("BOTTOMRIGHT", castbar.button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
			
				if unit == "player" then
					castbar.button:SetPoint("RIGHT", castbarBg, "LEFT", TukuiDB.Scale(-3), 0)
				elseif unit == "target" then
					castbar.button:SetPoint("BOTTOM", castbarBg, "TOP", 0, TukuiDB.Scale(3))
				end
			end
			
			if unit == "player" and db.cblatency == true then
				castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
				castbar.safezone:SetTexture(blank)
				castbar.safezone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
				castbar.SafeZone = castbar.safezone
			end
			
			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
		

		----- [[     Combat Feedback     ]] -----
		
		if db.combatfeedback == true then
			local CombatFeedbackText 
			CombatFeedbackText = TukuiDB.SetFontString(health, font, font_size, font_style)
			CombatFeedbackText:SetPoint("CENTER", 0, 1)
			CombatFeedbackText.colors = {
				DAMAGE = {0.69, 0.31, 0.31},
				CRUSHING = {0.69, 0.31, 0.31},
				CRITICAL = {0.69, 0.31, 0.31},
				GLANCING = {0.69, 0.31, 0.31},
				STANDARD = {0.84, 0.75, 0.65},
				IMMUNE = {0.84, 0.75, 0.65},
				ABSORB = {0.84, 0.75, 0.65},
				BLOCK = {0.84, 0.75, 0.65},
				RESIST = {0.84, 0.75, 0.65},
				MISS = {0.84, 0.75, 0.65},
				HEAL = {0.33, 0.59, 0.33},
				CRITHEAL = {0.33, 0.59, 0.33},
				ENERGIZE = {0.31, 0.45, 0.63},
				CRITENERGIZE = {0.31, 0.45, 0.63},
			}
			self.CombatFeedbackText = CombatFeedbackText
		end
		
		
		----- [[     Heal Comm     ]] -----

		if db.healcomm then
			local mhpb = CreateFrame('StatusBar', nil, self.Health)
			mhpb:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
			mhpb:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
			if TukuiDB.lowversion then
				mhpb:SetWidth(186)
			else
				mhpb:SetWidth(250)
			end
			mhpb:SetStatusBarTexture(normTex)
			mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
			mhpb:SetMinMaxValues(0,1)

			local ohpb = CreateFrame('StatusBar', nil, self.Health)
			ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
			ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
			ohpb:SetWidth(250)
			ohpb:SetStatusBarTexture(normTex)
			ohpb:SetStatusBarColor(0, 1, 0, 0.25)

			self.HealPrediction = {
				myBar = mhpb,
				otherBar = ohpb,
				maxOverflow = 1,
			}
		end
		
		
		----- [[     Player Aggro     ]] -----
		if db.playeraggro == true then
			table.insert(self.__elements, TukuiDB.UpdateThreat)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', TukuiDB.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', TukuiDB.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', TukuiDB.UpdateThreat)
		end
	end
	
	------------------------------------------------------------------------
	--	Target of Target unit layout
	------------------------------------------------------------------------
	
	if (unit == "targettarget") then
	
		----- [[     Health / Power Bars + Backgrounds / Borders     ]] -----
		
		local health = CreateFrame("StatusBar", nil, self)
		health:SetHeight(TukuiDB.Scale(23))
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(blank)
		self.Health = health

		local hBg = health:CreateTexture(nil, "BORDER")
		hBg:SetAllPoints()
		hBg:SetTexture(.05, .05, .05)
		self.Health.bg = hBg

		local hBorder = CreateFrame("Frame", nil, health)
		hBorder:SetFrameLevel(health:GetFrameLevel() - 1)
		hBorder:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
		hBorder:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
		TukuiDB.SkinPanel(hBorder)
		TukuiDB.Kill(hBorder.bg)
		self.Health.border = hBorder		

		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(TukuiDB.Scale(3))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, TukuiDB.Scale(-7))
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, TukuiDB.Scale(-7))
		power:SetStatusBarTexture(blank)
		self.Power = power
		
		local pBg = power:CreateTexture(nil, "BORDER")
		pBg:SetAllPoints()
		pBg:SetTexture(blank)
		pBg.multiplier = 0.3
		self.Power.bg = pBg
		
		local pBorder = CreateFrame("Frame", nil, power)
		pBorder:SetFrameLevel(power:GetFrameLevel() - 1)
		pBorder:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
		pBorder:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
		TukuiDB.SkinPanel(pBorder)
		TukuiDB.Kill(pBorder.bg)
		self.Power.border = pBorder
		
		----- [[     Health and Power Colors / Settings     ]] -----

		health.frequentUpdates = true
		power.frequentUpdates = true

		if db.showsmooth == true then
			health.Smooth = true
			power.Smooth = true
		end
		
		if db.classcolor then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClass = true
			hBg.multiplier = 0.3
			
			power.colorPower = true
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health.colorReaction = false
			health:SetStatusBarColor(.15, .15, .15)
			-- hBg:SetVertexColor(1, .1, .1)		

			power.colorTapping = true
			power.colorDisconnected = true
			power.colorClass = true
			power.colorReaction = true
		end
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 1)
		Name:SetFont(font, font_size, font_style)
		Name:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
		Name:SetJustifyH("CENTER")

		if db.classcolor then
			self:Tag(Name, '[Tukui:namemedium]')
		else
			self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium]')
		end
		
		self.Name = Name
		
		--
		self:SetAttribute('initial-height', ((health:GetHeight() + 4) + (power:GetHeight() + 4) + 3))
		self:SetAttribute('initial-width', TukuiDB.Scale(130))

		if db.totdebuffs == true then
			local debuffs = CreateFrame("Frame", nil, health)
			debuffs:SetHeight(20)
			debuffs:SetWidth(127)
			debuffs.size = 20
			debuffs.spacing = 2
			debuffs.num = 6

			debuffs:SetPoint("TOPLEFT", health, "TOPLEFT", -0.5, 24)
			debuffs.initialAnchor = "TOPLEFT"
			debuffs["growth-y"] = "UP"
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Debuffs = debuffs
		end
	end
	
	------------------------------------------------------------------------
	--	Pet unit layout
	------------------------------------------------------------------------
	
	if (unit == "pet") then
	
		----- [[     Health / Power Bars + Backgrounds / Borders     ]] -----
		
		local health = CreateFrame("StatusBar", nil, self)
		health:SetHeight(TukuiDB.Scale(23))
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(blank)
		self.Health = health

		local hBg = health:CreateTexture(nil, "BORDER")
		hBg:SetAllPoints()
		hBg:SetTexture(.05, .05, .05)
		self.Health.bg = hBg

		local hBorder = CreateFrame("Frame", nil, health)
		hBorder:SetFrameLevel(health:GetFrameLevel() - 1)
		hBorder:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
		hBorder:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
		TukuiDB.SkinPanel(hBorder)
		TukuiDB.Kill(hBorder.bg)
		self.Health.border = hBorder		

		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(TukuiDB.Scale(3))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, TukuiDB.Scale(-7))
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, TukuiDB.Scale(-7))
		power:SetStatusBarTexture(blank)
		self.Power = power
		
		local pBg = power:CreateTexture(nil, "BORDER")
		pBg:SetAllPoints()
		pBg:SetTexture(blank)
		pBg.multiplier = 0.3
		self.Power.bg = pBg
		
		local pBorder = CreateFrame("Frame", nil, power)
		pBorder:SetFrameLevel(power:GetFrameLevel() - 1)
		pBorder:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
		pBorder:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
		TukuiDB.SkinPanel(pBorder)
		TukuiDB.Kill(pBorder.bg)
		self.Power.border = pBorder
		
		----- [[     Health and Power Colors / Settings     ]] -----

		health.frequentUpdates = true
		power.frequentUpdates = true

		if db.showsmooth == true then
			health.Smooth = true
			power.Smooth = true
		end
		
		if db.classcolor then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClass = true
			if TukuiDB.myclass == "HUNTER" then
				health.colorHappiness = true
			end
			hBg.multiplier = 0.3
			
			power.colorPower = true
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health.colorReaction = false
			health:SetStatusBarColor(.15, .15, .15)
			-- hBg:SetVertexColor(1, .1, .1)		

			power.colorTapping = true
			power.colorDisconnected = true
			power.colorClass = true
			power.colorReaction = true
		end
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 1)
		Name:SetFont(font, font_size, font_style)
		Name:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
		Name:SetJustifyH("CENTER")

		if db.classcolor then
			self:Tag(Name, '[Tukui:namemedium] [Tukui:diffcolor][level]')
		else
			self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level]')
		end
		
		self.Name = Name
		
		--
		self:SetAttribute('initial-height', ((health:GetHeight() + 4) + (power:GetHeight() + 4) + 3))
		self:SetAttribute('initial-width', TukuiDB.Scale(130))
		
		if (db.unitcastbar == true) then
			local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
			castbar:SetStatusBarTexture(blank)
			
			castbar.bg = castbar:CreateTexture(nil, "BORDER")
			castbar.bg:SetAllPoints(castbar)
			castbar.bg:SetTexture(blank)
			castbar.bg:SetVertexColor(0.15, 0.15, 0.15)
			castbar:SetFrameLevel(6)
			castbar:SetPoint("TOPLEFT", health)
			castbar:SetPoint("BOTTOMRIGHT", health)
			
			castbar.CustomTimeText = TukuiDB.CustomCastTimeText
			castbar.CustomDelayText = TukuiDB.CustomCastDelayText
			castbar.PostCastStart = TukuiDB.CheckCast
			castbar.PostChannelStart = TukuiDB.CheckChannel

			castbar.time = TukuiDB.SetFontString(castbar, font, font_size, font_style)
			castbar.time:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
			castbar.time:SetPoint("RIGHT", health, "RIGHT", TukuiDB.Scale(-4), 1)
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = TukuiDB.SetFontString(castbar, font, font_size, font_style)
			castbar.Text:SetShadowOffset(font_shadow and 1 or 0, font_shadow and -1 or 0)
			castbar.Text:SetPoint("LEFT", health, "LEFT", TukuiDB.Scale(4), 1)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			self.Castbar = castbar
			self.Castbar.Time = castbar.time
		end
		
		
		----- [[    Pet Aggro    ]] -----
		
		if db.playeraggro then
			table.insert(self.__elements, TukuiDB.UpdateThreat)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', TukuiDB.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', TukuiDB.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', TukuiDB.UpdateThreat)
		end
		
		-- update pet name, this should fix "UNKNOWN" pet names on pet unit.
		self:RegisterEvent("UNIT_PET", TukuiDB.UpdatePetInfo)
	end


	------------------------------------------------------------------------
	--	Focus unit layout
	------------------------------------------------------------------------
	
	if (unit == "focus") then
		-- create health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetPoint("TOPLEFT")
		health:SetPoint("BOTTOMRIGHT")
		health:SetStatusBarTexture(normTex)
		health:GetStatusBarTexture():SetHorizTile(false)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		health.value = TukuiDB.SetFontString(health, font1, 12, "OUTLINE")
		health.value:SetPoint("RIGHT", health, "RIGHT", TukuiDB.Scale(-4), 0)
		health.PostUpdate = TukuiDB.PostUpdateHealth
		
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("LEFT", health, "LEFT", TukuiDB.Scale(4), 0)
		Name:SetJustifyH("LEFT")
		Name:SetFont(font1, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namelong] [Tukui:diffcolor][level] [shortclassification]')
		self.Name = Name

		-- create focus debuff feature
		if db.focusdebuffs == true then
			local debuffs = CreateFrame("Frame", nil, self)
			debuffs:SetHeight(26)
			debuffs:SetWidth(TukuiCF["panels"].tinfowidth - 10)
			debuffs.size = 26
			debuffs.spacing = 2
			debuffs.num = 40
						
			debuffs:SetPoint("TOPRIGHT", self, "TOPRIGHT", 2, 38)
			debuffs.initialAnchor = "TOPRIGHT"
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Debuffs = debuffs
		end
		
		-- focus cast bar in the center of the screen
		if db.unitcastbar == true then
			local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
			castbar:SetHeight(TukuiDB.Scale(20))
			castbar:SetWidth(TukuiDB.Scale(240))
			castbar:SetStatusBarTexture(normTex)
			castbar:SetFrameLevel(6)
			castbar:SetPoint("CENTER", UIParent, "CENTER", 0, 250)		
			
			castbar.bg = CreateFrame("Frame", nil, castbar)
			TukuiDB.SetTemplate(castbar.bg)
			castbar.bg:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
			castbar.bg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
			castbar.bg:SetFrameLevel(5)
			
			castbar.time = TukuiDB.SetFontString(castbar, font1, 12)
			castbar.time:SetPoint("RIGHT", castbar, "RIGHT", TukuiDB.Scale(-4), 0)
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")
			castbar.CustomTimeText = CustomCastTimeText

			castbar.Text = TukuiDB.SetFontString(castbar, font1, 12)
			castbar.Text:SetPoint("LEFT", castbar, "LEFT", TukuiDB.Scale(4), 0)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			castbar.CustomDelayText = TukuiDB.CustomCastDelayText
			castbar.PostCastStart = TukuiDB.CheckCast
			castbar.PostChannelStart = TukuiDB.CheckChannel
			
			if db.cbicons == true then
				castbar.button = CreateFrame("Frame", nil, castbar)
				castbar.button:SetHeight(TukuiDB.Scale(40))
				castbar.button:SetWidth(TukuiDB.Scale(40))
				castbar.button:SetPoint("CENTER", 0, TukuiDB.Scale(50))
				TukuiDB.SetTemplate(castbar.button)

				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:SetPoint("TOPLEFT", castbar.button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				castbar.icon:SetPoint("BOTTOMRIGHT", castbar.button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
			end

			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
	end
	
	------------------------------------------------------------------------
	--	Focus target unit layout
	------------------------------------------------------------------------

	if (unit == "focustarget") then
		-- create panel if higher version
		local panel = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(panel, 129, 17, "BOTTOM", self, "BOTTOM", 0, 0)
		panel:SetFrameLevel(2)
		panel:SetFrameStrata("MEDIUM")
		panel:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
		self.panel = panel
		
		-- health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(18))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true			
		end
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", panel, "CENTER", 0, 0)
		Name:SetFont(font1, 12)
		Name:SetJustifyH("CENTER")

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level]')
		self.Name = Name
	end

	------------------------------------------------------------------------
	--	Arena or boss units layout (both mirror'd)
	------------------------------------------------------------------------
	
	if (unit and unit:find("arena%d") and TukuiCF["arena"].unitframes == true) or (unit and unit:find("boss%d") and db.showboss == true) then
		-- Right-click focus on arena or boss units
		self:SetAttribute("type2", "focus")
		
		-- health 
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(22))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		health.frequentUpdates = true
		health.colorDisconnected = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		health.colorClass = true
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)

		health.value = TukuiDB.SetFontString(health, font1,12, "OUTLINE")
		health.value:SetPoint("LEFT", TukuiDB.Scale(2), 0)
		health.PostUpdate = TukuiDB.PostUpdateHealth
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
	
		-- power
		local power = CreateFrame('StatusBar', nil, self)
		power:SetHeight(TukuiDB.Scale(6))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = true
		if db.showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		
		power.value = TukuiDB.SetFontString(health, font1, 12, "OUTLINE")
		power.value:SetPoint("RIGHT", TukuiDB.Scale(-2), 0)
		power.PreUpdate = TukuiDB.PreUpdatePower
		power.PostUpdate = TukuiDB.PostUpdatePower
				
		self.Power = power
		self.Power.bg = powerBG
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namelong]')
		self.Name = Name
		
		-- create buff at left of unit if they are boss units
		if (unit and unit:find("boss%d")) then
			local buffs = CreateFrame("Frame", nil, self)
			buffs:SetHeight(26)
			buffs:SetWidth(252)
			buffs:SetPoint("RIGHT", self, "LEFT", TukuiDB.Scale(-4), 0)
			buffs.size = 26
			buffs.num = 3
			buffs.spacing = 2
			buffs.initialAnchor = 'RIGHT'
			buffs["growth-x"] = "LEFT"
			buffs.PostCreateIcon = TukuiDB.PostCreateAura
			buffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Buffs = buffs
		end

		-- create debuff for both arena and boss units
		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(26)
		debuffs:SetWidth(200)
		debuffs:SetPoint('LEFT', self, 'RIGHT', TukuiDB.Scale(4), 0)
		debuffs.size = 26
		debuffs.num = 5
		debuffs.spacing = 2
		debuffs.initialAnchor = 'LEFT'
		debuffs["growth-x"] = "RIGHT"
		debuffs.PostCreateIcon = TukuiDB.PostCreateAura
		debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
		self.Debuffs = debuffs	
				
		-- trinket feature via trinket plugin
		if (TukuiCF.arena.unitframes) and (unit and unit:find('arena%d')) then
			local Trinketbg = CreateFrame("Frame", nil, self)
			Trinketbg:SetHeight(26)
			Trinketbg:SetWidth(26)
			Trinketbg:SetPoint("RIGHT", self, "LEFT", -6, 0)				
			TukuiDB.SetTemplate(Trinketbg)
			Trinketbg:SetFrameLevel(0)
			self.Trinketbg = Trinketbg
			
			local Trinket = CreateFrame("Frame", nil, Trinketbg)
			Trinket:SetAllPoints(Trinketbg)
			Trinket:SetPoint("TOPLEFT", Trinketbg, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			Trinket:SetPoint("BOTTOMRIGHT", Trinketbg, TukuiDB.Scale(-2), TukuiDB.Scale(2))
			Trinket:SetFrameLevel(1)
			Trinket.trinketUseAnnounce = true
			self.Trinket = Trinket
		end
	end

	------------------------------------------------------------------------
	--	Main tanks and Main Assists layout (both mirror'd)
	------------------------------------------------------------------------
	
	if(self:GetParent():GetName():match"oUF_MainTank" or self:GetParent():GetName():match"oUF_MainAssist") then
		-- Right-click focus on maintank or mainassist units
		self:SetAttribute("type2", "focus")
		
		-- health 
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(20))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, '[Tukui:getnamecolor][Tukui:nameshort]')
		self.Name = Name
	end
	
	return self
end

------------------------------------------------------------------------
--	Default position of Tukui unitframes
------------------------------------------------------------------------

-- for lower reso
local adjustX = 0
local adjustY = 0
if TukuiDB.lowversion then adjustX = 80 end
if TukuiDB.lowversion then adjustY = 10 end

oUF:RegisterStyle('Tukz', Shared)

-- player
local player = oUF:Spawn('player', "oUF_Tukz_player")
player:SetPoint("BOTTOM", UIParent, "BOTTOM", -(TukuiDB.Scale(180) - adjustX), TukuiDB.Scale(167 + adjustY))
player:SetSize(player:GetAttribute('initial-width'), player:GetAttribute('initial-height'))

-- focus
local focus = oUF:Spawn('focus', "oUF_Tukz_focus")
focus:SetPoint("BOTTOMRIGHT", oUF_Tukz_player, "TOPLEFT", TukuiDB.Scale(-10), TukuiDB.Scale(200))
focus:SetSize(TukuiDataRight:GetWidth() - TukuiDB.Scale(4), TukuiDataRight:GetHeight() - TukuiDB.Scale(4))

-- target
local target = oUF:Spawn('target', "oUF_Tukz_target")
target:SetPoint("BOTTOM", UIParent, "BOTTOM", (TukuiDB.Scale(180) - adjustX), TukuiDB.Scale(167 + adjustY))
target:SetSize(target:GetAttribute('initial-width'), target:GetAttribute('initial-height'))

-- tot
local tot = oUF:Spawn('targettarget', "oUF_Tukz_targettarget")
if db.charportrait then
	tot:SetPoint("TOPRIGHT", oUF_Tukz_target, "BOTTOMRIGHT", TukuiDB.Scale(63), TukuiDB.Scale(-3))
else
	tot:SetPoint("TOPRIGHT", oUF_Tukz_target, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
end
tot:SetSize(tot:GetAttribute('initial-width'), tot:GetAttribute('initial-height'))

-- pet
local pet = oUF:Spawn('pet', "oUF_Tukz_pet")
if db.charportrait then
	pet:SetPoint("TOPLEFT", oUF_Tukz_player, "BOTTOMLEFT", TukuiDB.Scale(-63), TukuiDB.Scale(-3))
else
	pet:SetPoint("TOPLEFT", oUF_Tukz_player, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
end
pet:SetSize(TukuiDB.Scale(129), TukuiDB.Scale(36))

if db.showfocustarget then 
	local focustarget = oUF:Spawn("focustarget", "oUF_Tukz_focustarget")
	focustarget:SetPoint("BOTTOM", 0, 224)
	focustarget:SetSize(TukuiDB.Scale(129), TukuiDB.Scale(36))
end

if TukuiCF.arena.unitframes then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "oUF_Arena"..i)
		if i == 1 then
			arena[i]:SetPoint("BOTTOM", UIParent, "BOTTOM", 252, 260)
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 10)
		end
		arena[i]:SetSize(TukuiDB.Scale(200), TukuiDB.Scale(29))
	end
end

if db.showboss then
	for i = 1,MAX_BOSS_FRAMES do
		local t_boss = _G["Boss"..i.."TargetFrame"]
		t_boss:UnregisterAllEvents()
		t_boss.Show = TukuiDB.dummy
		t_boss:Hide()
		_G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
		_G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
	end

	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
		if i == 1 then
			boss[i]:SetPoint("BOTTOM", UIParent, "BOTTOM", 252, 260)
		else
			boss[i]:SetPoint('BOTTOM', boss[i-1], 'TOP', 0, 10)             
		end
		boss[i]:SetSize(TukuiDB.Scale(200), TukuiDB.Scale(29))
	end
end

local assisttank_width  = 100
local assisttank_height  = 20
if TukuiCF["unitframes"].maintank == true then
	local tank = oUF:SpawnHeader('oUF_MainTank', nil, 'raid',
		'oUF-initialConfigFunction', ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		'showRaid', true,
		'groupFilter', 'MAINTANK',
		'yOffset', 7,
		'point' , 'BOTTOM',
		'template', 'oUF_tukzMtt'
	)
	tank:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
end
 
if TukuiCF["unitframes"].mainassist == true then
	local assist = oUF:SpawnHeader("oUF_MainAssist", nil, 'raid',
		'oUF-initialConfigFunction', ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		'showRaid', true,
		'groupFilter', 'MAINASSIST',
		'yOffset', 7,
		'point' , 'BOTTOM',
		'template', 'oUF_tukzMtt'
	)
	if TukuiCF["unitframes"].maintank == true then
		assist:SetPoint("TOPLEFT", oUF_MainTank, "BOTTOMLEFT", 2, -50)
	else
		assist:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

-- this is just a fake party to hide Blizzard frame if no Tukui raid layout are loaded.
local party = oUF:SpawnHeader("oUF_noParty", nil, "party", "showParty", true)

------------------------------------------------------------------------
--	Just a command to test buffs/debuffs alignment
------------------------------------------------------------------------

local testui = TestUI or function() end
TestUI = function()
	testui()
	UnitAura = function()
		-- name, rank, texture, count, dtype, duration, timeLeft, caster
		return 'penancelol', 'Rank 2', 'Interface\\Icons\\Spell_Holy_Penance', random(5), 'Magic', 0, 0, "player"
	end
	if(oUF) then
		for i, v in pairs(oUF.units) do
			if(v.UNIT_AURA) then
				v:UNIT_AURA("UNIT_AURA", v.unit)
			end
		end
	end
end
SlashCmdList.TestUI = TestUI
SLASH_TestUI1 = "/testui"

------------------------------------------------------------------------
-- Right-Click on unit frames menu. 
-- Doing this to remove SET_FOCUS eveywhere.
-- SET_FOCUS work only on default unitframes.
-- Main Tank and Main Assist, use /maintank and /mainassist commands.
------------------------------------------------------------------------

do
	UnitPopupMenus["SELF"] = { "PVP_FLAG", "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "DUNGEON_DIFFICULTY", "RAID_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "SELECT_ROLE", "LEAVE", "CANCEL" };
	UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL" };
	UnitPopupMenus["PARTY"] = { "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["RAID_PLAYER"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" };
	UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "RAID_TARGET_ICON", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "CANCEL" };
	UnitPopupMenus["VEHICLE"] = { "RAID_TARGET_ICON", "VEHICLE_LEAVE", "CANCEL" }
	UnitPopupMenus["TARGET"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["ARENAENEMY"] = { "CANCEL" }
	UnitPopupMenus["FOCUS"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["BOSS"] = { "RAID_TARGET_ICON", "CANCEL" }
end


