-- Define the path to the file where custom names will be saved
local dataFilePath = "resources/namechange/custom_names.json"

-- Define a table to store custom player data
local playerData = {}

-- Define a table to map color numbers to their corresponding color codes
local colorMapping = {
    [1] = "^1", -- Red
    [2] = "^2", -- Green
    [3] = "^3", -- Yellow
    [4] = "^4", -- Blue
    [5] = "^5", -- Light Purple
    [6] = "^6", -- Orange
    [7] = "^7", -- White
    [8] = "^8", -- Gray
    [9] = "^9", -- Pink
    [10] = "^0" -- Black
}

-- Function to notify a player
function NotifyPlayer(playerId, message)
    TriggerClientEvent('chatMessage', playerId, 'SYSTEM', {255, 0, 0}, message)
end

-- Function to broadcast a chat message to all players
function BroadcastMessage(sender, message, messageType)
    -- messageType can be 'chat', 'customChat', or other types as needed
    if messageType == 'customChat' then
        TriggerClientEvent('chatMessage', -1, '[Chat] ' .. sender, {255, 0, 0}, message)
    else
        TriggerClientEvent('chatMessage', -1, sender, {255, 0, 0}, message)
    end
end

-- Function to handle regular chat messages and send them to the custom chat area
AddEventHandler('chatMessage', function(source, name, message)
    local playerId = source
    local playerName = GetCustomPlayerName(playerId) -- Use custom name

    -- Broadcast the chat message to the custom chat area
    BroadcastMessage(playerName, message, 'customChat')

    -- Cancel the original chat message to prevent it from being displayed twice
    CancelEvent()
end)

-- Load custom names from the file when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        LoadPlayerData()
    end
end)

-- Function to load custom names from the file
function LoadPlayerData()
    local file = LoadResourceFile(GetCurrentResourceName(), dataFilePath)
    if file then
        playerData = json.decode(file)
    else
        playerData = {}
        SavePlayerData() -- Create the file if it doesn't exist
    end
end

-- Function to save custom data to the file
function SavePlayerData()
    local dataToSave = json.encode(playerData)
    SaveResourceFile(GetCurrentResourceName(), dataFilePath, dataToSave, -1)
end

-- Periodic Data Saving Function (Pseudocode)
-- Schedule this function to run at regular intervals, e.g., every 10 minutes
function PeriodicSave()
    SavePlayerData()
end
-- [Add code to schedule 'PeriodicSave']

-- Define the command to set custom names and colors
RegisterCommand('char', function(source, args, rawCommand)
    local playerId = source

    -- Input validation (Pseudocode)
    -- [Add checks for args[1] length, forbidden characters, etc.]

    local playerName = GetPlayerName(playerId)
    if args[1] then
        local newName = args[1]
        local colorNumber = tonumber(args[2])
        if colorNumber and colorMapping[colorNumber] then
            newName = colorMapping[colorNumber] .. newName
        end

        -- Store the custom name for the player
        playerData[playerId] = {name = newName}

        local message = playerName .. " is now known as " .. newName
        BroadcastMessage('SYSTEM', message, 'chat')
        SavePlayerData() -- Save the custom data to the file
    else
        NotifyPlayer(playerId, 'Usage: /char [new name] [color number]')
        NotifyPlayer(playerId, 'Color Codes: ^1 Red, ^2 Green, ^3 Yellow, ^4 Blue, ^5 Light Purple, ^6 Orange, ^7 White, ^8 Gray, ^9 Pink, ^0 Black')
    end
end, false)

-- Function to get the custom name for a player
function GetCustomPlayerName(playerId)
    local data = playerData[playerId]
    if data then
        local customName = data.name
        return customName
    else
        return GetPlayerName(playerId)
    end
end

-- Command to view custom name
RegisterCommand('showname', function(source, args, rawCommand)
    local playerId = source
    local customName = GetCustomPlayerName(playerId)
    NotifyPlayer(playerId, 'Your custom name: ' .. customName)
end, false)

-- Save custom data when a player disconnects
AddEventHandler('playerDropped', function()
    local playerId = source
    if playerData[playerId] then
        -- Save only the data for the disconnecting player
        -- [Modify 'SavePlayerData' or create a new function to save individual player data]
        playerData[playerId] = nil
    end
end)