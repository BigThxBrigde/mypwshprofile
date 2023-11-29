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
  pwshfetch -all -logo "Windows 7" -cpustyle bartext `
  -memorystyle bartext -diskstyle bartext `
  -batterystyle bartext
}

# Reboot PC
function reboot {
    sudo shutdown -r -f -t 0
}
 
# Shutdown PC
function halt {
    sudo shutdown -s -f -t 0
}

function blk-txt([string]$txt) {
    echo "`u{001b}[5m$txt`u{001b}[0m" 
}

function killall([string]$proc) {
    ps | % {
        $name = $_.processname
        if ($name -like "*$proc*") {
            & cmd /c "taskkill /f /im $name.exe >NUL 2>&1"
            & cmd /c "taskkill /f /im $name >NUL 2>&1"
        }
    }
}


# Loop kill mbcloudea.exe 
function kill-trashes {
  $sb = {
      while ($true) {
        sudo taskkill /F /IM MBCloudEA.exe /T 2>&1 1>$null;
        Start-Sleep 2;
      }
    }
  Start-Job -ScriptBlock $sb -Name "kill-trashes"
}

# Try to switch the gitconfig 
# function switch-gitconfig {
#   param(
#     [Parameter(ParameterSetName = 'Operations')]
#     [alias('o')]
#     [switch]$original,
#     [Parameter(ParameterSetName = 'Operations')]
#     [alias('m')]
#     [switch]$modified
#   )

#   if ($original.IsPresent) {
#     cp ~/.config/git/config.original ~/.gitconfig -Force
#   } elseif ($modified.IsPresent) {
#     cp ~/.config/git/config.modified ~/.gitconfig -Force
#   } else {
#     write-host 'Usage: switch-gitconfig [option]'  -f Green
#     write-host '       -m,-modified    Use modified gitconfig'  -f Green
#     write-host '       -o,-original    Use original gitconfig'  -f Green
#   }
# }

# Weather report
function report-weather {
  # https://wttr.in/:help
  # curl https://wttr.in/suzhou?lang=zh-cn
  curl https://wttr.in/suzhou
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

function open-shr {
  open $env:TM_SHR_FOLDER
}


# Use for fzf search 
$script:FZF_EXCLUDE_DIR = @(".git", 
  ".gitlab", 
  ".vs", 
  "bin", 
  "obj", 
  "node_modules") 

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
    # hx $_
	vi $_
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

function csi { 
    if ($env:WEZTERM_SESSION) {
        & wezterm cli spawn csharprepl --useTerminalPaletteTheme
    } else {
        & wt -w 0 nt --title "C# REPL" csharprepl --useTerminalPaletteTheme
    }
}

function csr {
    csharprepl --useTerminalPaletteTheme
}

function do-profiling {
    $trace =  trace-script -scriptblock { . $profile }
    # $trace.top50functionduration
    $trace.top50functionselfduration
}


#
#  If not installed ripgrep use this function 
#
# function grep {
#   param(
#     [parameter(mandatory, position=0)]
#     [alias('f')]
#     [string]$file,
#     [parameter(mandatory, position=1)]
#     [alias('p')]
#     [string]$pattern
#   )
#   gci -recurse -file $file | %{ 
#     sls -literalpath @($_.fullname) -pattern "$pattern" -erroraction silentlycontinue } `
#   | bat -l meminfo --theme base16 --style plain 
# }

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


# $script:init_file = $env:PSDOCHOME + "/simplevim/init.lua" 
# 
# function nvi {
#   param(
# 	  [parameter(valuefromremainingarguments = $true,
# 		  valuefrompipeline = $true)]
# 	  [string[]][alias('p')]$path
#   )
#   if ($path.length -eq 0) {
#     neovide -- -u "$script:init_file"
#   } else {
#     neovide -- -u "$script:init_file" @path
#   }
# }
# 
# function vi {
#   param(
# 	  [parameter(valuefromremainingarguments = $true,
# 		  valuefrompipeline = $true)]
# 	  [string[]][alias('p')]$path
#   )
#   if ($path.length -eq 0) {
#     nvim -u "$script:init_file"
#   } else {
#     nvim -u "$script:init_file" @path
#   }
# }

function which {
  param(
	  [parameter(position = 0,
		  valuefrompipeline = $true)]
	  [string][alias('c')]$cmd
  )

  $cmdinfo = get-command $cmd -erroraction silentlycontinue
  if ($cmdinfo) {
      $cmdinfo
  } else {
      write-host "ERROR: No command [$cmd] found!" -f red
  }
}


$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


