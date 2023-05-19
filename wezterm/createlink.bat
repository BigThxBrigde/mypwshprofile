
@echo off
pushd "%USERPROFILE%"
if exist .wezterm.lua del /f /q .wezterm.lua
if exist .wezterm rmdir /q .wezterm
mklink .wezterm.lua "%USERPROFILE%\Documents\Powershell\wezterm\wezterm.lua"
mklink /D .wezterm "%USERPROFILE%\Documents\PowerShell\wezterm\lua"
popd
