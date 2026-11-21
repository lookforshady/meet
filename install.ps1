
$ErrorActionPreference = "Stop"

if (-not (Get-Command py -ErrorAction SilentlyContinue) -and
    -not (Get-Command python -ErrorAction SilentlyContinue)) {
    throw "Python is required."
}

$installDir = Join-Path $env:LOCALAPPDATA "MeetLauncher"
New-Item -ItemType Directory -Force -Path $installDir | Out-Null

Copy-Item "$PSScriptRoot\meet.py" "$installDir\meet.py"

$launcher = @'
@echo off
python "%~dp0meet.py" %*
'@

Set-Content -Path "$installDir\meet.cmd" -Value $launcher

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")

if (($userPath -split ';') -notcontains $installDir) {
    [Environment]::SetEnvironmentVariable(
        "Path",
        "$userPath;$installDir",
        "User"
    )
}

Write-Host "Installed! Open a new terminal and run: meet"
