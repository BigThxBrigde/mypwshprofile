# set error action reference
$erroractionpreference = 'Continue'

class AutoCompleteGenerationInfo {
    [string]  $cmd
    [bool]    $require_gen
    [string[]]$exec_cmd
    [string]  $autocmp
}

$autogeninfo = @(
        [AutoCompleteGenerationInfo]@{
            cmd         = 'dotnet'
            require_gen = $false
            exec_cmd    = @()
            autocmp     = @"
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
     param(`$commandName, `$wordToComplete, `$cursorPosition)
         dotnet complete --position `$cursorPosition "`$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new(`$_, `$_, 'ParameterValue', `$_)
         }
 }
"@
        },
        [AutoCompleteGenerationInfo]@{
            cmd         = 'winget'
            require_gen = $false
            exec_cmd    = @()
            autocmp     = @"
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param(`$wordToComplete, `$commandAst, `$cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = `$OutputEncoding = [System.Text.Utf8Encoding]::new()
        `$Local:word = `$wordToComplete.Replace('"', '""')
        `$Local:ast = `$commandAst.ToString().Replace('"', '""')
        winget complete --word="`$Local:word" --commandline "`$Local:ast" --position `$cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new(`$_, `$_, 'ParameterValue', `$_)
        }
}
"@
        },
        [AutoCompleteGenerationInfo]@{
            cmd         = 'rustup'
            require_gen = $true
            exec_cmd    = @('rustup', 'completions', 'powershell')
            autocmp     = ''
        },
        [AutoCompleteGenerationInfo]@{
            cmd         = 'wezterm'
            require_gen = $true
            exec_cmd    = @('wezterm', 'shell-completion', '--shell', 'power-shell')
            autocmp     = ''
        }
)


function gen-autocompl() {
    param(
        [switch]$force
    )
    $autocmp_dir = $env:PSDOCHOME + "\autocompletions"
    $dir_exist   = test-path -d $autocmp_dir

    if ($force.ispresent -or (-not $dir_exist)) {

        if ($dir_exist) {
            rm -recurse -force $autocmp_dir
        }

        & mkdir $autocmp_dir | %{}

        $autogeninfo | %{

            $info = $_

            if (-not (get-command $info.cmd)) { return }

            $autocmp_file = $autocmp_dir + "\" + $info.cmd + "_autocmp.ps1"

            if ($info.require_gen) {
                $cmd = ($info.exec_cmd -join " ")
                $info.autocmp = $(& cmd /c $cmd) -join ([environment]::newline) 
                echo $info.autocmp
            }
            echo $info.autocmp > "$autocmp_file"
        }
    }


    gci $autocmp_dir -file '*_autocmp.ps1' | % {
        $cmp_file = $_.fullname
        . $cmp_file
    }
}

gen-autocompl
