# 42-vm-tutorial
The goal of this tutorial is to setup a Ubuntu VM for you to have a nice
programming environment. Once the VM is setup, you will be able to connect to it
using VSCode's SSH extension or even program on directly if you like.

This tutorial assumes that you are using a Unix-based system i.e macOS or Linux.
On macOS, I recommend using [UTM](https://mac.getutm.app/). Download it directly
from the website or using Homebrew, since the version from the AppStore cost
9.99 $ and is exactly the same as the free version. From now on all the steps
about setting up the VM assume that you are using UTM.

I recommend you choose a Linux distribution with a build that matches the host
architecture. [Ubuntu Server](https://ubuntu.com/download/server) is probably
what you want since it supports both x86_64 (Intel processors) and ARM64
(Apple's M1/M2 processors). When creating the VM pick **Virtualize**, that way
you will get near native performances in your VM.

I recommend you give the VM 2048 Mb of RAM and 25-30 Gb of storage.

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

## Setup automatic login
### Setup automatic login

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
  
### Automatic `startx`
For automatic `startx` add this snippet to the end of the file at `~/.profile`:

```
[ "$(tty)" = "/dev/tty1" ] && exec startx
```


**Note:** the following steps do not seem to be necessary.

Finally, set the correct default.target to ensure the system boots to the console (TTY) rather than to a display manager:

```
# systemctl set-default multi-user.target
```

To reverse this change, reset the default.target with:

```
# systemctl set-default graphical.target
```


## Git
+ [[Setup Git credentials]]![[Set git credentials]]

## Openbox
Openbox is a lightweight and highly configurable window manager. When you launch
it, you will be greated by a black screen. Don't panic! By default Openbox has
no menu bar or wallpaper. In order to bring up the lauch menu, right click on
the screen and select the application you want from the menu.

+ Setup proper resolution
+ Increase key repeat
