fx_version 'cerulean'

game 'gta5'

lua54 'yes'

shared_script 'shared/licenses.lua'

client_scripts {
    'client/licenses.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/licenses.lua'
}

files {
    'shared/licenses.lua'
}
