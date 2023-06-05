#!/bin/bash
# Remove unecessary packages and services
sudo apt purge --auto-remove -y snapd squashfs-tools friendly-recovery apport at
sudo systemctl disable apt-daily-upgrade.timer
sudo systemctl mask apt-daily-upgrade.service
sudo systemctl disable apt-daily.timer
sudo systemctl mask apt-daily.service

# Backup the original configuration
sudo cp /etc/ssh/sshd_config $HOME/sshd_config.bak && \
# Deploy our new configuration
sudo cp ./sshd_config /etc/ssh/sshd_config && \
# Restart sshd
sudo systemctl restart sshd

# Update the system and install software
sudo apt update && sudo apt upgrade -y && \
sudo apt install -y gcc clang lldb gdb clang-format valgrind tmux git make vim python3 python3-pip xorg openbox libxext-dev libbsd-dev

# Install Norminette (to update use `python3 -m pip install --upgrade norminette')
python3 -m pip install --upgrade pip setuptools && python3 -m pip install norminette

# Deploy new dotfiles
cp ./.Xdefaults ./.xinitrc ./.xprofile ./.bashrc ./.profile $HOME/

# Reboot
echo 'Done! You can now reboot using sudo reboot'
