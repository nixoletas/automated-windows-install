# automated-windows-install

Automatede windows installation with debloat custom options

---

1. go to: https://schneegans.de/windows/unattend-generator/

2. go throught every config step to change accordingly to your needs

3. download .xml wrapped in .iso file

4. burn into a flash drive

5. initiate windows install with flash drive plugged in

---

check https://schneegans.de/windows/unattend-generator/samples/ for sample scripts

example (google chrome installation)

```ps1
$uri = [uri]::new( 'https://dl.google.com/chrome/install/chrome_installer.exe' );
$file = "$env:TEMP\{0}" -f $uri.Segments[-1];
[System.Net.WebClient]::new().DownloadFile( $uri, $file );
Start-Process -FilePath $file -ArgumentList '/silent /install' -Wait;
Remove-Item -LiteralPath $file -ErrorAction 'SilentlyContinue';
```
