<#
.SYNOPSIS
    Read-only pre-flight inspection of a new or unknown Windows laptop.

.DESCRIPTION
    Built for a new work laptop (Lenovo ThinkPad E16 Gen 2 AMD) bought from a
    third-party marketplace reseller that upgraded the RAM and SSD and installed Windows.

    Answers four questions before the machine is wiped:
      1. What hardware is actually in it?        (model, serial, RAM sticks, disks)
      2. What Windows license does the FIRMWARE carry?  (OA3 / MSDM key edition)
      3. How is the CURRENT install activated?   (license channel, KMS host, activator traces)
      4. Is the platform ready for Entra join / device association?  (TPM 2.0, Secure Boot, NICs)

    It CHANGES NOTHING. It only reads, then writes a text report next to itself
    (i.e. onto the USB stick you ran it from) and prints the same report on screen.

.USAGE
    From the OOBE command prompt (Shift+F10) or an elevated PowerShell:
        powershell.exe -ExecutionPolicy Bypass -File E:\Inspect-Laptop.ps1
    (Replace E: with the USB stick's drive letter.)

.NOTES
    Author : Evan Ireland
    Date   : 30SEP26
    Tested : PowerShell 5.1 syntax (the version built into Windows 11). No modules required.
             Does not use WMIC - WMIC was removed from Windows 11 24H2/25H2 by KB5120998.
#>

$ErrorActionPreference = 'Continue'

# ---- Where to write the report: the folder this script lives in (the USB stick) ----
$outDir = $PSScriptRoot
if (-not $outDir) { $outDir = (Get-Location).Path }
$stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'
$out    = Join-Path $outDir "Inspection-$env:COMPUTERNAME-$stamp.txt"

$report = New-Object System.Collections.Generic.List[string]
function Add-Line   { param([string]$Text) $report.Add($Text) }
function Add-Section { param([string]$Title) $report.Add(''); $report.Add("===== $Title =====") }
function Add-Table  { param($Object) $report.Add(($Object | Format-Table -AutoSize | Out-String -Width 220).TrimEnd()) }

Add-Line "PRE-FLIGHT INSPECTION   $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss zzz')"
Add-Line "Report file: $out"

# ------------------------------------------------------------------ 1. HARDWARE IDENTITY
Add-Section '1. HARDWARE IDENTITY'
$cs   = Get-CimInstance -ClassName Win32_ComputerSystem
$bios = Get-CimInstance -ClassName Win32_BIOS
$prod = Get-CimInstance -ClassName Win32_ComputerSystemProduct
Add-Line "Manufacturer       : $($cs.Manufacturer)"
Add-Line "Model (Lenovo MTM) : $($cs.Model)"
Add-Line "Product name       : $($prod.Version)"
Add-Line "Serial number      : $($bios.SerialNumber)"
Add-Line "BIOS version       : $($bios.SMBIOSBIOSVersion)   released $($bios.ReleaseDate)"
Add-Line "Corporate-ID line  : $($cs.Manufacturer),$($cs.Model),$($bios.SerialNumber)"
Add-Line '  (^ exact manufacturer,model,serial string Intune would match - keep for the record)'

# ------------------------------------------------------------------ 2. WINDOWS AS INSTALLED
Add-Section '2. WINDOWS AS INSTALLED BY THE RESELLER'
$os = Get-CimInstance -ClassName Win32_OperatingSystem
$cv = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
Add-Line "Edition (caption)  : $($os.Caption)"
Add-Line "EditionID          : $($cv.EditionID)"
Add-Line "Version / build    : $($cv.DisplayVersion)  build $($cv.CurrentBuild).$($cv.UBR)"
Add-Line "Install date       : $($os.InstallDate)"
Add-Line "Registered owner   : $($cv.RegisteredOwner)"
Add-Line "Registered org     : $($cv.RegisteredOrganization)"
Add-Line '  (^ a non-blank owner/org here usually names whoever built the image)'

# ------------------------------------------------------------------ 3. LICENSING
Add-Section '3. LICENSING - FIRMWARE KEY vs. INSTALLED KEY'
$sls = Get-CimInstance -ClassName SoftwareLicensingService
$fwDesc = $sls.OA3xOriginalProductKeyDescription
$fwKey  = $sls.OA3xOriginalProductKey
if ($fwKey) {
    Add-Line "Firmware (OA3/MSDM) key present : YES   (last 5: $($fwKey.Substring($fwKey.Length - 5)))"
    Add-Line "Firmware key edition            : $fwDesc"
} else {
    Add-Line 'Firmware (OA3/MSDM) key present : NO  - Lenovo did not embed a Windows license in this board'
}
Add-Line '  How to read it: "Professional" = Pro. "Core" = Home. "CoreSingleLanguage" = Home SL.'
Add-Line '  The full key is deliberately NOT printed - only the last 5 characters.'

# Application ID 55c92734-... = Windows itself (filters out Office and other products)
$winAppId = '55c92734-d682-4d71-983e-d6ec3f16059f'
$lic = Get-CimInstance -ClassName SoftwareLicensingProduct -Filter "ApplicationID='$winAppId' AND PartialProductKey IS NOT NULL"
$statusMap = @{ 0='Unlicensed'; 1='Licensed (activated)'; 2='Out-of-box grace'; 3='Out-of-tolerance grace'; 4='Non-genuine grace'; 5='Notification (NOT activated)'; 6='Extended grace' }
foreach ($l in $lic) {
    $st = $statusMap[[int]$l.LicenseStatus]
    Add-Line ''
    Add-Line "Installed license  : $($l.Name)"
    Add-Line "  Channel          : $($l.Description)"
    Add-Line "  Key (last 5)     : $($l.PartialProductKey)"
    Add-Line "  Status           : $st"
    if ($l.KeyManagementServiceMachine -or $l.DiscoveredKeyManagementServiceMachineName) {
        Add-Line "  KMS host         : $($l.KeyManagementServiceMachine) (discovered: $($l.DiscoveredKeyManagementServiceMachineName))"
        Add-Line '  !! RED FLAG: a retail laptop has no business pointing at a KMS host. This is the signature of a piracy activator.'
    }
}
if ($sls.KeyManagementServiceMachine) {
    Add-Line "Service-level KMS host : $($sls.KeyManagementServiceMachine)   <-- RED FLAG on a retail laptop"
}

# Common traces left by KMS activators (KMSpico, KMSAuto, KMS_VL_ALL). Presence = untrusted image.
$activatorPaths = @(
    "$env:SystemRoot\System32\SppExtComObjHook.dll",
    "$env:SystemRoot\KMSAutoS",
    "$env:ProgramData\KMSAutoS",
    "$env:ProgramFiles\KMSpico",
    "${env:ProgramFiles(x86)}\KMSpico"
)
$hits = $activatorPaths | Where-Object { $_ -and (Test-Path -LiteralPath $_) }
$taskHits = Get-ScheduledTask -ErrorAction SilentlyContinue |
    Where-Object { $_.TaskName -match 'KMS|Pico|AutoActivat|SppExtComObjHook' } |
    Select-Object TaskPath, TaskName
Add-Line ''
if ($hits -or $taskHits) {
    Add-Line '!! ACTIVATOR TRACES FOUND - treat this image as compromised:'
    $hits | ForEach-Object { Add-Line "   file/folder: $_" }
    if ($taskHits) { Add-Table $taskHits }
} else {
    Add-Line 'Activator traces   : none found in the common locations (not proof of clean, just no obvious red flag)'
}

# ------------------------------------------------------------------ 4. RESELLER CUSTOMIZATION
Add-Section '4. RESELLER CUSTOMIZATION (why a Windows "Reset" would NOT remove it)'
foreach ($p in @("$env:SystemRoot\OEM", "$env:SystemDrive\Recovery\OEM", "$env:SystemDrive\Recovery\Customizations")) {
    Add-Line ("{0,-40} exists: {1}" -f $p, (Test-Path -LiteralPath $p))
}
try {
    $ppkg = Get-ProvisioningPackage -AllInstalledPackages -ErrorAction Stop
    if ($ppkg) { Add-Line 'Installed provisioning packages:'; Add-Table ($ppkg | Select-Object PackageName, PackagePath, Rank) }
    else { Add-Line 'Installed provisioning packages: none' }
} catch { Add-Line "Provisioning packages: could not query ($($_.Exception.Message))" }
Add-Line 'Local user accounts:'
Add-Table (Get-LocalUser | Select-Object Name, Enabled, LastLogon, Description)

# ------------------------------------------------------------------ 5. MEMORY AND STORAGE
Add-Section '5. MEMORY (what the reseller installed)'
Add-Table (Get-CimInstance -ClassName Win32_PhysicalMemory |
    Select-Object DeviceLocator, Manufacturer, PartNumber,
        @{ n = 'GB'; e = { [math]::Round($_.Capacity / 1GB) } },
        @{ n = 'MT/s'; e = { $_.ConfiguredClockSpeed } })

Add-Section '6. STORAGE (the E16 Gen 2 has TWO M.2 slots - check how many disks are present)'
Add-Table (Get-PhysicalDisk |
    Select-Object DeviceId, FriendlyName, SerialNumber, BusType, MediaType, HealthStatus,
        @{ n = 'SizeGB'; e = { [math]::Round($_.Size / 1GB) } })
Add-Table (Get-Disk | Select-Object Number, FriendlyName, PartitionStyle,
        @{ n = 'SizeGB'; e = { [math]::Round($_.Size / 1GB) } }, NumberOfPartitions)

# ------------------------------------------------------------------ 7. PLATFORM SECURITY
Add-Section '7. PLATFORM SECURITY (device association needs TPM 2.0 in a good state)'
try {
    $tpm = Get-Tpm -ErrorAction Stop
    Add-Line "TPM present / ready / enabled : $($tpm.TpmPresent) / $($tpm.TpmReady) / $($tpm.TpmEnabled)"
    Add-Line "TPM manufacturer              : $($tpm.ManufacturerIdTxt)  version $($tpm.ManufacturerVersion)"
} catch { Add-Line "Get-Tpm failed: $($_.Exception.Message)  (needs an elevated prompt)" }
try {
    $tpmWmi = Get-CimInstance -Namespace 'root\cimv2\security\microsofttpm' -ClassName Win32_Tpm -ErrorAction Stop
    Add-Line "TPM spec version              : $($tpmWmi.SpecVersion)   (first number must be 2.0)"
} catch { Add-Line 'TPM spec version              : could not query' }
try {
    $sb = Confirm-SecureBootUEFI -ErrorAction Stop
    Add-Line "Secure Boot enabled           : $sb"
} catch { Add-Line "Secure Boot                   : could not confirm ($($_.Exception.Message))" }

# ------------------------------------------------------------------ 8. NETWORK + DRIVERS
Add-Section '8. NETWORK ADAPTERS (plan on the built-in RJ-45 for OOBE)'
Add-Table (Get-NetAdapter -ErrorAction SilentlyContinue | Select-Object Name, InterfaceDescription, Status, MacAddress)

Add-Section '9. DEVICES WITH DRIVER PROBLEMS (anything here = expect the same on a clean install)'
$bad = Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.Status -ne 'OK' } |
    Select-Object Status, Class, FriendlyName, InstanceId
if ($bad) { Add-Table $bad } else { Add-Line 'None - every present device reports OK.' }

# ------------------------------------------------------------------ WRITE + SHOW
try {
    $report | Out-File -FilePath $out -Encoding UTF8 -ErrorAction Stop
    Add-Line ''
    Add-Line "Saved to $out"
} catch {
    Add-Line ''
    Add-Line "!! Could not save the report ($($_.Exception.Message)). Photograph the screen instead."
}
$report | ForEach-Object { Write-Output $_ }
