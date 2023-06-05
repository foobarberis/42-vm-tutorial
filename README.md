# 42-vm-tutorial
This tutorial will guide you through the installation process of a Linux VM
intended to be used as a programming environment.

This tutorial assumes that you are using a Unix-based system i.e macOS or Linux.
On macOS, I recommend using [UTM](https://mac.getutm.app/). Download it directly
from the website or using Homebrew, since the version from the AppStore cost
9.99 $ and is exactly the same as the free version. From now on all the steps
about setting up the VM assume that you are using UTM. 

I recommend you choose a Linux distribution with a build that matches your
computer's architecture. [Ubuntu Server](https://ubuntu.com/download/server) is
what we will be using in this tutorial since it supports both x86_64 (Intel)
and ARM64 (Apple's M1/M2). When creating the VM pick **Virtualize**, that way
you will get near native performances in your VM.

I recommend you give the VM at least 2048 Mb of RAM and 30 Gb of storage. You
could get away with less disk space but keep in mind that resizing the disk
without reinstalling the VM can be a difficult process. 

During installation leave everything to its default settings unless you know
what you are doing. Select `Install OpenSSH server` during installation. If you
forgot, run `sudo apt update && sudo apt upgrade && sudo apt install
openssh-server`.

## SSH
+ On your computer, go into you `.ssh` folder with `cd ~/.ssh`. If the folder
  does not exist create it using `mkdir ~/.ssh`.
+ Use `ssh-keygen -t rsa -b 4096` to generate an SSH key pair. It is recommended
  that you name the key so that you can keep track of them.
+ You need to copy the public key that you have just created to your VM. To do
  that use `scp yourkey.pub username@serverip:`. Do not forget the `:` at the
end.
+ To be able to connect to the VM using your SSH key, you need to add it to
  the `authorized_keys` file using `cat yourkey.pub >> .ssh/authorized_keys`.
You can then delete the public key from the server using `rm yourkey.pub`.
+ Make a copy of the `sshd_config` with `sudo cp /etc/ssh/sshd_config /root/`.
+ Edit the content of the SSH daemon configuration using `sudo nano
  /etc/ssh/sshd_config` or `sudo vim /etc/ssh/sshd_config`.
+ A configuration example can be found below.
+ Once you have made changes in the `sshd_config` file, restart the daemon
  using `sudo systemctl restart sshd`.
+ To make connecting to your VM easier, create a file called `config` in `.ssh`
  folder on your computer containing the following
```sh
Host ubuntu # Replace with whatever name you see fit
    HostName 192.168.0.1 # Replace with your VM's IP
    IdentityFile ~/.ssh/ubuntu # Replace with the path to the private SSH key you have just created (the one without .pub at the end)
    User matthieu # Replace with your username on the VM
```

## Deploy the VM
This repository contains a script called `deploy.sh` which will take care of
most of the installation process. **Read the script before you run it.** Upon
first login you can launch the following command to setup your VM:
```sh
curl https://raw.githubusercontent.com/foobarberis/42-vm-tutorial/main/deploy.sh >> deploy.sh && chmod +x deploy.sh && sudo ./deploy.sh
```
## Automatic login

From [this forum post](https://forums.debian.net/viewtopic.php?t=123694).

For automatic login, run this command (as root):

```
sudo systemctl edit getty@tty1
```

Then enter this text and save the file afterwards:

```
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin YOURUSERNAME --noclear %I $TERM
```

Replace YOURUSERNAME with your user name. 
  
## Automatic `startx`
For automatic `startx` add this snippet to the end of the file at `~/.profile`:

```
[ "$(tty)" = "/dev/tty1" ] && exec startx
```
## Git
```sh
git config --global credential.helper store
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

## Openbox
Openbox is a lightweight and highly configurable window manager. When you launch
it, you will be greated by a black screen. Don't panic! By default Openbox has
no menu bar or wallpaper. In order to bring up the lauch menu, right click on
the screen and select the application you want from the menu.

## VSCode
In order to connect to your VM using VSCode you will need to install the first
extension of the following list of recommended extensions:
+ [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)
+ [Remote Explorer](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer)
+ [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
  (if you want to have Intellisense other goodies you have to install this
  extension on your VM too)
+ [42 Norminette Highlighter (3.x)](https://marketplace.visualstudio.com/items?itemName=MariusvanWijk-JoppeKoers.codam-norminette-3)
+ [42 Header](https://marketplace.visualstudio.com/items?itemName=kube.42header)
+ Setup proper resolution
+ Increase key repeat
