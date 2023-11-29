$env:KOMOREBI_CONFIG_HOME = "$env:PSDOCHOME\komorebi"
$env:WHKD_CONFIG_HOME     = "$env:PSDOCHOME\komorebi"

function start-wm {
    komorebic start -c "$env:KOMOREBI_CONFIG_HOME\komorebi.json" --whkd
}

function stop-wm {
    komorebic stop
}

