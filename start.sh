#!/bin/bash

echo ""
echo "1. Update"

sudo dnf update -y
sudo dnf autoremove -y
sudo dnf clean all

echo ""
echo "2. Uninstall bloat"

sudo dnf remove -y gnome-boxes
sudo dnf remove -y gnome-calendar
sudo dnf remove -y snapshot
sudo dnf remove -y gnome-characters
sudo dnf remove -y gnome-color-manager
sudo dnf remove -y gnome-connections
sudo dnf remove -y gnome-contacts
sudo dnf remove -y gnome-clocks
sudo dnf remove -y baobab
sudo dnf remove -y simple-scan
sudo dnf remove -y evince
sudo dnf remove -y firefox
sudo dnf remove -y 'libreoffice*'
sudo dnf remove -y gnome-font-viewer
sudo dnf remove -y gnome-logs 
sudo dnf remove -y gnome-maps
sudo dnf remove -y mediawriter
sudo dnf remove -y rhythmbox
sudo dnf remove -y gnome-tour 
sudo dnf remove -y gnome-weather
sudo dnf remove -y abrt
sudo dnf remove -y ibus-anthy
sudo dnf remove -y ibus-hangul
sudo dnf remove -y ibus-m17n
sudo dnf remove -y ibus-typing-booster
sudo dnf remove -y ibus-libpinyin

echo ""
echo "3. Install software"

sudo dnf install -y curl git dnf-plugins-core
curl -f https://zed.dev/install.sh | sh
curl -fsS https://dl.brave.com/install.sh | sh

sudo dnf install -y node
sudo dnf install -y go
sudo dnf install -y pip


echo ""
echo "4. Settings"

echo "	- Power settings"
sudo tuned-adm profile throughput-performance
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.desktop.screensaver idle-activation-enabled true
gsettings set org.gnome.desktop.session idle-delay 0

echo "	- Auto login"
USERNAME=$(logname)
sudo mkdir -p /etc/gdm
sudo bash -c "cat > /etc/gdm/custom.conf" <<EOF
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=$USERNAME
EOF

echo "	- Datetime"
gsettings set org.gnome.desktop.datetime automatic-timezone true
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-seconds true

echo "	- Privacy"
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy remove-old-temp-files true

echo "	- Accessibility"
gsettings set org.gnome.desktop.interface enable-animations false

echo "	- Appearance"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface accent-color 'orange'
gsettings set org.gnome.desktop.interface enable-hot-corners false

sudo reboot
