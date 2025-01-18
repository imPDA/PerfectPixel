PP.gameMenuInGameScene = function()
--===============================================================================================--
	local SV_VER		= 0.1
	local DEF = {
		addons_toggle	= true,
	}
	local SV = ZO_SavedVars:NewAccountWide(PP.ADDON_NAME, SV_VER, "GameMenuScene", DEF, GetWorldName())
	---------------------------------------------
	table.insert(PP.optionsData,
	{	type				= "submenu",
		name				= GetString(PP_LAM_SCENE_GAME_MENU),
		controls = {
			{	type				= "header",
				name				= GetString(PP_LAM_SCENE_GAME_MENU_ADDONS),
			},
			{	type				= "checkbox",
				name				= GetString(PP_LAM_ACTIVATE),
				getFunc				= function() return SV.addons_toggle end,
				setFunc				= function(value) SV.addons_toggle = value end,
				default				= DEF.addons_toggle,
				requiresReload		= true,
			},
		},
	})
--===============================================================================================--

	local gameMenuInGameScene = SCENE_MANAGER:GetScene('gameMenuInGame')

--ADD-ONS------------------------------------------------------------------------------------------
	if SV.addons_toggle then
		PP:CreateBackground(ZO_AddOns, --[[#1]] nil, nil, nil, 2, -4, --[[#2]] nil, nil, nil, 4, -2)

		ZO_AddOnsBGLeft:SetHidden(true)
		ZO_AddOnsDivider:SetHidden(true)

		PP.ScrollBar(ZO_AddOnsList,	--[[sb_c]] 180, 180, 180, 0.7, --[[bd_c]] 20, 20, 20, 0.7, false)

		PP.Anchor(ZO_AddOnsTitle,					--[[#1]] TOPLEFT, nil, TOPLEFT, 10, 5)
		PP.Anchor(ZO_AddOnsList,					--[[#1]] TOPLEFT, ZO_AddOnsTitle, BOTTOMLEFT, 0, 5,		--[[#2]] true, BOTTOMRIGHT, ZO_AddOns, BOTTOMRIGHT, 0, -10)
		PP.Anchor(ZO_AddOnsCharacterSelectDropdown,	--[[#1]] LEFT, ZO_AddOnsTitle, RIGHT, 50, 1)

		PP.Font(ZO_AddOnsPrimaryButtonKeyLabel,		--[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
		PP.Font(ZO_AddOnsPrimaryButtonNameLabel,	--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
		PP.Font(ZO_AddOnsSecondaryButtonKeyLabel,	--[[Font]] PP.f.u57, 16, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
		PP.Font(ZO_AddOnsSecondaryButtonNameLabel,	--[[Font]] PP.f.u67, 18, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)
		PP.Font(ZO_AddOnsTitle,						--[[Font]] PP.f.u67, 22, "outline", --[[Alpha]] nil, --[[Color]] nil, nil, nil, nil, --[[StyleColor]] 0, 0, 0, 0.5)

		ZO_Scroll_SetMaxFadeDistance(ZO_AddOnsList, 10)
--[[?]]
		local reAnchored = false
		local function reAnchorAddonsUINow()
			PP.Anchor(ZO_AddOns, --[[#1]] TOPLEFT, GuiRoot, TOPLEFT, 250, 50, --[[#2]] true, BOTTOMRIGHT, GuiRoot, BOTTOMLEFT, 1200, -70)
			-- gameMenuInGameScene:UnregisterCallback("StateChange",  SceneStateChange)
			reAnchored = true


		end

		local function SceneStateChange(oldState, newState)
			if newState == SCENE_SHOWING then
				--Make the addon UI movable again if AddonSelector addon is enabled
				if AddonSelector == nil then
					reAnchorAddonsUINow()
				end
			elseif newState == SCENE_SHOWN then
				ZO_AddOnsList2Row1Divider:SetHidden(true)
			end
		end
		ADDONS_FRAGMENT:RegisterCallback("StateChange",  SceneStateChange)

		ZO_PreHookHandler(ZO_AddOns, 'OnEffectivelyShown', function()
			SetFullscreenEffect(FULLSCREEN_EFFECT_CHARACTER_FRAMING_BLUR, 0.75, 0.75)
		end)
		ZO_PreHookHandler(ZO_AddOns, 'OnEffectivelyHidden', function()
			SetFullscreenEffect(FULLSCREEN_EFFECT_NONE)
		end)
--[[?]]
	end

	--OPTIONS------------------------------------------------------------------------------------------
	-- ==ZO_GameMenu==--
	if ZO_GameMenu_InGame then
		PP.ScrollBar(ZO_OptionsWindowSettingsScrollBar)
		PP.Anchor(ZO_OptionsWindowSettingsScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
		ZO_Scroll_SetMaxFadeDistance(ZO_OptionsWindowSettingsScrollBar, PP.savedVars.ListStyle.list_fade_distance)
		PP.ScrollBar(ZO_GameMenu_InGameNavigationContainerScrollBar)
		PP.Anchor(ZO_GameMenu_InGameNavigationContainerScrollBar, --[[#1]] nil, nil, nil, nil, nil, --[[#2]] true, nil, nil, nil, nil, nil)
		ZO_Scroll_SetMaxFadeDistance(ZO_GameMenu_InGameNavigationContainer, PP.savedVars.ListStyle.list_fade_distance)
		ZO_SharedThinLeftPanelBackgroundLeft:SetHidden(true)
		ZO_SharedThinLeftPanelBackgroundRight:SetHidden(true)
		ZO_OptionsWindowBGLeft:SetHidden(true)

		PP:CreateBackground(ZO_OptionsWindow,		--[[#1]] TOPLEFT, ZO_OptionsWindow, TOPLEFT, 40, 60, --[[#2]] BOTTOMRIGHT, ZO_OptionsWindow, BOTTOMRIGHT, -100, -50)
	end

	--CONTROLS-----------------------------------------------------------------------------------------
	ZO_KeybindingsLeft:SetHidden(true)
	ZO_KeybindingsRight:SetHidden(true)
	--PP.Anchor(ZO_KeybindingsList,			--[[#1]] TOPLEFT, ZO_AddOnsTitle, TOPLEFT, 20, 40,		--[[#2]] true, BOTTOMRIGHT, ZO_AddOns, BOTTOMRIGHT, -10, -40)
	PP:CreateBackground(ZO_Keybindings,		--[[#1]] nil, nil, nil, -6, 0, --[[#2]] nil, nil, nil, 0, 6)
	PP.ScrollBar(ZO_KeybindingsListScrollBar)
	
end