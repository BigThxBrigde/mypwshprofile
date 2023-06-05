# This is a simple powershell core profile

This is only for my own use.

# Create links

1. Links for wezterm

```batch
@echo off
pushd "%USERPROFILE%"
if exist .wezterm.lua del /f /q .wezterm.lua
if exist .wezterm rmdir /q .wezterm
mklink .wezterm.lua "%USERPROFILE%\Documents\Powershell\wezterm\wezterm.lua"
mklink /D .wezterm "%USERPROFILE%\Documents\PowerShell\wezterm\lua"
popd
```

2. Links for vim
   
```batch
@echo off
pushd "%LOCALAPPDATA%"
if exist nvim rmdir /q nvim
mklink /D nvim "%USERPROFILE%\Documents\PowerShell\simplevim"
popd
```

# Package Manager
- [winget](https://github.com/microsoft/winget-cli)
- [chocolatey](https://chocolatey.org/)
- [scoop](https://scoop.sh/)

# Installed modules and scripts
- [PowerShellGet](https://github.com/PowerShell/PowerShellGet)
- [PSCalendar](https://github.com/jdhitsolutions/PSCalendar)
- [Profiler](https://github.com/nohwnd/Profiler)
- [PSReadLine](https://github.com/PowerShell/PSReadLine)
- [Terminal-Icons](https://github.com/devblackops/Terminal-Icons)
- [z](https://github.com/badmotorfinger/z)
- [winfetch](https://github.com/lptstr/winfetch)

# Installed Tools
- [gsudo](https://github.com/gerardog/gsudo)
- [oh-my-posh](https://ohmyposh.dev/)
- [nba-cli](https://github.com/dylantientcheu/nbacli)
- [bat](https://github.com/sharkdp/bat)
- [btop](https://github.com/aristocratos/btop)
- [lf](https://github.com/gokcehan/lf)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [wezterm](https://wezfurlong.org/wezterm/index.html)
- [C# REPL](https://fuqua.io/CSharpRepl/)

Refer to [modules and tools](modules_and_tools.md)

# Screenshot

![](screenshot/st1.png)
![](screenshot/st2.png)
![](screenshot/st3.png)
```
