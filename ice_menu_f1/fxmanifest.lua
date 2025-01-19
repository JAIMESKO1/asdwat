fx_version 'cerulean'
game 'gta5'

-- Dépendances
dependency 'oxmysql'

ui_page 'html/index.html'

files {
    'html/index.html'
}

shared_script 'config.lua'

client_scripts {

    --Cilent
    'client/**.lua',

    --Rage UI
    'RageUI/RMenu.lua',
    'RageUI/menu/RageUI.lua',
    'RageUI/menu/Menu.lua',
    'RageUI/menu/MenuController.lua',
    'RageUI/components/*.lua',
    'RageUI/menu/elements/*.lua',
    'RageUI/menu/items/*.lua',
    'RageUI/menu/panels/*.lua',
    'RageUI/menu/windows/*.lua',
}

server_scripts {
    --Server
    'server/**.lua',
    'server/server.lua'
}

