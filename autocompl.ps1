# set error action reference
$erroractionpreference = 'Continue'

function gen-autocompl() {
    $autocmp_dir = $env:PSDOCHOME + "\autocompletions"

    if (test-path -d $autocmp_dir) {
        rm -recurse -force $autocmp_dir
    } 
    & mkdir $autocmp_dir | %{}

    if (get-command 'dotnet') {
        # dotnet auto completion
        $sb = @"
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
     param(`$commandName, `$wordToComplete, `$cursorPosition)
         dotnet complete --position `$cursorPosition "`$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new(`$_, `$_, 'ParameterValue', `$_)
         }
 }
"@
        $autocmp_file = $autocmp_dir + "\dotnet_autocmp.ps1"
        echo $sb > $autocmp_file
        . $autocmp_file
    }

    if (get-command 'winget') {
        # dotnet auto completion
        $sb = @"
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
        $autocmp_file = $autocmp_dir + "\winget_autocmp.ps1"
        echo $sb > $autocmp_file
        . $autocmp_file
    }

    if (get-command 'rustup') {
        $autocmp_file = $autocmp_dir + "\rustup_autocmp.ps1"
        & rustup completions powershell > $autocmp_file
        . $autocmp_file
    }

    if (get-command 'nbacli') {
        $autocmp_file = $autocmp_dir + "\nbacli_autocmp.ps1"
        & nbacli completion powershell > $autocmp_file
        . $autocmp_file
    }

    if (get-command 'wezterm') {
        $autocmp_file = $autocmp_dir + "\wezterm_autocmp.ps1"
        & wezterm shell-completion --shell power-shell > $autocmp_file
        . $autocmp_file
    }
}

gen-autocompl
