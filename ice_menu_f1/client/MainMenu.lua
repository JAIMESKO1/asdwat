ESX = exports["es_extended"]:getSharedObject()

local isMenuOpen = false
local isAdmin = false

RegisterCommand("menu_f1", function()
    if isMenuOpen then
        isMenuOpen = false
        RageUI.CloseAll()
    else
        OpenMainMenu()
    end
end, false)

RegisterKeyMapping("menu_f1", "Menu F1", "keyboard", "F1")

-- Vérifier le statut admin (une seule fois à l'ouverture du menu)
RegisterNetEvent('ice_menu_f1:adminStatus')
AddEventHandler('ice_menu_f1:adminStatus', function(status)
    isAdmin = status
end)

function OpenMainMenu()
    if isMenuOpen then return end
    isMenuOpen = true

    local MainMenu = RageUI.CreateMenu("Menu F1", "Menu principal")
    local AdminMenu

    RageUI.Visible(MainMenu, true)

    CreateThread(function()
        while isMenuOpen do
            RageUI.IsVisible(MainMenu, function()
                -- Ajouter les autres boutons du menu principal
                RageUI.Button("🕺Animation", nil, {}, true, {
                    onSelected = function()
                        print("Menu Animation sélectionné")
                    end
                })

                RageUI.Button("👪Groupes", nil, {}, true, {
                    onSelected = function()
                        print("Menu Groupes sélectionné")
                    end
                })

                RageUI.Button("💼Entreprises", nil, {}, true, {
                    onSelected = function()
                        print("Menu Entreprises sélectionné")
                    end
                })

                RageUI.Button("🚘Véhicules", nil, {}, true, {
                    onSelected = function()
                        print("Menu Véhicules sélectionné")
                    end
                })

                RageUI.Button("⚙️Options", nil, {}, true, {
                    onSelected = function()
                        print("Menu Options sélectionné")
                    end
                })

                -- Affichage du bouton Admin uniquement pour les admins
                if isAdmin then
                    RageUI.Separator()
                    RageUI.Button("✨Administration", nil, {}, true, {
                        onSelected = function()
                            OpenAdminMenu(MainMenu)
                        end
                    })
                end
            end)
            Wait(0)
        end
    end)
end

-- Initialisation du statut admin lors du chargement
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        TriggerServerEvent('ice_menu_f1:checkAdmin')
    end
end)