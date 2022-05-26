# Dual boot Arch with Windows 11 on a Surface Book 3

## Fully Update your Windows Machine 

Ensure your machine has the latest updates and firmware installed on the
windows side.

## Disable BitLocker Encryption

Later in this guide we will disable secure boot. If you have BitLocker
enabled, you will have to reenter your BitLocker key in order to boot your
device. My preference is to disable BitLocker entirely, but if you want to
keep it turned on make sure you have your BitLocker key. 

### Obtain your BitLocker Key

From the settings menu click `Privacy encryption > Find your BitLocker
recovery key` 

### Disable BitLocker

From the settings menu click `Privacy & Security > Device encryption` and
turn `Device encryption` off. At the warning prompt click `Turn off`

## Resize Windows Partition

### Launch Disk Management

Press `WIN + R` to get a run dialog and run `diskmgmt.msc`.

### Resize the `Local Disk (C:)` Partition

Right click on `Local Disk (C:)` and click `Shrink Volume...`

Enter the amount of space you would like to set aside for Linux. I have
the 512GB Model, so I like to give linux roughly half at 256GB. The size
is in MB, so 256 * 1024 = 262144MB then click `Shrink`.  The Windows
partition ends up being slightly smaller because of the recovery
partition, boot partition and the fact that manufactures report drive
sizes in GiB not GB. Resize as you see fit.

## Disable Secure Boot and Adjust Boot Order

Arch does not configure secure boot out of the box. Though it is possible
to configure, I have not attempted it yet and simply disable secure boot
in my setup.

### Reboot into the UEFI

Reboot your machine and hold down the `volume up` button during boot to
enter the UEFI Menu

### Disable Secure Boot

From the `Security` menu, under `Secure Boot` click `Change configuration`

Select `None` and click `OK`

### Adjust Boot Order

From the `Boot Configuration` menu, click and drag `USB Storage` to the
top of your boot order.

### Reboot to Arch Installer

Plug in your USB drive with the Arch ISO

From the `Exit` menu click `Restart now`

Your machine should boot to the Arch install environment

## Install Arch

### Set the console keyboard layout 

