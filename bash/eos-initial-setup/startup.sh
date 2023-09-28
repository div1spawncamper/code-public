#!/usr/bin/bash

# Arch Configuration Kit 0.1
# This script sets up a basic Arch Linux installation,
# including modifying the hosts file, network configuration,
# installation of essential packages, and configuring useful aliases.


echo -e "Adding hosts to hosts file"
sudo echo "192.168.111.7 archive" >> /etc/hosts
sudo echo "192.168.111.6 mainframe" >> /etc/hosts
sudo echo "192.168.111.1 router" >> /etc/hosts
sudo echo "192.168.111.17 div" >> /etc/hosts
sudo echo "div1" >> /etc/hostname
echo -e "Hosts added"
sleep 1


echo -e "Setting .17 ip"
nmcli con mod  'Conexión cableada 1' ipv4.addresses "192.168.111.17/24"
nmcli con mod  'Conexión cableada 1' ipv4.gateway "192.168.111.1"
nmcli con mod  'Conexión cableada 1' ipv4.dns "1.1.1.1 1.0.0.1"
nmcli con mod  'Conexión cableada 1' ipv4.method manual
nmcli con up   'Conexión cableada 1'
echo -e "IP added"

#Checking if IP has been added correctly.
if sudo grep -w '192.168.111.17|cable' /etc/NetworkManager/system-connections/ ; then
    echo -e "IP added correctly"
else
    echo -e "IP not set"
fi
read -p "Continue (y/n)?" choice  
case "$choice" in
  y|Y ) echo "yes";;
  n|N ) exit;;
  * ) echo "invalid";;
esac
sleep 1

echo -e "Installing packages + lutris + flatpaks"
sudo pacman -S --needed --noconfirm wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxineramalib32 libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
sudo pacman -S --needed --noconfirm nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
sudo pacman -S --noconfirm yakuake wol virt-viewer sshpass  qbittorrent obs-studio  discord chromium btop lutris arp-scan flatpak zsh zsh-completions
yay -S --noconfirm visual-studio-code-bin

echo -e "Packages installed."
echo -e "Defaulting zsh"
sleep 1
chsh -s /usr/bin/zsh
echo -e "Completed."
sudo chmod 777 /home/dugi/.bashrc
sudo chmod 777 /home/dugi/.zshrc

echo -e "Installing powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
echo -e "p10k installed."

echo -e "installing flatpaks"
flatpak -y install flathub com.spotify.Client
flatpak -y install flathub com.valvesoftware.Steam
echo -e "flatpaks installed"

sudo chmod 777 /home/dugi/.bashrc
sudo chmod 777 /home/dugi/.zshrc

echo -e "Adding aliases into .bashrc"
#Save .zshrc path for future references
#echo "alias va='ls -lrtha --color=auto'" >>   /home/dugi/.bashrc  /home/dugi/.zshrc   
echo "alias va='ls -lrtha --color=auto'" >>   /home/dugi/.bashrc
echo "alias p='pwd'" >>  /home/dugi/.bashrc
echo "alias c='clear'" >> /home/dugi/.bashrc
echo "alias rmr='sudo rm -R'" >> /home/dugi/.bashrc
echo "alias rmf='sudo rm'" >> /home/dugi/.bashrc
echo "alias v='ls -lrth --color=auto'" >> /home/dugi/.bashrc
echo "alias cdc='cd /home/dugi/code'" >> /home/dugi/.bashrc
echo "alias shutd='sudo shutdown -h now'" >> /home/dugi/.bashrc
echo "alias reboot='sudo systemctl reboot'" >> /home/dugi/.bashrc
echo "alias pacupd='sudo pacman -Syyuu'" >> /home/dugi/.bashrc
echo "alias pac='sudo pacman -S --noconfirm'" >> /home/dugi/.bashrc
echo "alias ip='ip -c a'" >> /home/dugi/.bashrc
echo -e "Aliases added"

git config --global user.name "div1spawncamper"
git config --global user.email doogie17@gmail.com

echo -e "All OK."
