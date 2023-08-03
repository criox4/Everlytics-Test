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
if command -v apache2 >/dev/null 2>&1 || command -v httpd >/dev/null 2>&1; then
    echo "HTTPD is already installed."
else
    echo "HTTPD is not installed. Installing..."

    # Install HTTPD based on the OS family
    if [[ $ID_LIKE == *"debian"* ]]; then
        # Debian-based distributions
        sudo apt-get update
        sudo apt-get install -y apache2
    elif [[ $ID_LIKE == *"rhel fedora"* ]]; then
        # Red Hat-based distributions
        sudo yum update
        sudo yum install -y httpd
    else
        echo "Unsupported Linux distro. Please install 'httpd' manually."
        exit 1
    fi
fi

# Check the status of httpd application
if sudo systemctl is-active httpd >/dev/null 2>&1 || sudo systemctl is-active apache2 >/dev/null 2>&1; then
    echo "HTTPD is running."
else
    # Start httpd application if it's not running
    echo "HTTPD is not running. Starting..."
    if sudo systemctl is-active httpd >/dev/null 2>&1; then
        sudo systemctl start httpd
    elif sudo systemctl is-active apache2 >/dev/null 2>&1; then
        sudo systemctl start apache2
    fi
fi


git clone -b branch_name repository_url

git add -A  # Stage all changes in the project directory
git commit -m 'commit message'  # Create a commit with the staged changes with the commit message
git remote add origin <url> # Add the remote repository with the given URL as 'origin'
git remote -v # Show the list of remote repositories
git push origin <branch_name> # Push the committed changes 


<<<<<<< HEAD
<local changes>
=======
Incoming changes from the remote branch
>>>>>>> branch_name


git add resolved_file1 resolved_file2

git commit -m "Merge branch 'branch_name' into your_local_branch"

git commit -m "Merge branch 'branch_name' into your_local_branch"


git checkout -b new_local_branch_name origin/test_branch


git push -u origin your_local_branch:master

