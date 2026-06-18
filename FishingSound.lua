FishingSound = FishingSound or {}
local FS = FishingSound

------------------------------------------------------------
--  VARIABLES: 
------------------------------------------------------------

--[[
List of Good SoundIDs to use for fishing bite: NEEDS TO BE CONSTANT VALUE


ABILITY_SYNERGY_READY
ABILITY_ULTIMATE_READY
ACTIVE_SKILL_MORPG_CHOSEN
ANTIQUITIES_FANFARE_COMPLETED
ARMORY_OPEN
AVA_GATE_OPENED
BATTLEGROUND_CAPTURE_AREA_CAPTURED_OTHER_TEAM
BATTLEGROUND_CAPTURE_AREA_CAPTURED_OWN_TEAM
BATTLEGROUND_CAPTURE_AREA_SPAWNED
BATTLEGROUND_CAPTURE_AREA_MOVED
BATTLEGROUND_COUNTDOWN_FINISH
BATTLEGROUND_FINAL_ROUND_STARTING
BATTLEGROUND_MATCH_WON
BATTLEGROUND_NEARING_VICTORY
CHALLENGE_DIFFICULTY_CHANGE_DIFFICULTY_BUTTON_CLICKED
CHAMPTION_POINTS_GAINED
CHAMPTION_POINTS_COMMITED
--]]

local savedVariables 

FS.reelInSound = nil
FS.addonLoaded = false
FS.playerLoaded = false
FS.disableFishingSound = false


------------------------------------------------------------
--  METHODS: SAVED VARIABBLES METHODS
------------------------------------------------------------


local function getDisableFishingSound()
    if savedVariables then
        return savedVariables.disableFishingSound
    else
        return false
    end
end     


local function setDisableFishingSound(value)
    if savedVariables then
        savedVariables.disableFishingSound = value
    end
end



local function getReelInSound()
    if savedVariables then
        return savedVariables.reelInSound
    else
        return "ABILITY_SYNERGY_READY"
    end
end


local function setReelInSound(value)
    if savedVariables then
        savedVariables.reelInSound = value
    end
end


------------------------------------------------------------
--  METHODS: BACKEND METHODS
------------------------------------------------------------



local function OnVibration(eventCode, p1, p2, p3, p4, p5)
    
    if getDisableFishingSound() == false then 

        --d(string.format("Vibration: %s | %s | %s | %s | %s", p1, p2, p3, p4, p5))

        -- Fishing bite detection
        if p1 == 2500 and p2 > 0 and p3 > 0 then
                --d("Fishing bite detected!")

                PlaySound(SOUNDS[getReelInSound()])
        end

    end 
end




local function FS_TryInitialize()
        
        --d("FishingSound: TryInitialize " .. tostring(FS.addonLoaded) .. " " .. tostring(FS.playerLoaded))

        if FS.addonLoaded and FS.playerLoaded then
                --d("FishingSound: Fully initialized, registering fishing event")
                
                --LibAddonMenu2 Settings 
                local LAM = LibAddonMenu2
                local panelData = {
                    type = "panel",
                    name = "FishingSound",
                    author = "@FloIstImGame"
                }

                local optionsData = {
                      [1] =  {
                                type = "checkbox",
                                name = "Disable Fishing Sound",
                                tooltip = "Toggle the fishing sound on or off.",
                                getFunc = function() return getDisableFishingSound() end,
                                setFunc = function(value) setDisableFishingSound(value) end
                        },
                       [2] = {
                                type = "dropdown",
                                name = "Fishing Bite Sound",
                                tooltip = "Select the sound to play when a fishing bite is detected.",
                                choices = {
                                    "ABILITY_SYNERGY_READY",
                                    "ABILITY_ULTIMATE_READY",
                                    "ACTIVE_SKILL_MORPG_CHOSEN",
                                    "ANTIQUITIES_FANFARE_COMPLETED",
                                    "ARMORY_OPEN",
                                    "AVA_GATE_OPENED",
                                    "BATTLEGROUND_CAPTURE_AREA_CAPTURED_OTHER_TEAM",
                                    "BATTLEGROUND_CAPTURE_AREA_CAPTURED_OWN_TEAM",
                                    "BATTLEGROUND_CAPTURE_AREA_SPAWNED",
                                    "BATTLEGROUND_CAPTURE_AREA_MOVED",
                                    "BATTLEGROUND_COUNTDOWN_FINISH",
                                    "BATTLEGROUND_FINAL_ROUND_STARTING",
                                    "BATTLEGROUND_MATCH_WON",
                                    "BATTLEGROUND_NEARING_VICTORY",
                                    "CHALLENGE_DIFFICULTY_CHANGE_DIFFICULTY_BUTTON_CLICKED",
                                    "CHAMPTION_POINTS_GAINED",
                                    "CHAMPTION_POINTS_COMMITED"
                                },
                                getFunc = function() return getReelInSound() end,
                                setFunc = function(value) setReelInSound(value) end
                        }

                       

                }
                local panel = LAM:RegisterAddonPanel("FishingSound", panelData)

                LAM:RegisterOptionControls("FishingSound", optionsData)

                -- Register for vibration events to detect fishing bites
                EVENT_MANAGER:RegisterForEvent("FishingSound_Vibration", EVENT_VIBRATION, OnVibration)


        end
end




local function FS_AddonLoaded (event, addonName)
        if addonName ~= "FishingSound"  then return end

        FS.addonLoaded = true
        EVENT_MANAGER:UnregisterForEvent("FS_AddonLoaded", EVENT_ADD_ON_LOADED)

        local defaults = {
            disableFishingSound = false , 
            reelInSound = SOUNDS.ABILITY_SYNERGY_READY
        }
        savedVariables = ZO_SavedVars:NewAccountWide("FishingSoundVars", 1, nil, defaults)



        FS_TryInitialize()

end


local function OnPlayerActivated()
        
        if FS.playerLoaded then return end
        
        --d("FishingSound: Player activated")
        FS.playerLoaded = true

        FS_TryInitialize()
end




------------------------------------------------------------
--  EVENTs REIGSTERING: 
------------------------------------------------------------


EVENT_MANAGER:RegisterForEvent("FS_AddonLoaded", EVENT_ADD_ON_LOADED, FS_AddonLoaded)

EVENT_MANAGER:RegisterForEvent("FishingSound_PlayerActivated", EVENT_PLAYER_ACTIVATED, OnPlayerActivated)



------------------------------------------------------------
--  SLASH COMMANDS 
------------------------------------------------------------
SLASH_COMMANDS["/fishingsoundon"] = function()
    setDisableFishingSound(false)
    d("FishingSound: Fishing sound enabled")
end

SLASH_COMMANDS["/fishingsoundoff"] = function()
    setDisableFishingSound(true)
    d("FishingSound: Fishing sound disabled")
end


