-- RELAX Loader (Performance Mode)
-- Dibuat khusus untuk Delta Android (Anti-Crash)

local base = "https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/"

local function safeGet(file)
    local url = base .. file .. "?cache=" .. math.random(1,9999999)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)
    if ok then return res else return nil end
end

-- Cek UI
local ui = safeGet("relax_ui.lua")
if not ui then
    warn("RELAX Loader: Gagal load relax_ui.lua")
    return
end

-- Cek fitur
local features = safeGet("system_broken_full.lua")
if not features then
    warn("RELAX Loader: Gagal load system_broken_full.lua")
    return
end

-- Jalankan UI dulu
local okUI, msgUI = pcall(function()
    loadstring(ui)()
end)

if not okUI then
    warn("RELAX Loader: UI error ->", msgUI)
else
    print("RELAX UI Loaded")
end

-- Jalankan fitur System Broken (Full Version)
local okFeat, msgFeat = pcall(function()
    loadstring(features)()
end)

if not okFeat then
    warn("RELAX Loader: Features error ->", msgFeat)
else
    print("RELAX Features Loaded")
end

print("RELAX Loader: Selesai ✓")
