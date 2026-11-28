hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:super",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,   -- -1.0 to 1.0, 0 = no modification

        touchpad = { natural_scroll = true },
    },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "scroll_move", swipe_distance = 300 })
hl.gesture({ 
  fingers = 4, 
  direction = "vertical",   
  action = function()
    if hl.plugin.Hyprspace then hl.plugin.Hyprspace.overview("toggle") end
  end,
})

-- Example per-device config
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })
