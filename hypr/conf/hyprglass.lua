-- Hyprglass settings. Does nothing until the plugin is loaded.
local hg = hl.plugin.hyprglass
if not hg then return end
local function tint(c, alpha)
    return tonumber(c:match("%x%x%x%x%x%x"), 16) * 256 + math.floor(alpha * 255 + 0.5)
end

hg.config({
    enabled        = true,
    default_theme  = "dark",
    default_preset = "glass",
    tint_color     = 0x8899aa22,

    brightness = 0.8,
    dark  = { brightness = 0.82 },
    light = { adaptive_boost = 0 },

    layers = { enabled = true },
})

-- Layer surfaces: each call whitelists the namespace and configures it
hg.layer("waybar", { preset = "subtle", mask_threshold = 0.05 })
hg.layer("swaync")
hg.layer("quickshell:bezel", { preset = "ui", mask_threshold = 0.3 })
hg.layer("debug-panel", { exclude = true })

-- Presets
hg.preset("clear", {
    glass_opacity = 0.8,
    blur_strength = 3.5,
    dark  = { brightness = 0.7 },
    light = { brightness = 1.2 },
})

hg.preset("contrasted", {
    inherits     = "high_contrast",
    contrast     = 1.2,
    adaptive_dim = 1.5,
    dark = { tint_color = 0x02142aa9 },
})

hg.preset("glass", {
    glass_opacity        = 0.99,
    blur_strength        = 2.5,
    blur_iterations      = 2,
    chromatic_aberration = 0.2,
    fresnel_strength     = 0.1,
    edge_thickness       = 0.02,
    tint_color           = tint("000000", 0.02),
    lens_distortion      = 0.1,
    contrast             = 1.0,
    saturation           = 1.0,
    vibrancy             = 1.0,
    vibrancy_darkness    = 1.0,
    adaptive_boost       = 0.0,
    dark  = { brightness = 1.2 },
    light = { brightness = 1.2 },
})
