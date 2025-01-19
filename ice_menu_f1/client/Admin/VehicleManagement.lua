ESX = exports["es_extended"]:getSharedObject() 

function SpawnVehicle(vehicleName)
    local playerPed = PlayerPedId()
    local currentVehicle = GetVehiclePedIsIn(playerPed, false)
    
    if currentVehicle ~= 0 then
        ESX.Game.DeleteVehicle(currentVehicle)
    end

    local coords = GetEntityCoords(playerPed)
    ESX.Game.SpawnVehicle(vehicleName, coords, GetEntityHeading(playerPed), function(vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    end)
end

function RepairVehicle()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        SetVehicleFixed(vehicle)
        SetVehicleDirtLevel(vehicle, 0)
        ESX.ShowNotification("Votre véhicule a été réparé.")
    else
        ESX.ShowNotification("Vous devez être dans un véhicule pour le réparer.")
    end
end

function GetVehicleSuggestions()
    local vehicles = {
        "adder", "banshee", "comet", "dominator", "elegy", "futo", "gauntlet", "infernus", "jester", "kuruma"
        -- Add more vehicle names as needed
    }
    return vehicles
end
