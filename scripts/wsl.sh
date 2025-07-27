#!/bin/bash

# --- Update WSL ---
wsl --update

# --- Install Debian ---
wsl --install Debian

# --- Install required base packages ---
wsl sudo apt install -y curl wget gnupg