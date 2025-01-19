ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('getServerResources')
AddEventHandler('getServerResources', function()
    local resources = {}

    for i = 0, GetNumResources() - 1 do
        local resourceName = GetResourceByFindIndex(i)
        local resourceState = GetResourceState(resourceName)

        table.insert(resources, {name = resourceName, state = resourceState})
    end

    TriggerClientEvent('receiveServerResources', source, resources)
end)

RegisterNetEvent('manageServerResource')
AddEventHandler('manageServerResource', function(resource, action)
    if action == 'start' then
        StartResource(resource)
    elseif action == 'stop' then
        StopResource(resource)
    elseif action == 'restart' then
        StopResource(resource)
        Wait(500) -- Petite pause pour éviter des erreurs lors du redémarrage
        StartResource(resource)
    end
end)


RegisterNetEvent('ice_menu_f1:checkAdmin')
AddEventHandler('ice_menu_f1:checkAdmin', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.getGroup() == 'admin' then
        TriggerClientEvent('ice_menu_f1:adminStatus', source, true)
    else
        TriggerClientEvent('ice_menu_f1:adminStatus', source, false)
    end
end)






-- Crée l'événement côté client pour effectuer le revive
RegisterNetEvent("myServer:revivePlayer")
AddEventHandler("myServer:revivePlayer", function()
    local ped = PlayerPedId()

    -- Réanime le joueur
    if IsEntityDead(ped) then
        local coords = GetEntityCoords(ped)
        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
        SetEntityHealth(ped, 200) -- Fixer la santé à 200 (santé max)
        ClearPedTasksImmediately(ped) -- Nettoyer les animations ou états
        print("Vous avez été revive.")
    else
        print("Vous n'êtes pas mort.")
    end
end)

