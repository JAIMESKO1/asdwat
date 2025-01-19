local activeResources = {}
local inactiveResources = {}

function OpenAdminMenu(MainMenu)
    local AdminMenu = RageUI.CreateSubMenu(MainMenu, "Menu Administration", "Options d'administration")
    local GestionServeurMenu = RageUI.CreateSubMenu(AdminMenu, "Gestion Serveur", "Options de gestion du serveur")
    local GestionVehiculeMenu = RageUI.CreateSubMenu(AdminMenu, "Gestion Véhicule", "Options de gestion des véhicules")
    local resourceMenu = RageUI.CreateSubMenu(GestionServeurMenu, "Ressources", "Gérer les ressources")

    RageUI.Visible(AdminMenu, true)

    CreateThread(function()
        while RageUI.Visible(AdminMenu) or RageUI.Visible(GestionServeurMenu) or RageUI.Visible(resourceMenu) or RageUI.Visible(GestionVehiculeMenu) do
            RageUI.IsVisible(AdminMenu, function()
                RageUI.Button("Gestion Serveur", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function() 
                        print("Option 1 sélectionnée")
                    end
                }, GestionServeurMenu)

                RageUI.Button("Gestion Joueur", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function() 
                        print("Option 2 sélectionnée")
                    end
                })

                RageUI.Button("Gestion Véhicule", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function() 
                        print("Option 3 sélectionnée")
                    end
                },GestionVehiculeMenu)
                
                RageUI.Separator()
            end)

            RageUI.IsVisible(GestionServeurMenu, function()
                RageUI.Button("Ressources", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function()
                        GetServerResources()
                    end
                }, resourceMenu)

                RageUI.Button("Logs", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function()
                        print("Option 2 sélectionnée")
                    end
                })

                RageUI.Button("Paramètres", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function()
                        print("Option 3 sélectionnée")
                    end
                })
            end)

            RageUI.IsVisible(resourceMenu, function()
                RageUI.Button("Rechercher", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function()
                        local input = NuiKeyboardInput("Recherche de ressource", "", 50)
                        if input then
                            searchQuery = input
                        end
                    end
                })

                DisplayResources("Ressources Actives", activeResources, OpenResourceActions, resourceMenu, searchQuery)
                DisplayResources("Ressources Inactives", inactiveResources, OpenResourceActionsStart, resourceMenu, searchQuery)

            end)

            RageUI.IsVisible(GestionVehiculeMenu,function()
                RageUI.Button("Spawn Véhicule", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function()
                        local suggestions = GetVehicleSuggestions()
                        local input = NuiKeyboardInput("Nom du véhicule", "", 50, suggestions)
                        if input then
                            SpawnVehicle(input)
                        end
                    end
                })

                RageUI.Button("Réparer Véhicule", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function()
                        RepairVehicle()
                    end
                })

                RageUI.Button("Supprimer Véhicule", nil, {RightLabel = ">>>"}, true, {
                    onSelected = function()
                        print("Option 3 sélectionnée")
                    end
                })
                
            end)

            Wait(0)
        end
    end)
end
