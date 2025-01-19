ESX = exports["es_extended"]:getSharedObject() 

local activeResources = {}
local inactiveResources = {}

RegisterNetEvent('receiveServerResources')
AddEventHandler('receiveServerResources', function(resources)
    activeResources = {}
    inactiveResources = {}
    for _, resource in ipairs(resources) do
        if resource.state == 'started' then
            table.insert(activeResources, resource)
        else
            table.insert(inactiveResources, resource)
        end
    end
end)

function GetServerResources()
    TriggerServerEvent('getServerResources')
end

function DisplayResources(title, resources, actionFunction, resourceMenu, query)
    RageUI.Separator(title)
    if #resources == 0 then
        RageUI.Separator(" Aucune " )
    else
        table.sort(resources, function(a, b) return a.name:lower() < b.name:lower() end)
        for _, resource in ipairs(resources) do
            if query == "" or string.find(resource.name:lower(), query:lower()) then
                RageUI.Button(resource.name, nil, {}, true, {
                    onSelected = function()
                        actionFunction(resource.name, resourceMenu)
                    end
                }, resourceMenu)
            end
        end
    end
end

function OpenResourceActions(resource, resourceMenu)
    local actionMenu = RageUI.CreateMenu("Actions", "Gérer " .. resource)
    RageUI.Visible(actionMenu, true)

    CreateThread(function()
        while RageUI.Visible(actionMenu) do
            RageUI.IsVisible(actionMenu, function()
                ResourceActionButton("Arrêter", resource, 'stop', resourceMenu)
                ResourceActionButton("Redémarrer", resource, 'restart', resourceMenu)
                ResourceActionButton("Recharger", resource, 'refresh', resourceMenu)
                ResourceActionButton("Voir Détails", resource, 'details', resourceMenu)
            end)
            Wait(1)
        end
    end)
end

function OpenResourceActionsStart(resource, resourceMenu)
    local actionMenu = RageUI.CreateMenu("Actions", "Gérer " .. resource)
    RageUI.Visible(actionMenu, true)

    CreateThread(function()
        while RageUI.Visible(actionMenu) do
            RageUI.IsVisible(actionMenu, function()
                ResourceActionButton("Démarrer", resource, 'start', resourceMenu)
                ResourceActionButton("Voir Détails", resource, 'details', resourceMenu)
            end)
            Wait(1)
        end
    end)
end

function ResourceActionButton(label, resource, action, resourceMenu)
    RageUI.Button(label, nil, {}, true, {
        onSelected = function()
            if action == 'details' then
                OpenResourceDetails(resource)
            else
                TriggerServerEvent('manageServerResource', resource, action)
                ESX.ShowNotification("La ressource " .. resource .. " a été " .. label:lower() .. "ée.")
                GetServerResources()
            end
        end
    }, resourceMenu)
end

function OpenResourceDetails(resource)
    local detailsMenu = RageUI.CreateMenu("Détails", "Détails de " .. resource)
    RageUI.Visible(detailsMenu, true)

    CreateThread(function()
        while RageUI.Visible(detailsMenu) do
            RageUI.IsVisible(detailsMenu, function()
                RageUI.Separator("Nom: " .. resource)
                -- Ajouter d'autres détails ici
            end)
            Wait(1)
        end
    end)
end
