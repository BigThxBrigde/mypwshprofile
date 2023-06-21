$vsc_ext_dir  = "$env:USERPROFILE\.vscode\extensions"
$vsc_ext_json = "extensions.json"
$inst_exts    = @()
$cur_exts     = @()

try {
    push-location $vsc_ext_dir

    convertfrom-json (gc $vsc_ext_json) | % {
        $inst_exts += $_.relativeLocation
    }

    gci -directory | ? {
        $_.name -match '^(?!\.)'
    } | % {
        $cur_exts += $_.name
    }

    $diff = compare-object $cur_exts $inst_exts

    if ($diff.length -eq 0) {
        echo 'No deprecated extensions found.'
    } else {
        $diff | % {

            $dir = $_.inputobject
            echo "Remove $dir"
            rm -force -recurse $dir
        }
        echo 'All deprecated extensions have been removed.'
    }

}
finally {
    pop-location
}

