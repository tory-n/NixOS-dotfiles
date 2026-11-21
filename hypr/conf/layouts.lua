-- Per-workspace layouts and layout settings.
hl.workspace_rule({ workspace = "1", layout = "tiled" })
hl.workspace_rule({ workspace = "3", layout = "scrolling" })
hl.workspace_rule({ workspace = "4", layout = "master" })

hl.config({
    dwindle = { preserve_split = true },
    master  = { new_status = "master" },
    scrolling = {
        fullscreen_on_one_column = true,
        focus_fit_method         = 0,
        follow_focus             = true,
        follow_min_visible       = 0.9,
        wrap_focus               = true,
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})
