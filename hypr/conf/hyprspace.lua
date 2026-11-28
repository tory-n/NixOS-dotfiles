if not hl.plugin.Hyprspace then return end
hl.config({
    plugin = {
        overview = {
            panelColor       = "rgb(191724)",
            panelBorderColor = "rgb(cba6f7)",
            workspaceActiveBackground = "rgba(1f1d2ecc)",
            workspaceActiveBorder = "rgb(9ccfd8)",
            onBottom = false,
            autoDrag = true,
            -- Add other overview settings here
        }
    }
})
