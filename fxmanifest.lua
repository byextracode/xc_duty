fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name "xc_duty"
version "1.0.0"
description "Handles job on/off duty and job authorization."
author "wibowo#7184"

shared_script "@es_extended/imports.lua"
shared_script "@ox_lib/init.lua"

shared_script "config.lua"
client_script "**/cl_*.lua"
server_script "**/sv_*.lua"

dependencies {
    "es_extended",
    "ox_lib",
    -- "ox_target" --optional
}

provides {
    "utils"
}