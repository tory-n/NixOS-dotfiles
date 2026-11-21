-- Gaps, borders, rounding, opacity, shadow, blur.
hl.config({
    general = {
        gaps_in  = 10,
        gaps_out = { top = 10, right = 10, bottom = 10, left = 10 },

        border_size = 2,
        col = {
            active_border   = "rgb(1e1e1e)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 0.75,
        inactive_opacity = 0.75,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 4,
            passes   = 3,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled              = true,
        workspace_wraparound = true,
    },
})
