# List all files in directory and sub direcotries
function lsfl([string]$Path, [string]$Filter) {
    Get-ChildItem -Path $Path -Filter $Filter -Recurse
}

# Monitoring file dynamically
function tail([string]$Path, [int]$Line = 30) {
    Get-Content -Path $Path -Tail $Line -Wait
}

# Open file or folders
function open([string]$Path){
    explorer.exe $Path
}

# Create a new files
function touch([string]$File) {
    New-Item -Type File $File
}

# Win fetch
function winfetch {
  pwshfetch-test-1 -a -l -cpustyle bartext -memorystyle bartext -diskstyle bartext -batterystyle bartext
}

# Reboot PC
function reboot {
    sudo shutdown -r -f -t 0
}
 
# Shutdown PC
function halt {
    sudo shutdown -s -f -t 0
}

# Loop kill mbcloudea.exe 
function kill-trashes {
  $sb = {
      while ($true) {
        sudo taskkill /F /IM MBCloudEA.exe /T 2>&1 1>$null;
        # sudo taskkill /F /IM MsMpEng.exe /T 2>&1 1>$null;
        # sudo taskkill /F /IM MsMpEngCp.exe /T 2>&1 1>$null;
        Start-Sleep 2;
      }
    }
  Start-Job -ScriptBlock $sb -Name "kill-trashes"
}

# Try to switch the gitconfig 
function switch-gitconfig {
  param(
    [Parameter(ParameterSetName = 'Operations')]
    [alias('o')]
    [switch]$original,
    [Parameter(ParameterSetName = 'Operations')]
    [alias('m')]
    [switch]$modified
  )

  if ($original.IsPresent) {
    cp ~/.config/git/config.original ~/.gitconfig -Force
  } elseif ($modified.IsPresent) {
    cp ~/.config/git/config.modified ~/.gitconfig -Force
  } else {
    Write-Host 'Usage: switch-gitconfig [option]'  -f Green             
    Write-Host '       -m,-modified    Use modified gitconfig'  -f Green
    Write-Host '       -o,-original    Use original gitconfig'  -f Green
  }
}

# Weather report
function report-weather {
  curl wttr.in
}

function cd-parent {
  cd ../
}

function cd-home {
  cd ~
}

function conn-tm {
  mstsc.exe $home\tm.rdp /f
}

function open_shr {
  open $env:TM_SHR_FOLDER
}

# Use for fzf search 
$script:FZF_EXCLUDE_DIR = @(".git", 
  ".gitlab", 
  ".vs", 
  "bin", 
  "obj", 
  "node_modules", 
  "samples",
  "mydocbook",
  "external")

$script:exclude_dir = @()

function _is_excluded {
  param([string]$dir)
  $components = ($dir -split '\\')
  foreach ($d in $components) {
      if ($script:exclude_dir -contains $d) {
        return $true
      }
  }
  return $false
}

function jump {
  $live_searching     = $true
  $script:exclude_dir = @()
  $dir_from_env       = @($env:FZF_EXCLUDE_DIR -split ' ')
  $script:exclude_dir = $script:FZF_EXCLUDE_DIR + $dir_from_env

  gci . -attributes directory -recurse -force -erroraction silentlycontinue | % {
    if (-not $live_searching) { break }
    $fullname = $_.fullname
    if (-not (_is_excluded -dir $fullname)) {
      return $fullname
    }
  } | fzf --preview-window='hidden' | % {
    $live_searching = $false
    cd $_
  }
}

function edit {
  $live_searching     = $true
  $script:exclude_dir = @()

  $dir_from_env       = @($env:FZF_EXCLUDE_DIR -split ' ')
  $script:exclude_dir = $script:FZF_EXCLUDE_DIR + $dir_from_env

  gci . -attributes !directory -recurse -force -erroraction silentlycontinue | % {
    if (-not $live_searching) { break }
    $fullname = $_.fullname
    if (-not (_is_excluded -dir $fullname)) {
      return $fullname
    }
  } | fzf | % {
    $live_searching = $false
    hx $_
  }
}

function nba-go { 
  $tz  = [system.timezoneinfo]::findsystemtimezonebyid("Pacific Standard Time")
  $now = [system.timezoneinfo]::converttimefromutc((get-date).touniversaltime(), $tz)
  & nbacli games -d $now.tostring('yyyyMMdd')
}

function cmatrix {
  wsl cmatrix
}

function te { 
  D:\Application\emacs-28.2\bin\emacs.exe -nw 
}

function emacs {
  D:\Application\emacs-28.2\bin\runemacs.exe 
}

function csi {
  wt -w 0 nt --title "C# REPL" csharprepl 
}

function wc {
  param(
    [parameter(position = 0)]
    [string][alias('f')]$input,
    [switch][alias('l')]$line = $false,
    [switch][alias('w')]$word = $false,
    [switch][alias('c')]$char = $false
  )
  if ((-not $line) -and (-not $word) -and (-not $char)) { 
    write-host 'Usage: wc <input> [option]'  -f green             
    write-host '       -l, -line    Count lines of the input stream.'  -f green
    write-host '       -w, -word    Count words of the input stream.'  -f green
    write-host '       -c, -char    Count chars of the input stream.'  -f green
    return
  }
  if ($line) { (gc $input | measure -l).lines } 
  elseif ($word) { (gc $input | measure -w).words }
  elseif ($char) { (gc $input | measure -c).characters }
}


#       Alias       App
sal     ~           cd-home 
sal     ..          cd-parent 
sal     lg          lazygit
sal     vim         nvim
sal     vi          nvim
sal     lua         lua5.1
sal     pad         proxy-auto-detect
sal     mdp         markdown-preview
sal     nvi         neovide
sal     tac         textadept-curses.exe
sal     cal         get-calendar
sal     kkp         halt
sal     kkb         reboot
sal     ctm         conn-tm
sal     sg          switch-gitconfig
sal     kt          kill-trashes
sal     python3     'D:\Program Files\python38\python.exe'
sal     python2     'D:\Program Files\python2.7\python.exe'
sal     csr         csharprepl

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
