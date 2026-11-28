-- Home Manager loads hyprglass on hyprland.start; reload afterwards
-- so conf/hyprglass.lua can see the plugin.
hl.on("hyprland.start", function()
  hl.exec_cmd("sleep 2 && hyprctl reload")
end)

-- Clear the require cache so edits are picked up on every reload.
local function load(name)
  package.loaded["conf." .. name] = nil
  return require("conf." .. name)
end

load("programs")   -- first: binds/autostart use it
load("monitors")
load("env")
load("autostart")
load("appearance")
load("hyprglass")
load("hyprspace")
load("animations")
load("layouts")
load("input")
load("binds")
load("rules")

