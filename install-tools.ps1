# install-tools.ps1

# Ensure script runs as admin
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You need to run this script as Administrator!"
    Exit
}

# Install Chocolatey if not installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey is already installed."
}

# Refresh environment
refreshenv

# Install developer tools
$packages = @(
    "androidstudio",
    "flutter",
    "openjdk",
    "nodejs-lts",
    "golang",
    "intellijidea-community",
    "vscode",
    "cursor",
    "docker-desktop",
    "treesizefree",
    "whatsapp",
    "telegram",
    "bruno"
)

foreach ($pkg in $packages) {
    Write-Host "Installing $pkg..."
    choco install $pkg -y --ignore-checksums
}

Write-Host "All tools installed successfully!"

