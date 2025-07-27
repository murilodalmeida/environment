# Environment

A quick way to setup a new windows computer with the apps I use and all of my preferences. Multiple system restarts are expected.

Before continuing update drivers and whatever you need manually. 

## 1. First Steps - Enabling features and installing apps.

WSL is required but ther than that, pick and choose whatever.

**All of the commands here requires elevanted permissions. Run terminal as admin.**

```ps1
    # Changing PowerShell Execution Policy (if necessary)
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
    
    # REQUIRED # Windows Subsystem for Linux (WSL)
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -All -NoRestart

    # Optional # Windows Virtual Machine Platform
    Enable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" -All -NoRestart

    # Optional # Windows Sandbox
    Enable-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM" -All -NoRestart

    # Install Apps
    Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/murilodalmeida/environment/refs/heads/main/scripts/apps.win.ps1" -UseBasicParsing).Content

    # Restart the system to apply changes and whatnot.
    Restart-Computer -Force
```

## 2. Configuring profiles.

From here use terminal with bash and elevated permissions are no longer required.

```bash
    # Configuring SSH key for git, .gitconfig file and .bashrc profiles.
    curl -sSL "https://raw.githubusercontent.com/murilodalmeida/environment/refs/heads/main/scripts/profiles.sh" | bash
```

## 3. Installing and Configuring WSL

```bash
    # Install Debian before continuing
    wls --update && wsl --install Debian

    # Install apps
    wsl -d Debian -- bash -c curl -sSL "https://raw.githubusercontent.com/murilodalmeida/environment/refs/heads/main/scripts/apps.wsl.sh" | bash
```