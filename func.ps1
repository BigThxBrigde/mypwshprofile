# Monitoring file dynamically
function tail([string]$Path, [int]$Line = 30) {
    cat -Path $Path -Tail $Line -Wait
}

# Open file or folders
function open([string]$Path){
    explorer.exe $Path
}

# Create a new files
function touch([string]$File) {
    ni -Type File $File
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
function poweroff {
    sudo shutdown -s -f -t 0
}

function blk-txt([string]$txt) {
    echo "`u{001b}[5m$txt`u{001b}[0m"
}

function killall {
    param(
        [parameter(position = 0,
          valuefrompipeline = $true)]
        [string][alias('p')]$proc,
        [switch][alias('a')]$useadmin

    )

    if (-not $proc) {
        write-host "Usage: killall [-p] <proc> [-a|useadmin]" -f green
        return
    }

    $proc_name = (split-path $proc -leafbase)

    if (-not $proc_name) {
        write-host "Usage: killall [-p] <proc> [-a|useadmin]" -f green
        return
    }

    ps | % {
        $name = $_.processname
        if ($name -like "*$proc_name*") {
            if ($useadmin.ispresent) {
                & sudo cmd /c "taskkill /f /im $name.exe 2>NUL"
            }
            else {
                & cmd /c "taskkill /f /im $name.exe 2>NUL"
            }
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

function choco-autoclean {
    & sudo choco-cleaner.bat
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
    & $env:EDITOR $_
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

## use eza(exa) dirr[ich]
# https://github.com/eza-community/eza
function dirr {
    Param(
         [parameter(ValueFromRemainingArguments = $true)]
         [string[]]$opts)
    $default_opts = @('--icons', '--all', '--long')

    $actual_opts = $default_opts

    if ($opts) {
        if ($opts -contains '-fresh') {
            $actual_opts = @($opts | ? { $_ -ne '-fresh' })
        } else {
            $actual_opts = $default_opts + $opts
        }
    }

    eza @actual_opts
}

function vact {
    $act_file = 'e:\jermaine\work\docs\accounts.txt'
    glow "$act_file"
    # view "$act_file" 'set ft=markdown'

}

function view {
    param(
        [parameter(position = 0,
            mandatory,
            valuefrompipeline = $true)]
        [string][alias('f')]$file,
        [parameter(position = 1)]
        [string][alias('c')]$opts=""
    )

    $cmd = ":set wrap"
    if ($opts) {
        $cmd += " | $opts "
    }


    & vi -R -c "$cmd" -- "$file"
}

function which {
  param(
    [parameter(position = 0,
      valuefrompipeline = $true)]
    [string][alias('c')]$cmd
  )
  if (-not $cmd) {
      write-host "Usage: which <cmd>" -f green
      return
  }

  $cmdinfo = gcm $cmd -erroraction silentlycontinue
  if ($cmdinfo) {
      $cmdinfo
  } else {
      write-host "ERROR: No command [$cmd] found!" -f red
  }
}

function whereis {
  param(
    [parameter(position = 0,
      valuefrompipeline = $true)]
    [string][alias('c')]$cmd
  )

  if (-not $cmd) {
      write-host "Usage: whereis <cmd>" -f green
      return
  }

  $cmdinfo = gcm $cmd -erroraction silentlycontinue
  if ($cmdinfo) {
      $type = $cmdinfo.commandtype
      switch ($type)
      {
          {($_ -eq [system.management.automation.commandtypes]::function) `
             -and $cmdinfo.scriptblock.file }
          {
              $startposition = $cmdinfo.scriptblock.startposition
              $line          = $startposition.startline
              $column        = $startposition.startcolumn
              $file          = $cmdinfo.scriptblock.file
              $name          = $cmdinfo.name

              "{0}:{1}:{2} {3}" -f $file, $line, $column, $name
          }

          {(($_ -eq [system.management.automation.commandtypes]::application) `
            -or ($_ -eq [system.management.automation.commandtypes]::externalscript)) `
            -and $cmdinfo.source }
          {
              $cmdinfo.source
          }

          {($_ -eq [system.management.automation.commandtypes]::alias) `
            -and ($cmdinfo.resolvedcommand.commandtype -eq [system.management.automation.commandtypes]::function) `
            -and $cmdinfo.resolvedcommand.scriptblock.file }
          {
              $startposition = $cmdinfo.resolvedcommand.scriptblock.startposition
              $line          = $startposition.startline
              $column        = $startposition.startcolumn
              $file          = $cmdinfo.resolvedcommand.scriptblock.file
              $name          = $cmdinfo.name
              $ref_name      = $cmdinfo.resolvedcommand.name

              "{0}:{1}:{2} {3} -> {4}" -f $file, $line, $column, $name, $ref_name
          }
          {($_ -eq [system.management.automation.commandtypes]::alias) `
            -and ($cmdinfo.resolvedcommand.commandtype -eq [system.management.automation.commandtypes]::application `
              -or $cmdinfo.resolvedcommand.commandtype -eq  [system.management.automation.commandtypes]::externalscript) `
            -and $cmdinfo.resolvedcommand.source }
          {
              "{0} {1} -> {2}" -f $cmdinfo.resolvedcommand.source,$cmdinfo.name,$cmdinfo.resolvedcommand.name
          }
          default { write-host "[$cmd] is a built-in cmdlet or alias!" }
      }
  } else {
      write-host "ERROR: No command [$cmd] found!" -f red
  }
}

function unzip {
  param(
    [parameter(position = 0,
      valuefrompipeline = $true)]
    [string][alias('p')]$file,
      [switch][alias('f')]$force)

  if ($force.ispresent) {
      7z x "$file" -y
  } else {
      7z x "$file"
  }
}

function hexview {
  param(
    [parameter(position = 0,
      valuefrompipeline = $true)]
    [string][alias('f')]$file
  )

  if (-not (test-path "$file")) {
      write-host "ERROR: file $file does not exist." -f red
      return
  }
  $filename = split-path "$file" -leaf
  xxd "$file" | vi -R -c "set ft=xxd | set tabline=$filename"
}

# https://github.com/julian-r/file-windows
function desccmd {
  param(
    [parameter(position = 0,
      valuefrompipeline = $true)]
    [string][alias('c')]$cmd,
    [switch][alias('r')]$nocolor
  )

  if (-not $cmd) {
    write-host "Usage: desccmd [-n] <cmd> [-r]" -f green 
    return
  }


  # Try to find external script first

  $searchname = $cmd

  $funcinfo = gcm -commandtype externalscript $searchname -erroraction silentlycontinue

  if ($funcinfo) {
      if ($nocolor) { $funcinfo.scriptblock.startposition.content }
      else { $funcinfo.scriptblock.startposition.content  | bat -l ps1 }
      return
  }

  # Try to parse alias
  $funcinfo = gcm -commandtype alias $searchname -erroraction silentlycontinue
  if ($funcinfo -and $funcinfo.resolvedcommand) {
      if ($funcinfo.resolvedcommand.source) {
          $searchname = $funcinfo.resolvedcommand.source
      } else {
          $searchname = $funcinfo.resolvedcommand.name
      }
      # If resolved find external script
      $funcinfo = gcm -commandtype externalscript $searchname -erroraction silentlycontinue

      if ($funcinfo) {
          if ($nocolor) { $funcinfo.scriptblock.startposition.content }
          else { $funcinfo.scriptblock.startposition.content | bat -l ps1 }
          return
      }
  }


  # Try to find function
  $funcinfo = gcm -commandtype function $searchname -erroraction silentlycontinue

  if ($funcinfo) {
      if ($nocolor) { $funcinfo.scriptblock.startposition.content  }
      else { $funcinfo.scriptblock.startposition.content | bat -l ps1}
      return
  }

  write-host "ERROR: No cmd [$cmd] found or source not avaliable!" -f red

}


$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


