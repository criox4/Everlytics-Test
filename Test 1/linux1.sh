#!/bin/bash

# Check Linux OS distribution
if [ -f /etc/os-release ]; then
    source /etc/os-release
    echo "Linux Distro: $NAME"
    echo "Linux Distro Family: $ID_LIKE"
else
    echo "Unknown Linux Distro"
fi

# Check if 'httpd' is installed
if command -v httpd >/dev/null 2>&1; then
    echo "httpd is already installed."
else
    echo "httpd is not installed. Installing httpd..."
    
    # Install httpd based on the OS family
    if [[ $ID_LIKE == *"debian"* ]]; then
        # Debian-based distributions
        sudo apt update
        sudo apt install -y apache2
    elif [[ $ID_LIKE == *"rhel fedora"* ]]; then
        # Red Hat-based distributions
        sudo yum update
        sudo yum install -y httpd
    elif [[ $ID_LIKE == *"suse"* ]]; then
        # SUSE-based distributions
        sudo zypper refresh
        sudo zypper install -y apache2
    elif [[ $ID == "arch" || $ID_LIKE == *"archlinux"* ]]; then
        # Arch Linux-based distributions
        sudo pacman -Syu --noconfirm
        sudo pacman -S --noconfirm apache
    else
        echo "Unsupported Linux distro. Please install 'httpd' manually."
        exit 1
    fi
fi

# Check the status of httpd application
if sudo systemctl is-active httpd >/dev/null 2>&1; then
    echo "httpd is running."
else
    # Start httpd application if it's not running
    echo "httpd is not running. Starting httpd..."
    sudo systemctl start httpd
fi