The default keyboard layout is US. If you are using a US keyboard you can
skip this step. If you need to adjust your layout follow the step on the
[ArchWiki](https://wiki.archlinux.org/title/installation_guide#Set_the_console_keyboard_layout).

### Connect to the Internet

Get an interactive `iwctl` prompt:

`# iwctl`

Scan for networks

`[iwd]# station wlan0 scan`

List available networks

`[iwd]# station wlan0 get-networks`

Connect to your wifi network

`[iwd]# station wlan0 connect <YOUR_SSID>`

Enter your Passphrase if prompted

Verify your connection with

`[iwd]# station wlan0 show`

Exit `iwdctl` with

`[iwd]# exit`

### Update the system clock

`# timedatectl set-ntp true`

### Partition the disks

List your block devices with 

`# fdisk -l` 

There should be 3 devices listed `/dev/nvme0n1` is the one we are
concerned with. It will have 4 existing partitions.  We will be adding
2 more.

Use fdisk to modify partition tables

`# fdisk /dev/nvme0n1`

Verify free space

`Command (m for help): F`

If all went well shrinking the drive earlier, you should see a free space
the size you specified, in my case `256G`

The amount of space to set aside for swap is debatable. I use 8GB. If you
ever want to hibernate it needs to exceed the size of your RAM, but I do
not use that feature, and I'm not sure if its even supported.

Create a swap partition 

`Command (m for help): n`

You can leave the partition number and first sector default

For Last sector enter

`Last sector, ... : +<SIZE IN GB>G`

In my example I would enter `+8G`

By default this will create a `Linux filesystem` partition. We need to
change it to a swap partition.

`Command (m for help): t`

Select the partition number you just created (likely 5)

`Partition number...: 5`

Select the partition type `Linux swap`

`Partition type or alias ... : 19`

Now we can create our root partition with the remaining space

`Command (m for help): n`

You can leave the partition number, first sector, and last sector all
default.  The `Linux filesystem` type for this partition is fine as well

Write the table to the disk and exit

`Command (m for help): w`

### Format the partitions

If you have been following along with me your swap partition should be on
`/dev/nvme0n1p5` and your root partition should be on `/dev/nvme0n1p6`.

Format your swap partition

`# mkswap /dev/nvme0n1p5`

Format your root partition

`# mkfs.ext4 /dev/nvme0n1p6`

We will use the existing EFI boot partition from windows so there is no
need to format that partition.

### Mount the file systems

Mount the root partition

`# mount /dev/nvme0n1p6 /mnt`

Create the boot mount point

`# mkdir /mnt/boot`

Mount the boot partition

`# mount /dev/nvme0n1p1 /mnt/boot`

Enable the swap partition

`# swapon /dev/nvme0n1p5`

### Install the initial packages

Use pacstrap to install the base, kernel, and firmware packages. I include
neovim here to edit files later. You can include your favorite text
editor.

`# pacstrap /mnt base linux linux-firmware neovim` 

## Configure the system

### Fstab

Generate an fstab file

`# genfstab -U /mnt >> /mnt/etc/fstab`

### Chroot

Change root into the new system

`# arch-chroot /mnt`

### Time zone

Set the time zone:

`# ln -sf /usr/share/zoneinfo/<REGION>/<CITY> /etc/localtime`

Run hwclock to generate `/etc/adjtime`

`# hwclock --systohc`

### Localization

Edit `/etc/locale.gen` and uncomment `en_US.UTF-8 UTF-8` and other needed
locales.

`# nvim /etc/locale.gen`

Generate the locales

`# locale-gen`

Create and edit the `/etc/locale.conf` file

`# nvim /etc/locale.conf`

Set the `LANG` variable by adding the following line to the file

`LANG=en_US.UTF-8`

If you set the console keyboard layout, make the changes persistent by
adding and editing the file `/etc/vconsole.conf`

`# nvim /etc/vconsole.conf`

Add your keyboard layout with the following 

`KEYMAP=<your keymap>` for example: `KEYMAP=de-latin1`

### Network configuration

Create and edit the hostname file

`# nvim /etc/hostname` 

Simply add your desired hostname to the first line of the file. For
example `archbook`

Install a network manager. I use iwd just like the installer

`# pacman -S iwd dhcpcd`

Enable the iwd service at boot

`# systemctl enable iwd`

Enable the dhcpcd service at boot

`# systemctl enable dhcpcd`

### Root password

Set the root password

`# passwd`

### Intel Microcode

Install the Intel Microcode

`# pacman -S intel-ucode`

### Boot Loader

Install a boot loader. I use refind

`# pacman -S refind`

Activate refind as the boot loader

`# refind-install`

When `refind-install` is run in a chroot environment like we are now, 
`/boot/refind_linux.conf` is populated with kernel options from the live system,
not the one on which it is installed. Edit the `/boot/refind_linux.conf` file
and simply delete the first two lines. We will be changing this later anyway.

`# nvim /boot/refind_linux.conf`

Leave only the following line
`"Boot with minimal options"  "ro root=/dev/nvme0n1p6"`

## Reboot

Exit the chroot environment

`# exit`

Reboot

`# reboot`

You should be greeted with your rEFInd boot menu where you can select your Arch
install or you Windows install. Boot your Arch Install and log in as root using
the password you setup earlier

## Create an admin user

Create a user with the wheel group

`# useradd -m -G wheel <USERNAME>`

Give the new user a password

`# passwd <USERNAME>`

Allow users of the `wheel` group to use `sudo`

`# nvim /etc/sudoers`

Uncomment the line 

`%wheel ALL=(ALL:ALL) ALL`

Log out and log back in as your new user

`# logout`

## Install the linux-surface kernel

Connect to the internet using `iwctl` and the instructions above

Import the keys used to sign the packages

```
$ curl -s https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc \ 
| sudo pacman-key --add -
```

Check and verify the fingerprint of the key

`$ sudo pacman-key --finger 56C464BAAC421453`

Locally sign the key

`$ sudo pacman-key --lsign-key 56C464BAAC421453` 

Open `/etc/pacman.conf` for editing

`$ sudo nvim /etc/pacman.conf`

Add the following to the bottom

```
[linux-surface]
Server = https://pkg.surfacelinux.com/arch/
```

Refresh the repositories

`$ sudo pacman -Syu`

Install `linux-surface` `linux-surface-headers` and `iptsd`

`$ sudo pacman -S linux-surface linux-surface-headers iptsd`

Enable `iptsd` at boot

`$ sudo systemctl enable iptsd`

## Install libwacom-surface from the AUR

Install git and the required build tools and dependencies

`$ sudo pacman -S git base-devel`

Clone the libwacom-surface repository

`$ git clone https://aur.archlinux.org/libwacom-surface.git`

Change to the libwacom-surface directory

`$ cd libwacom-surface`

Get the gpg key for libwacom

`$gpg --recv-key E23B7E70B467F0BF`

Build and install the package

`$ makepkg -sirc`

## Edit bootloader

Edit `refind_linux.conf`

`$ sudo nvim /boot/refind_linux.conf`

Update it to read
```
"Boot using default options"     "root=/dev/nvme0n1p6 rw add_efi_memmap initrd=intel-ucode.img initrd-initramfs-linux-surface.img"
"Boot usind fallback initramfs"  "root=/dev/nvme0n1p6 rw add_efi_memmap initrd=intel-ucode.img initrd-initramfs-linux-surface-fallback.img"
"Boot to terminal"               "root=/dev/nvme0n1p6 rw add_efi_memmap initrd=intel-ucode.img initrd-initramfs-linux-surface.img systemd.unit=multi-user.target"
"Boot with minimal options"      "ro root=/dev/nvme0n1p6"
```

