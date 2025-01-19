ESX = exports["es_extended"]:getSharedObject() 

function NuiKeyboardInput(textEntry, inputText, maxLength, suggestions)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openKeyboard",
        textEntry = textEntry,
        inputText = inputText,
        maxLength = maxLength,
        suggestions = suggestions or {}
    })

    local input = nil
    local done = false

    RegisterNUICallback('keyboardResult', function(data, cb)
        input = data.input
        done = true
        cb('ok')
    end)

    RegisterNUICallback('getSuggestions', function(data, cb)
        local query = data.query:lower()
        local filteredSuggestions = {}
        for _, suggestion in ipairs(suggestions) do
            if string.find(suggestion:lower(), query) then
                table.insert(filteredSuggestions, suggestion)
            end
        end
        cb({ suggestions = filteredSuggestions })
    end)

    while not done do
        Wait(0)
    end

    SetNuiFocus(false, false)
    return input
end
