# set error action reference
$erroractionpreference = 'Continue'

class AutoGenInfo {
    [string]$cmd
    [bool]$require_gen
    [string[]]$cmd_exec
    [string]$autocmp
}

$autogeninfo = @(
        [AutoGenInfo]@{
            cmd         = 'dotnet'
            require_gen = $false
            cmd_exec    = @()
            autocmp     = @"
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
     param(`$commandName, `$wordToComplete, `$cursorPosition)
         dotnet complete --position `$cursorPosition "`$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new(`$_, `$_, 'ParameterValue', `$_)
         }
 }
"@
        },
        [AutoGenInfo]@{
            cmd         = 'winget'
            require_gen = $false
            cmd_exec    = @()
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
        [AutoGenInfo]@{
            cmd         = 'rustup'
            require_gen = $true
            cmd_exec    = @('rustup', 'completions', 'powershell')
            autocmp     = ''
        },
        [AutoGenInfo]@{
            cmd         = 'nbacli'
            require_gen = $true
            cmd_exec    = @('nbacli', 'completion', 'powershell')
            autocmp     = ''
        },
        [AutoGenInfo]@{
            cmd         = 'wezterm'
            require_gen = $true
            cmd_exec    = @('wezterm', 'shell-completion', '--shell', 'power-shell')
            autocmp     = ''
        }
)


function gen-autocompl() {
    $autocmp_dir = $env:PSDOCHOME + "\autocompletions"

    if (test-path -d $autocmp_dir) {
        rm -recurse -force $autocmp_dir
    }
    & mkdir $autocmp_dir | %{}

    $autogeninfo | % {

        $info = $_

        if (-not (get-command $info.cmd)) { return }

        # echo $info.cmd

        $autocmp_file = $autocmp_dir + "\" + $info.cmd + "_autocmp.ps1"

        if ($info.require_gen) {
            $cmd = ($info.cmd_exec -join " ")
            & cmd /c $cmd > "$autocmp_file"
        } else {
            echo $info.autocmp > "$autocmp_file"
        }
        . $autocmp_file
    }
}

gen-autocompl
