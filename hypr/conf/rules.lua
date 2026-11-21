-- Window rules
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class = "^$", title = "^$",
        xwayland = true, float = true, fullscreen = false, pin = false,
    },
    no_focus = true,
})

-- Keep Zen fully opaque
hl.window_rule({
    match  = { class = "zen-beta" },
    opaque = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "reaper-floating-popups",
    match = { class = "^(REAPER)$", float = true },
    move  = "cursor -50% -50%",
})

-- Layer rules
hl.layer_rule({ match = { namespace = "vicinae"  }, blur = true })
hl.layer_rule({ match = { namespace = "main"     }, blur = true })
hl.layer_rule({ match = { namespace = "nwg-dock" }, blur = true })
