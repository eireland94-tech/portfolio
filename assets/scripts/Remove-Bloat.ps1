<#
.SYNOPSIS
    Removes a short, explicit list of consumer inbox apps from a managed Windows 11 Pro device.

.DESCRIPTION
    Deployed as an Intune platform script (Devices > Scripts and remediations > Platform scripts),
    assigned to the APDP device group and selected in the Autopilot device preparation policy so it
    runs during OOBE - BEFORE the first user profile exists.

    Two kinds of removal, and why both:
      * Provisioned package  = the "master copy" Windows stamps into every NEW user profile at first
                               sign-in. Removing it stops the app appearing for any future user.
      * Installed package    = a copy already registered to an existing profile. Removed with
                               -AllUsers so nothing is left behind if a profile already exists.

    Design rules (the opposite of a one-click debloat tool):
      * ALLOW-LIST BY EXACT NAME. Only the packages named in $RemoveList are touched. Nothing is
        matched by wildcard, no services are disabled, no telemetry/registry tweaks are made.
      * COPILOT IS KEPT. Microsoft.Copilot, Microsoft.MicrosoftOfficeHub (the Microsoft 365 Copilot
        app), Teams, Outlook, To Do, Power Automate and Phone Link are never in the list.
      * IDEMPOTENT. Safe to run twice; a package that is already gone is logged and skipped.
      * LOGGED. Full transcript to C:\ProgramData\<OrgName>\Logs\ so the result can be proven later.

    Why not the Windows "Remove default Microsoft Store packages" policy?  It is the Microsoft-native
    way to do this, but it only applies to Enterprise and Education editions. Microsoft 365 Business
    Premium licenses Windows 11 Pro, so on a Pro device that policy would report "Not applicable".

.NOTES
    Author : Evan Ireland
    Date   : 30SEP26
    Intune settings for this script:
        Run this script using the logged on credentials : No   (runs as SYSTEM - required during OOBE)
        Enforce script signature check                  : No
        Run script in 64-bit PowerShell host            : Yes  (Appx cmdlets misbehave in 32-bit)
#>

# Set to $true to log what WOULD be removed without removing anything.
$DryRun = $false

# Folder name used under C:\ProgramData for the log. Change it to your organization's short name.
$OrgName = 'ORG'

# ---- EDIT THIS LIST, NOT THE CODE BELOW ----
# Exact package names (the part before the first underscore in the full package name).
# Anything not listed here is left alone.
$RemoveList = @(
    'Microsoft.BingNews'                      # News
    'Microsoft.MicrosoftSolitaireCollection'  # Solitaire
    'Microsoft.GamingApp'                     # Xbox app
    'Microsoft.XboxGamingOverlay'             # Game Bar
    'Microsoft.XboxSpeechToTextOverlay'
    'Microsoft.XboxIdentityProvider'
    'Microsoft.Xbox.TCUI'
    'Microsoft.WindowsFeedbackHub'            # Feedback Hub
    'Microsoft.Getstarted'                    # Tips / Get Started
    'Clipchamp.Clipchamp'                     # Clipchamp video editor
    'MicrosoftCorporationII.MicrosoftFamily'  # Family Safety (consumer)
    'Microsoft.ZuneVideo'                     # Films & TV (legacy - may not exist on 25H2)
    'Microsoft.WindowsMaps'                   # Maps (legacy)
    'Microsoft.People'                        # People (legacy)
    'Microsoft.549981C3F5F10'                 # Cortana (legacy)
    'Microsoft.MixedReality.Portal'           # legacy
    'Microsoft.SkypeApp'                      # legacy
)

# Packages that must NEVER be removed, even if someone adds them to the list above by mistake.
# Removing these breaks Copilot, winget, the Store, or Windows Security.
$ProtectedList = @(
    'Microsoft.Copilot'
    'Microsoft.MicrosoftOfficeHub'            # Microsoft 365 Copilot app
    'MSTeams'
    'Microsoft.OutlookForWindows'
    'Microsoft.Todos'
    'Microsoft.PowerAutomateDesktop'
    'Microsoft.YourPhone'                     # Phone Link
    'MicrosoftCorporationII.QuickAssist'
    'Microsoft.DesktopAppInstaller'           # winget
    'Microsoft.WindowsStore'
    'Microsoft.StorePurchaseApp'
    'Microsoft.SecHealthUI'                   # Windows Security
    'Microsoft.CompanyPortal'
)

# ---- Logging ----
$LogDir = Join-Path $env:ProgramData (Join-Path $OrgName 'Logs')
if (-not (Test-Path -LiteralPath $LogDir)) { New-Item -Path $LogDir -ItemType Directory -Force | Out-Null }
$LogFile = Join-Path $LogDir ("Remove-Bloat_{0}.log" -f (Get-Date -Format 'yyyyMMdd-HHmmss'))
Start-Transcript -Path $LogFile -Force | Out-Null

Write-Output "Remove-Bloat starting. DryRun = $DryRun. Running as: $([Security.Principal.WindowsIdentity]::GetCurrent().Name)"
$os = Get-CimInstance -ClassName Win32_OperatingSystem
Write-Output "OS: $($os.Caption) build $($os.BuildNumber)"

$removed = 0; $skipped = 0; $failed = 0

# Query the provisioned list ONCE (it is slow), then filter it in memory inside the loop.
$allProvisioned = Get-AppxProvisionedPackage -Online

foreach ($name in $RemoveList) {

    if ($ProtectedList -contains $name) {
        Write-Output "[PROTECTED] $name is on the protected list - refusing to remove."
        $skipped++; continue
    }

    # 1. Provisioned copy (stops it landing in new user profiles)
    $prov = $allProvisioned | Where-Object { $_.DisplayName -eq $name }
    if ($prov) {
        foreach ($p in $prov) {
            if ($DryRun) { Write-Output "[DRYRUN] would deprovision $($p.PackageName)"; continue }
            try {
                Remove-AppxProvisionedPackage -Online -PackageName $p.PackageName -ErrorAction Stop | Out-Null
                Write-Output "[OK]      deprovisioned $($p.PackageName)"; $removed++
            } catch {
                Write-Output "[FAIL]    deprovision $($p.PackageName): $($_.Exception.Message)"; $failed++
            }
        }
    } else {
        Write-Output "[SKIP]    $name - not provisioned"
    }

    # 2. Installed copies in any existing profile
    $inst = Get-AppxPackage -AllUsers -Name $name -ErrorAction SilentlyContinue
    if ($inst) {
        foreach ($i in $inst) {
            if ($i.NonRemovable) { Write-Output "[SKIP]    $($i.PackageFullName) is marked NonRemovable"; $skipped++; continue }
            if ($DryRun) { Write-Output "[DRYRUN] would remove $($i.PackageFullName)"; continue }
            try {
                Remove-AppxPackage -Package $i.PackageFullName -AllUsers -ErrorAction Stop
                Write-Output "[OK]      removed $($i.PackageFullName)"; $removed++
            } catch {
                Write-Output "[FAIL]    remove $($i.PackageFullName): $($_.Exception.Message)"; $failed++
            }
        }
    } else {
        Write-Output "[SKIP]    $name - not installed for any user"
    }
}

Write-Output "Done. Removed: $removed  Skipped: $skipped  Failed: $failed"
Stop-Transcript | Out-Null

# Exit 0 even if a single package failed: a leftover Solitaire must not make Intune report the
# whole provisioning as failed. Failures are in the log and get reviewed in verification.
exit 0
