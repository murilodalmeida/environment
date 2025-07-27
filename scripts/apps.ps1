# Installs Windows Apps

# --- Update Source ---
Write-Host "Updating winget sources..." -ForegroundColor Cyan
winget source update

# --- Apps list with flags ---
$apps = @(
    "Microsoft.Edit -h"
    "Microsoft.VisualStudioCode -h"
    "Microsoft.PowerToys -h"
    "Microsoft.DotNet.SDK.9 -h"
    "Mozilla.Firefox -h"
    "IDRIX.VeraCrypt -h"
    "7zip.7zip -h"
    "Rclone.Rclone -h"
    "Parsec.Parsec -h"
    "OpenJS.NodeJS.LTS -h"
    "Genymobile.scrcpy -h"
    "GnuWin32.Make -h"
    "Stremio.Stremio -h"
    "Git.Git -h"
    "Discord.Discord -h"
    "Valve.Steam -i"
    "JetBrains.Rider -i"
)

Write-Host "`nInstalling apps..." -ForegroundColor Green
foreach ($app in $apps) {
    $parts = $app -split " "
    $package = $parts[0]
    $flag = $parts[1]

    Write-Host "Installing $package..." -ForegroundColor Yellow
    winget install -e $flag --id $package
}
