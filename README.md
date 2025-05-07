# Automate boring windows installation

Automatede windows installation with debloat custom options

---

## Create your own custom script

1. go to: https://schneegans.de/windows/unattend-generator/

2. go throught every config step to change accordingly to your needs

3. download .xml wrapped in .iso file

4. burn into a flash drive

5. initiate windows install with flash drive plugged in

---

check https://schneegans.de/windows/unattend-generator/samples/ for sample scripts

example (google chrome installation)

.ps1

```ps1
$uri = [uri]::new( 'https://dl.google.com/chrome/install/chrome_installer.exe' );
$file = "$env:TEMP\{0}" -f $uri.Segments[-1];
[System.Net.WebClient]::new().DownloadFile( $uri, $file );
Start-Process -FilePath $file -ArgumentList '/silent /install' -Wait;
Remove-Item -LiteralPath $file -ErrorAction 'SilentlyContinue';
```

there is also a install-tools.ps1 script for installing:

- chocolatey
- android studio
- flutter
- jdk21
- nodejs
- golang
- intellijidea community edition
- vscode
- cursor
- docker-desktop
- treesizefree
- whatsapp
- telegram
- bruno

```ps1
# install-dev-tools.ps1

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
    "jdk21",
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
```

run the script with

```ps1
Set-ExecutionPolicy Bypass -Scope Process -Force
.\install-dev-tools.ps1
```
