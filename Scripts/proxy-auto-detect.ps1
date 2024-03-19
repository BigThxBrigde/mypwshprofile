#
# https://stackoverflow.com/questions/15914109/using-powershell-to-change-registry-binary-data/15914470#15914470
#
# Script for checking or unchecking auto detect proxy settings.
# Author: jermaine007
# Version: 1.0.0.1
# Usage:
#   -s -status         Show current status, indicate if the auto detect proxy is enabled or not.
#   -e -enable         Enable auto detect proxy.
#   -d -disable        Disable auto detect proxy.
#
<#PSScriptInfo
.VERSION 1.0.0.1
.GUID 28166ed2-f498-4090-b239-fe7422236274
.AUTHOR jermaine007
.PROJECTURI
.COMPANYNAME
.COPYRIGHT
.TAGS
.LICENSEURI
.ICONURI
.EXTERNALMODULEDEPENDENCIES
.REQUIREDSCRIPTS
.EXTERNALSCRIPTDEPENDENCIES
.RELEASENOTES
#>

[CmdletBinding()]
param(
  [Parameter(ParameterSetName = "switchset")][switch][alias('h')]$help,
  [Parameter(ParameterSetName = "switchset")][switch][alias('s')]$status,
  [Parameter(ParameterSetName = "switchset")][switch][alias('e')]$enable,
  [Parameter(ParameterSetName = "switchset")][switch][alias('d')]$disable
)

$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections'
$data = (Get-ItemProperty -Path $key -Name DefaultConnectionSettings).DefaultConnectionSettings

#
# Function to read current status for auto detect proxy
#
function Read-Proxy-Status {
  $msg = ''
  $color = $null
  if ($data[4] -eq 86 -and $data[8] -eq 9) {
    $msg = 'enabled'
    $color = [System.ConsoleColor]::Green
  }
  else {
    $msg = 'disabled'
    $color = [System.ConsoleColor]::Yellow
  }
  Write-Host ('Auto detect proxy status: {0}' -f $msg) -f $color
}

#
# Function to write current status for auto detect proxy
#
function Write-Proxy-Status {
  param([bool]$enabled)

  $msg = ''
  if ($enabled) {
    $data[4] = 86
    $data[8] = 9
    $msg = 'Enabling proxy auto detect ...'
  }
  else {
    $data[4] = 87
    $data[8] = 1
    $msg = 'Disabling proxy auto detect ...'
  }
  Write-Host $msg
  Set-ItemProperty -Path $key -Name DefaultConnectionSettings -Value $data
}

function Print-Usage {
  Write-Host "Version: 1.0.0.1"
  Write-Host "Usage:"
  Write-Host "  -s -status         Show current status, indicate if the auto detect proxy is enabled or not."
  Write-Host "  -e -enable         Enable auto detect proxy."
  Write-Host "  -d -disable        Disable auto detect proxy."
}

###########################################
# Main procedure
###########################################

if((-not $help.IsPresent) -and
   (-not $status.IsPresent) -and
   (-not $enable.IsPresent) -and
   (-not $disable.IsPresent)) {
  Print-Usage
  Exit
}

if ($help) {
  Print-Usage
}
elseif ($status) {
  Read-Proxy-Status
}
elseif ($enable) {
  Write-Proxy-Status -enabled $true
}
else{
  Write-Proxy-Status -enabled $false
}
