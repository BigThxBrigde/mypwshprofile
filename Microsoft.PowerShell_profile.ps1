# Import Terminal Icons modules and oh-my-posh
Import-Module -Name Terminal-Icons
Import-Module gsudoModule

# Tried to use EMACS Keybindings
Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\neko.omp.json | Invoke-Expression
# meow.json is based on `neko.omp.json`
oh-my-posh init pwsh --config $env:USERPROFILE\Documents\PowerShell\meow.json | Invoke-Expression
# oh-my-posh init pwsh --config $env:USERPROFILE\Documents\PowerShell\dracula_mod.json | Invoke-Expression
# oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\dracula.omp.json | Invoke-Expression

# Export go path
$GOLIBPATH     = "$env:USERPROFILE\go\bin"
$env:PATH      = $env:PATH + ";C:\Go\bin"
$env:PATH      = $env:PATH + ";" + $GOLIBPATH
$env:DOCUMENTS = "$env:USERPROFILE\Documents"
$env:PSDOCHOME = "$env:DOCUMENTS" + "\PowerShell"
$env:SIMPLEVIM = "$env:PSDOCHOME" + "\simplevim"
$env:PATH      = $env:PATH + ";$env:DOCUMENTS\PowerShell\Scripts"
$env:PATH      = $env:PATH + ";$env:USERPROFILE\.local\bin"
$env:PATH      = $env:PATH + ";C:\Program Files\7-Zip"
$env:PATH      = $env:PATH + ";D:\lua\lua-5.4.2_Win64"
# https://emacs.stackexchange.com/questions/8269/how-do-i-set-up-my-emacs-d-folder-on-windows
$env:HOME      = $env:USERPROFILE
# Python encoding setting, otherwise pip would not work correctly.
# https://stackoverflow.com/questions/35176270/python-2-7-lookuperror-unknown-encoding-cp65001
$env:PYTHONIOENCODING  = "UTF-8"

# Setting python2 and python3 hosts
# https://spacevim.org/faq/#how-to-enable-py-and-py3-in-neovim
$env:PYTHON3_HOST_PROG = "D:\Program Files\Python38\python.exe"
$env:PYTHON_HOST_PROG  = "D:\Program Files\Python2.7\python.exe"

# Set neovim configuration path
$env:NVIM_INIT = "$env:LOCALAPPDATA\nvim\init.vim"
$env:NVIM_DATA = "$env:LOCALAPPDATA\nvim-data"

# Settings for BAT
# $env:BAT_THEME = 'Dracula'
$env:BAT_THEME = 'Catppuccin Macchiato'
$env:BAT_STYLE = 'changes,rule,numbers'

# cargo multiple downloading setting
$env:CARGO_HTTP_CHECK_REVOKE = "false"
# Goproxy settings
#
$env:GOPROXY       = 'https://goproxy.cn'
$env:TM_HOST       = "chi-pc-0019"
$env:TM_SHR_FOLDER = "\\$env:TM_HOST\Shared Folder"


# `rustup` autocompletion
$outbanner  = "$env:PSDOCHOME\outbanner.ps1"
$aliases    = "$env:PSDOCHOME\aliases.ps1"
$func       = "$env:PSDOCHOME\func.ps1"
$autocompl  = "$env:PSDOCHOME\autocompl.ps1"
$wm         = "$env:PSDOCHOME\wm.ps1"

$env:DOTNET_CLI_TELEMETRY_OPTOUT = 0


#
# Export fzf options
#
# $env:FZF_DEFAULT_OPTS = @"
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
# --height=70% --layout=reverse --border
# --preview='bat -f {}'
# --preview-window='right:60%'
# "@
#
$env:FZF_DEFAULT_OPTS = @"
  --color=spinner:#f4dbd6,hl:#ed8796
  --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
  --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
  --height=60%
  --layout=reverse
  --preview='bat -f {}'
  --preview-window='right:60%'
"@

$env:EDITOR = 'nvim'
$env:NODE_TLS_REJECT_UNAUTHORIZED = 0

. $outbanner
. $aliases
. $func
. $autocompl
. $wm
