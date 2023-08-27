if Holo:ShouldModify("HUD", "Teammate") then
	if Holo.Options:GetValue("AltTeammate") then
		Hooks:PostHook(HUDTeammate, "init", "HoloUIDownIndicatorFixTeammateInit", function(self)
			local revive_panel = self._player_panel:child("revive_panel")
			local revive_amount = revive_panel:child("revive_amount")
			local revive_arrow = revive_panel:child("revive_arrow")
			local revive_bg = revive_panel:child("revive_bg")

			local me = self._main_player
			local large_tm = me and not Holo.Options:GetValue("MyName")
			local compact = self._forced_compact or (self._ai or not me and Holo.Options:GetValue("CompactTeammate"))
			local font_size = compact and (me and 28 or 24) or (me and (large_tm and 24 or 18) or 14)

			local name = self._panel:child("name")
			local name_bg = self._panel:child("name_bg")

			revive_panel:set_size(name:h() - 1, name_bg:h())
			revive_amount:set_size(revive_panel:w(), revive_panel:h())
			revive_amount:set_center_y(revive_panel:h() / 2)
			revive_amount:set_font_size(font_size)
			revive_arrow:set_visible(false)
			revive_bg:set_visible(false)
		end)

		Hooks:PostHook(HUDTeammate, "set_revives_amount", "HoloUIDownIndicatorSetRevivesAmount", function(self, revive_amount)
			if revive_amount then
				local teammate_panel = self._panel:child("player")
				local revive_panel = teammate_panel:child("revive_panel")
				local revive_amount_text = revive_panel:child("revive_amount")

				if revive_amount_text then
					local colors = { Color(255, 223, 15, 15) / 255, Color(255, 255, 130, 130) / 255, Color(255, 255, 255, 255) / 255, Color(255, 255, 255, 255) / 255 }
					revive_amount_text:set_color(colors[revive_amount] or colors[4])
				end
			end
		end)

		Hooks:PostHook(HUDManager, "align_teammate_panels", "HoloUIDownIndicatorFixAlignPanels", function(self)
			local function align(tm)
				local weapons_panel = tm._player_panel:child("weapons_panel")
				local primary_weapon_panel = weapons_panel:child("primary_weapon_panel")
				local revive_panel = tm._player_panel:child("revive_panel")
				local name_bg = tm._panel:child("name_bg")

				revive_panel:set_x(weapons_panel:x())
				revive_panel:set_center_y(name_bg:y() + name_bg:h() / 2)
			end

			for _, tm in pairs(self._teammate_panels) do
				align(tm)
			end
		end)
	else
		Hooks:PostHook(HUDManager, "align_teammate_panels", "NAHFEsMemesAlignPanels", function(self)
			local function align(tm)
				local revive_panel = tm._player_panel:child("revive_panel")
				local name_bg = tm._panel:child("Namebg")
				local name = tm._panel:child("name")

				revive_panel:set_x(tm._player_panel:x())
				revive_panel:set_center_y(name_bg:y() + name_bg:h() / 2)
				name_bg:set_left(revive_panel:w())
				name:set_position(name_bg:x() + 4, name_bg:y() + 2)
			end

			for _, tm in pairs(self._teammate_panels) do
				align(tm)
			end
		end)
	end
end
