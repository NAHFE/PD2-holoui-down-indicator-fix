if Holo:ShouldModify("HUD", "Teammate") then
	Hooks:PostHook(HUDManager, "align_teammate_panels", "NAHFEsMemesAlignPanels", function(self)
		local function align(tm)
			local revive_panel = tm._player_panel:child("revive_panel")
			local name_bg = tm._panel:child("Namebg")
			local name = tm._panel:child("name")
			
			revive_panel:set_x(tm._player_panel:x())
			revive_panel:set_center_y(name_bg:y() + name_bg:h() / 2)
			name_bg:set_left(revive_panel:w())
			name:set_x(name_bg:x() + 4)
		end
		
		for _, tm in pairs(self._teammate_panels) do
			align(tm)
		end
	end)
end