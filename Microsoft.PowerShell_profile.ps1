# Import Terminal Icons modules and oh-my-posh
Import-Module -Name Terminal-Icons

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
$env:DOCUMENTS = "$env:USERPROFILE\Documents\"
$env:PSDOCHOME = "$env:DOCUMENTS" + "PowerShell"
$env:PATH      = $env:PATH + ";$env:DOCUMENTS\PowerShell\Scripts"
$env:PATH      = $env:PATH + ";$env:USERPROFILE\.local\bin"
$env:PATH      = $env:PATH + ";D:\Program Files\textadept_11.0.win32"
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
$env:BAT_THEME = 'OneHalfDark'
$env:BAT_STYLE = 'changes,rule,numbers'

# cargo multiple downloading setting
$env:CARGO_HTTP_CHECK_REVOKE = "false"
# Goproxy settings
#
$env:GOPROXY       = 'https://goproxy.cn'
$env:TM_SHR_FOLDER = "\\car-ch-1tool\Shared Folder"


# `rustup` autocompletion
$outbanner  = "$env:PSDOCHOME\outbanner.ps1"
$mysettings = "$env:PSDOCHOME\mysettings.ps1"
$autocompl  = "$env:PSDOCHOME\autocompl.ps1"
$lfrc       = "$env:PSDOCHOME\lfrc.ps1"

$env:DOTNET_CLI_TELEMETRY_OPTOUT = 0


#
# Export fzf options
#
$env:FZF_DEFAULT_OPTS = @"
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--height=70% --layout=reverse --border
--preview='bat -f {}'
--preview-window='right:60%'
"@

. $outbanner
. $mysettings
. $autocompl
. $lfrc
