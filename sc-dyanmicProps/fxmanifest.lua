fx_version 'cerulean'
game 'gta5'

author 'SnepCnep'
description 'SC-DynamicProps - Dynamic Props for FiveM using ox.'
version '1.0.0'

shared_scipts {
    '@ox_lib/init.lua', -- ox_lib is required for this resource to work.
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}