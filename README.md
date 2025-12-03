# Command Scripts Repository

This repository contains a collection of utility scripts for various system management, development, and automation tasks. Each script has been renamed and improved for better clarity and usability.

## Table of Contents

1. [System Management](#system-management)
2. [Backup & File Management](#backup--file-management)
3. [System Configuration & Fixes](#system-configuration--fixes)
4. [Network & Firewall](#network--firewall)
5. [Hardware & Drivers](#hardware--drivers)
6. [Media & Media Software](#media--media-software)
7. [Virtualization & Gaming](#virtualization--gaming)
8. [Desktop Environment](#desktop-environment)
9. [Applications & Development](#applications--development)
10. [System Services & Maintenance](#system-services--maintenance)
11. [Mount & Storage](#mount--storage)
12. [Other Utilities](#other-utilities)

---

## System Management

### `gpu-amd-override`
- **Purpose**: Force AMD GPU usage with specific OpenGL version
- **Usage**: `gpu-amd-override <command>`
- **Example**: `gpu-amd-override glxinfo`
- **Description**: Sets environment variables to force use of AMD GPU with OpenGL 4.4

### `flush-system-cache`
- **Purpose**: Flush system caches to free memory
- **Usage**: `sudo flush-system-cache`
- **Description**: Syncs data to disk and drops page cache, dentries and inodes

### `disable-gnome-tracker`
- **Purpose**: Completely disable GNOME Tracker3 daemon
- **Usage**: `disable-gnome-tracker`
- **Description**: Disables Tracker3 by setting configuration options to prevent file indexing

### `fix-permissions`
- **Purpose**: Fix directory permissions using pacrepairfile
- **Usage**: `fix-permissions <directory>`
- **Description**: Runs pacrepairfile on all files in a directory to fix permissions

### `rescan-hard-drives`
- **Purpose**: Rescan hard drives to detect new partitions
- **Usage**: `sudo rescan-hard-drives`
- **Description**: Forces the system to rescan hard drives

### `fix-wifi`
- **Purpose**: Fix WiFi connectivity issues
- **Usage**: `sudo fix-wifi`
- **Description**: Various WiFi troubleshooting commands

### `recover-hard-drive`
- **Purpose**: Recovery script for hard drives
- **Usage**: `sudo recover-hard-drive`
- **Description**: Hard drive recovery procedures

---

## Backup & File Management

### `rsync-backup`
- **Purpose**: Secure backup script with common exclusions
- **Usage**: `sudo rsync-backup [OPTIONS] SOURCE DEST`
- **Example**: `sudo rsync-backup /home/user/ /backup/location/`
- **Description**: Performs rsync backup with common system file exclusions

### `organize-files-into-dirs`
- **Purpose**: Create directories from file names and move files into them
- **Usage**: `organize-files-into-dirs [DIRECTORY]`
- **Description**: For each file, creates a directory with the same name and moves the file

### `mount-encrypted-backup`
- **Purpose**: Mount encrypted backup using encfs
- **Usage**: `mount-encrypted-backup`
- **Description**: Mounts encrypted backup in reverse mode for cloud storage

### `merge-directories`
- **Purpose**: Move and merge directories, overwriting existing files
- **Usage**: `merge-directories SOURCE_DIR DEST_DIR`
- **Description**: Recursively moves files from source to destination, merging directories

### `sort-photorec-files`
- **Purpose**: Sort PhotoRec recovery files by extension
- **Usage**: `sort-photorec-files`
- **Description**: Organizes recovered files by their extensions

### `sort-by-date`
- **Purpose**: Sort files by date
- **Usage**: `sort-by-date [OPTIONS]`
- **Description**: Sorts files by modification date

### `sort-by-date-backup`
- **Purpose**: Sort files by date (backup version)
- **Usage**: `sort-by-date-backup`
- **Description**: Backup version of date sorting script

### `sort-by-date-annual`
- **Purpose**: Sort files by date annually
- **Usage**: `sort-by-date-annual`
- **Description**: Annual version of date sorting script

### `sort-media-by-date`
- **Purpose**: Sort media files by date
- **Usage**: `sort-media-by-date`
- **Description**: Sorts media files by modification date

### `clean-snapshots`
- **Purpose**: Clean system snapshots
- **Usage**: `clean-snapshots`
- **Description**: Removes old or unnecessary system snapshots

---

## System Configuration & Fixes

### `fix-alt-tab-behavior`
- **Purpose**: Change Alt+Tab behavior in GNOME to switch between windows
- **Usage**: `fix-alt-tab-behavior [OPTIONS]`
- **Description**: Changes GNOME's Alt+Tab to switch between individual windows instead of applications

### `start-compositor`
- **Purpose**: Start Compton compositor for specific desktop environments
- **Usage**: `start-compositor`
- **Description**: Starts Compton for LXQt and LXDE desktop environments

### `fix-gtk-resize`
- **Purpose**: Fix GTK resize issues
- **Usage**: `fix-gtk-resize`
- **Description**: Addresses GTK window resize behavior problems

### `fix-lenovo-mic`
- **Purpose**: Fix Lenovo microphone issues using HDA hardware interface
- **Usage**: `sudo fix-lenovo-mic`
- **Description**: Direct hardware access to fix microphone on some Lenovo laptops

### `setup-lenovo-mic-service`
- **Purpose**: Set up systemd service for Lenovo microphone fix
- **Usage**: `sudo setup-lenovo-mic-service`
- **Description**: Creates systemd service to automatically fix mic on boot

### `fix-lenovo-320-mic`
- **Purpose**: Fix microphone on Lenovo 320 model
- **Usage**: `fix-lenovo-320-mic`
- **Description**: Specific fix for Lenovo 320 microphone issues

### `fix-nautilus-backspace`
- **Purpose**: Fix Nautilus backspace behavior
- **Usage**: `fix-nautilus-backspace`
- **Description**: Restores backspace functionality for directory navigation

---

## Network & Firewall

### `block-sites-firewall`
- **Purpose**: Block websites using OpenWRT firewall and IP sets
- **Usage**: `sudo block-sites-firewall`
- **Description**: Configures OpenWRT to block websites with time-based restrictions

### `block-roblox-firewall`
- **Purpose**: Block Roblox on OpenWRT
- **Usage**: `sudo block-roblox-firewall`
- **Description**: Specific script to block Roblox sites on OpenWRT

### `setup-firewalld-kdeconnect`
- **Purpose**: Configure firewalld for KDE Connect ports
- **Usage**: `sudo setup-firewalld-kdeconnect`
- **Description**: Opens necessary ports for KDE Connect

### `clean-ipv6-temp-addr`
- **Purpose**: Clean IPv6 temporary addresses
- **Usage**: `clean-ipv6-temp-addr`
- **Description**: Removes temporary IPv6 addresses

---

## Hardware & Drivers

### `btrfs-fix-corruption`
- **Purpose**: Find BTRFS filesystem corruption and identify affected files
- **Usage**: `sudo btrfs-fix-corruption`
- **Description**: Searches dmesg for BTRFS checksum errors and identifies files

### `setup-vfio-gpu`
- **Purpose**: Set up GPU passthrough with VFIO for virtualization
- **Usage**: `sudo setup-vfio-gpu`
- **Description**: Configures PCI devices for GPU passthrough in virtualization

### `setup-vfio`
- **Purpose**: General VFIO setup
- **Usage**: `setup-vfio`
- **Description**: General VFIO configuration script

### `force-secondary-vga-vfio`
- **Purpose**: Force secondary VGA for VFIO
- **Usage**: `force-secondary-vga-vfio`
- **Description**: Forces secondary VGA for use with VFIO

### `check-vga-ram`
- **Purpose**: Check VGA RAM information
- **Usage**: `check-vga-ram`
- **Description**: Displays VGA RAM information

### `set-nvidia-performance`
- **Purpose**: Set NVIDIA GPU performance mode
- **Usage**: `set-nvidia-performance`
- **Description**: Sets NVIDIA GPU to performance mode

### `turn-off-gpu`
- **Purpose**: Turn off GPU
- **Usage**: `turn-off-gpu`
- **Description**: Powers down GPU

### `reattach-vga`
- **Purpose**: Reattach VGA after GPU reset
- **Usage**: `reattach-vga`
- **Description**: Reattaches VGA to display after GPU operations

### `reload-udev-rules`
- **Purpose**: Reload udev rules
- **Usage**: `reload-udev-rules`
- **Description**: Reloads hardware configuration rules

### `reload-sata`
- **Purpose**: Reload SATA drivers
- **Usage**: `reload-sata`
- **Description**: Reloads SATA controller drivers

### `get-module-params`
- **Purpose**: Get kernel module parameters
- **Usage**: `get-module-params <module>`
- **Description**: Displays parameters for a specified kernel module

### `read-vga-rom`
- **Purpose**: Read VGA ROM
- **Usage**: `read-vga-rom`
- **Description**: Reads the VGA ROM from hardware

---

## Media & Media Software

### `cd-dvd-burn`
- **Purpose**: Burn CD/DVD using cdrdao
- **Usage**: `cd-dvd-burn <toc_file>`
- **Description**: Creates command to burn CDs/DVDs using cdrdao with recommended settings

### `pdf-merge-optimize`
- **Purpose**: Merge and optimize PDF files using Ghostscript
- **Usage**: `pdf-merge-optimize [OPTIONS] <input_pdfs>`
- **Description**: Merges PDFs with different optimization options

### `rip-dvd`
- **Purpose**: Rip DVD content
- **Usage**: `rip-dvd`
- **Description**: Extracts content from DVD

### `rip-videos-from-dir`
- **Purpose**: Rip videos from a directory
- **Usage**: `rip-videos-from-dir <directory>`
- **Description**: Extracts video files from a specified directory

---

## Virtualization & Gaming

### `connect-windows-vm`
- **Purpose**: Connect to Windows VM via RDP
- **Usage**: `connect-windows-vm`
- **Description**: Connects to Windows VM using Wayland FreeRDP client

### `launch-windows-vm`
- **Purpose**: Launch Windows 10 VM with QEMU/KVM
- **Usage**: `launch-windows-vm`
- **Description**: Starts Windows 10 VM with detailed configuration

### `launch-windows-vm-headless`
- **Purpose**: Launch Windows VM without display
- **Usage**: `launch-windows-vm-headless`
- **Description**: Starts Windows VM without GUI display

### `launch-windows-vm-no-video`
- **Purpose**: Launch Windows VM without video output
- **Usage**: `launch-windows-vm-no-video`
- **Description**: Starts Windows VM without video hardware

### `mount-windows-hd`
- **Purpose**: Mount Windows hard drive
- **Usage**: `sudo mount-windows-hd`
- **Description**: Mounts Windows hard drive partition

### `unmount-windows-hd`
- **Purpose**: Unmount Windows hard drive
- **Usage**: `sudo unmount-windows-hd`
- **Description**: Safely unmounts Windows hard drive partition

### `launch-genshin`
- **Purpose**: Launch Genshin Impact game
- **Usage**: `launch-genshin`
- **Description**: Starts the Genshin Impact game

### `launch-roblox`
- **Purpose**: Launch Roblox
- **Usage**: `launch-roblox`
- **Description**: Starts Roblox application

### `launch-roblox-player`
- **Purpose**: Launch Roblox Player
- **Usage**: `launch-roblox-player`
- **Description**: Starts Roblox Player application

### `restart-kvm-network`
- **Purpose**: Restart KVM network
- **Usage**: `sudo restart-kvm-network`
- **Description**: Restarts the KVM virtual network

---

## Desktop Environment

### `fix-screen-tearing`
- **Purpose**: Fix screen tearing in XFCE
- **Usage**: `fix-screen-tearing`
- **Description**: Addresses screen tearing issues in XFCE desktop

### `start-gnome-x11`
- **Purpose**: Start GNOME on X11
- **Usage**: `start-gnome-x11`
- **Description**: Starts GNOME session using X11 instead of Wayland

### `force-wayland`
- **Purpose**: Force Wayland session
- **Usage**: `force-wayland`
- **Description**: Forces session to use Wayland compositor

### `start-waydroid-wayland`
- **Purpose**: Start Waydroid from Wayland
- **Usage**: `start-waydroid-wayland`
- **Description**: Starts Waydroid Android container from Wayland session

---

## Applications & Development

### `monitor-file-access`
- **Purpose**: Monitor file access of a given command using strace
- **Usage**: `monitor-file-access [OPTIONS] -- <command>`
- **Description**: Tracks file access by a command using system call tracing

### `monitor-system-calls`
- **Purpose**: Monitor system calls of a given command using strace
- **Usage**: `monitor-system-calls [OPTIONS] -- <command>`
- **Description**: Tracks system calls for file access and hardware information

### `install-pt-br-dict-qtweb`
- **Purpose**: Install Brazilian Portuguese dictionary for QtWebEngine
- **Usage**: `install-pt-br-dict-qtweb`
- **Description**: Adds PT-BR dictionary support to QtWebEngine

### `take-screenshot`
- **Purpose**: Take a screenshot
- **Usage**: `take-screenshot`
- **Description**: Captures screenshot using system tools

---

## System Services & Maintenance

### `install-conda`
- **Purpose**: Install Conda package manager
- **Usage**: `install-conda`
- **Description**: Installs the Conda package manager

### `limit-cpu-usage`
- **Purpose**: Limit CPU usage
- **Usage**: `limit-cpu-usage`
- **Description**: Limits overall CPU usage for system stability

### `limit-chromium-cpu`
- **Purpose**: Limit CPU usage specifically for Chromium
- **Usage**: `limit-chromium-cpu`
- **Description**: Limits CPU usage for Chromium browser

### `reset-teamviewer`
- **Purpose**: Reset TeamViewer
- **Usage**: `reset-teamviewer`
- **Description**: Resets TeamViewer to default state

### `update-lutris-wine`
- **Purpose**: Update Lutris Wine versions
- **Usage**: `update-lutris-wine`
- **Description**: Updates Wine versions used by Lutris

### `fix-vm-bios`
- **Purpose**: Fix VM BIOS settings
- **Usage**: `fix-vm-bios`
- **Description**: Adjusts VM BIOS configuration

### `setup-luks-key-unlock`
- **Purpose**: Set up LUKS key unlock
- **Usage**: `setup-luks-key-unlock`
- **Description**: Sets up automated LUKS encryption key unlocking

---

## Mount & Storage

### `make-key-unlock-luks`
- **Purpose**: Make key unlock for LUKS encrypted volumes
- **Usage**: `make-key-unlock-luks`
- **Description**: Creates key-based unlocking for LUKS encrypted storage

---

## Other Utilities

### `launch-keepassxc`
- **Purpose**: Launch KeePassXC password manager
- **Usage**: `launch-keepassxc`
- **Description**: Starts KeePassXC password manager application

### `connect-windows-rdp`
- **Purpose**: Connect to Windows via RDP
- **Usage**: `connect-windows-rdp`
- **Description**: Establishes RDP connection to Windows machine

### `launch-photoshop`
- **Purpose**: Launch Adobe Photoshop
- **Usage**: `launch-photoshop`
- **Description**: Starts Adobe Photoshop application

### `create-bootable-usb`
- **Purpose**: Create bootable USB from compressed image
- **Usage**: `create-bootable-usb`
- **Description**: Creates bootable USB drive from a compressed image file

### `start-streaming`
- **Purpose**: Start streaming service
- **Usage**: `start-streaming`
- **Description**: Starts streaming application or service

### `killall-wine`
- **Purpose**: Kill all Wine processes
- **Usage**: `killall-wine`
- **Description**: Terminates all running Wine processes

---

## Usage Notes

1. **Permissions**: Most scripts require specific permissions to run. System administration scripts typically require `sudo`.
2. **Dependencies**: Each script specifies its dependencies in the help text. Install as needed.
3. **Help**: All scripts support `-h` or `--help` for usage information.
4. **Safety**: Scripts that modify system configuration are clearly marked with warnings.

## Contributing

To contribute to this repository:
1. Fork the repository
2. Make your changes
3. Test thoroughly
4. Submit a pull request with clear descriptions

## License

This collection of scripts is provided as-is for personal and educational use.