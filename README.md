# 42-vm-tutorial
This tutorial will guide you through the installation process of a Linux VM
intended to be used as a programming environment.

This tutorial assumes that you are using a Unix-based system i.e macOS or
Linux. On macOS, I recommend using [UTM](https://mac.getutm.app/). Download
it directly from the website or using Homebrew, since the version from the
AppStore cost 9.99 $ and is exactly the same as the free version. From now
on all the steps about setting up the VM assume that you are using UTM.

I recommend you choose a Linux distribution with a build that matches your
computer's architecture. [Ubuntu
Server](https://ubuntu.com/download/server) is what we will be using in
this tutorial since it supports both x86_64 (Intel) and ARM64 (Apple's
M1/M2). When creating the VM pick **Virtualize**, that way you will get
near native performances in your VM.

## Setting up the VM
**I recommend you give the VM at least 2048 Mb of RAM and 30 Gb of
storage.** You could probably get away with less disk space but keep in
mind that resizing the disk without reinstalling the VM can be a difficult
process. If your are short on RAM, you can probably allocate only 1024 Mb
of RAM to the VM and still be fine.

During installation leave everything to its default settings unless you
know what you are doing. Select `Install OpenSSH server` during
installation.

## SSH
+ On your computer, go into you `.ssh` folder with `cd ~/.ssh`. If the
  folder does not exist create it using `mkdir ~/.ssh`.
+ Use `ssh-keygen -t rsa -b 4096` to generate an SSH key pair. It is
  recommended that you name the key so that you can keep track of them.
+ You need to copy the public key that you have just created to your VM. To
  do that use `scp yourkey.pub username@serverip:`. Do not forget
the `:` at the end.
+ To be able to connect to the VM using your SSH key, you need to add it to
  the `authorized_keys` file using `cat yourkey.pub >>
.ssh/authorized_keys`. You can then delete the public key from the server
using `rm yourkey.pub`.
+ To make connecting to your VM easier, create a file called `config` in
  `.ssh` folder on your computer containing the following:
```sh
Host ubuntu # Replace with whatever name you see fit
    HostName 192.168.0.1 # Replace with your VM's IP
    IdentityFile ~/.ssh/ubuntu # Replace with the path to the private SSH key you have just created (the one without .pub at the end)
    User matthieu # Replace with your username on the VM
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

## Deploy the VM
This repository contains a script called `deploy.sh` which will take care
of most of the installation process. **Read the script before you run the
command below.**
```sh
sudo apt install git && \
git clone https://github.com/foobarberis/42-vm-tutorial.git && \
cd 42-vm-tutorial && chmod +x deploy.sh && ./deploy.sh
```
When the script is done, reboot the VM using `sudo reboot`. You should now
be able to SSH into your VM using `ssh ubuntu`.

## Git
+ First of all go to this URL: https://github.com/settings/tokens
+ Click on `Generate new token` and pick `Generate new token (classic)`.
+ Give the token a name and expiration date.
+ Select only the first category of scopes (the one named `repo`) and click
  on generate token.
+ Make sure you don't close the page since the token will be displayed only
  once. If you loose it you have to create a new one.
+ Now run the following command. **Don't forget to replace the values as
  necessary.**
```sh
git config --global credential.helper store
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```
+ Now try to clone one of your private repositories or push to one of your
  repositories. Git will ask you for you username and then for your
password. **When asked for the password paste the token you generated
earlier.**
+ You should now be able to use git without having to re-enter your
  credentials.

## Openbox
Openbox is a lightweight and highly configurable window manager. When you
launch it, you will be greated by a black screen. Don't panic! By default
Openbox has no menu bar or wallpaper. In order to bring up the lauch menu,
right click on the screen and select the application you want from the
menu.

## Xterm
The default terminal is Xterm. You can change the default font size by
modifing `~/.Xdefaults` or by holding `Control + Right Click` on an Xterm
window and picking a font size from the drop-down menu. You can copy/paste
using the middle mouse button.

## Setting up a proper resolution
See : https://askubuntu.com/a/377944

Check out `.xprofile` and `.bashrc` and modify them as you see fit.

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
