#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y mono-devel
sudo cp apt_batch_installer /usr/local/bin
sudo chmod a+rx-w /usr/local/bin/apt_batch_installer
#
sudo apt_batch_installer git curl
#
LocalCommit="$(./last-commit-local.sh)"
RemoteCommit="$(./last-commit-remote.sh)"
if [ "${LocalCommit}" = "${RemoteCommit}" ];
then
	echo "Local commit == Remote commit"
else
	echo "Local commit != Remote commit"
	echo "Version mismatch!"
	UuidgenFile="$(which uuidgen)"
	if test -f "${UuidgenFile}"
	then
		CurrPath="${PWD}"
		TmpPath="${HOME}/meta_install_$(uuidgen)"
		mkdir -p "${TmpPath}"
		cd "${TmpPath}"
		git clone "https://github.com/geekgit/linux_scripts_meta_2022"
		cd linux_scripts_meta
		./download-all.sh
		cd "${CurrPath}"
		rm -rf "${TmpPath}"
		git pull
		exit 0
	else
		exit 1
	fi	
fi

#
sudo apt-get update
sudo apt_batch_installer net-tools mesa-utils vulkan-utils git apt-transport-https fonts-takao-mincho fonts-takao-gothic fonts-takao fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho
sudo apt_batch_installer fonts-ipafont-gothic fonts-unfonts-core uuid-runtime htop git pv curl wget mtools dosfstools qemu-utils exfat-fuse exfat-utils sshpass gucharmap mdf2iso b5i2iso
sudo apt_batch_installer ccd2iso cdi2iso daa2iso nrg2iso pdi2iso iat genisoimage acetoneiso bchunk udftools brasero k3b innoextract qsstv ebook2cwgui fldigi gqrx-sdr cuneiform tesseract-ocr-all
sudo apt_batch_installer yagf grub-customizer mpv ffmpeg pavucontrol p7zip p7zip-full unrar vlc-bin vlc gnome-tweaks psensor lm-sensors xsensors gddrescue jmtpfs
sudo apt_batch_installer mtp-tools android-tools-fastboot android-tools-adb easytag sysstat webp pngquant python3-pip
# cdemu
sudo add-apt-repository -y ppa:cdemu/ppa

sudo apt_batch_installer gcdemu
#
wget  --secure-protocol=TLSv1_2 --https-only https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev -O screenfetch-dev
sudo cp screenfetch-dev /usr/local/bin/screenfetch-dev
sudo chown root:root /usr/local/bin/screenfetch-dev
sudo chmod a+rx-w /usr/local/bin/screenfetch-dev
rm screenfetch-dev
#
sudo pip install --upgrade speedtest-cli
###
git clone https://github.com/geekgit/linux_scripts
mkdir renamed
cd linux_scripts
rm -rf .git/
Scripts=$(find . -type f 2>/dev/null | grep .sh)
echo "Scripts: $Scripts"
for ScriptPath in $Scripts
do
	echo "Script path: $ScriptPath"
	Script=$(basename $ScriptPath)
	NewName=$(echo $Script | sed 's/\.sh//g')
	# prefix	
	NewName="geekgit-$NewName"
	echo "$Script -> $NewName"
	cp $ScriptPath ./../renamed/$NewName
done
echo "Clean /usr/local/bin..."
cd ..
sudo chmod a+rwx remove-all.sh
./remove-all.sh
cd renamed
sudo chown root:root *
sudo chmod a+rx-w *
echo "Install new scripts to /usr/local/bin"
sudo mv * /usr/local/bin
cd ..
rm -rf renamed/
rm -rf linux_scripts/
#
