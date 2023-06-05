#!/bin/sh
# Remove unecessary packages and services
apt purge --auto-remove unattended-upgrades snapd squashfs-tools friendly-recovery apport ati && \
systemctl disable apt-daily-upgrade.timer && \
systemctl mask apt-daily-upgrade.service && \
systemctl disable apt-daily.timer && \
systemctl mask apt-daily.service && \
# First update the system
apt update && apt upgrade -y && \
# Install software
apt install gcc clang lldb gdb clang-format valgrind tmux git make vim python3 python3-pip xorg openbox fonts-inconsolata libxext-dev libbsd-dev && \
# Install Norminette (to update use `python3 -m pip install --upgrade norminette')
python3 -m pip install --upgrade pip setuptools && python3 -m pip install norminette && \
git clone https://github.com/foobarberis/42-vm-tutorial && cd 42-vm-tutorial && \
# Deploy new sshd_config
cp /etc/ssh/sshd_config $HOME/sshd_config.bak && cp ./sshd_config /etc/ssh/sshd_config && \
# Deploy new dotfiles
mkdir -p ~/.config/openbox/ && \
cp ./.Xdefaults ./.xinitrc ./xprofile ./.bashrc ./$HOME/
