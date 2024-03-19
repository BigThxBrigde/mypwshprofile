
# Banner only show once at startup
$script:show_banner = $false
$script:session = ''

if ("$env:TERM_PROGRAM" -eq 'WezTerm') { $script:session = $env:WEZTERM_SESSION }
elseif ("$env:TERM_PROGRAM" -eq '') { $script:session = $env:WT_SESSION }
elseif ("$env:TERM_PROGRAM" -eq 'vscode') { $script:session = 'vscode' }

if ($env:current_session -ne $script:session`
    -and $script:session -ne 'vscode') {
    $env:current_session = $script:session
    $script:show_banner = $true
}


if($script:show_banner) {
  $banner = "
                                                                                           `
▄▄▄▄▄ ▄▄▄· ▄▄▌  ▄ •▄     ▪  .▄▄ ·      ▄▄·  ▄ .▄▄▄▄ . ▄▄▄·  ▄▄▄·                           `
•██  ▐█ ▀█ ██•  █▌▄▌▪    ██ ▐█ ▀.     ▐█ ▌▪██▪▐█▀▄.▀·▐█ ▀█ ▐█ ▄█                           `
 ▐█.▪▄█▀▀█ ██▪  ▐▀▀▄·    ▐█·▄▀▀▀█▄    ██ ▄▄██▀▐█▐▀▀▪▄▄█▀▀█  ██▀·                           `
 ▐█▌·▐█ ▪▐▌▐█▌▐▌▐█.█▌    ▐█▌▐█▄▪▐█    ▐███▌██▌▐▀▐█▄▄▌▐█ ▪▐▌▐█▪·•                           `
 ▀▀▀  ▀  ▀ .▀▀▀ ·▀  ▀    ▀▀▀ ▀▀▀▀     ·▀▀▀ ▀▀▀ · ▀▀▀  ▀  ▀ .▀                              `
.▄▄ ·  ▄ .▄      ▄▄▌ ▐ ▄▌    • ▌ ▄ ·. ▄▄▄ .    ▄▄▄▄▄ ▄ .▄▄▄▄ .     ▄▄·       ·▄▄▄▄  ▄▄▄ .  `
▐█ ▀. ██▪▐█▪     ██· █▌▐█    ·██ ▐███▪▀▄.▀·    •██  ██▪▐█▀▄.▀·    ▐█ ▌▪▪     ██▪ ██ ▀▄.▀·  `
▄▀▀▀█▄██▀▐█ ▄█▀▄ ██▪▐█▐▐▌    ▐█ ▌▐▌▐█·▐▀▀▪▄     ▐█.▪██▀▐█▐▀▀▪▄    ██ ▄▄ ▄█▀▄ ▐█· ▐█▌▐▀▀▪▄  `
▐█▄▪▐███▌▐▀▐█▌.▐▌▐█▌██▐█▌    ██ ██▌▐█▌▐█▄▄▌     ▐█▌·██▌▐▀▐█▄▄▌    ▐███▌▐█▌.▐▌██. ██ ▐█▄▄▌  `
 ▀▀▀▀ ▀▀▀ · ▀█▄▀▪ ▀▀▀▀ ▀▪    ▀▀  █▪▀▀▀ ▀▀▀      ▀▀▀ ▀▀▀ · ▀▀▀     ·▀▀▀  ▀█▄▀▪▀▀▀▀▀•  ▀▀▀   `
                                                                                           `
"
  write-host $banner -foreground green
  # write-host $banner
}
