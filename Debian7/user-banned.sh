#!/bin/bash
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
BlueF='\e[1;34m'

if [[ $USER != 'root' ]]; then
	echo -e $yellow"Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

MYIP=$(wget -qO- ipv4.icanhazip.com)

#vps="iqbalfaf";
vps="vps";

if [[ $vps = "iqbalfaf" ]]; then
	source="http://deb.mbahshondong.com"
else
	source="http://deb.mbahshondong.com"
fi

# go to root
cd

# check registered ip
wget -q -O IP $source/IP.txt
if ! grep -w -q $MYIP IP; then
	echo -e $yellow"Maaf, hanya IP yang terdaftar yang bisa menggunakan script ini"
	if [[ $vps = "iqbalfaf" ]]; then
		echo "Hubungi: Mbah Shondong Daftar IP Free"
	else
		echo -e $white"SMS 082322649802 https://facebook.com/ngamalembahe"
	fi
	rm -f /root/IP
	exit
fi

echo -e $yellow""
echo "------------------- KUNCI AKUN NAKAL ------------------"
echo ""
echo "#######################################################"
echo "#                SCRYPT MBAH SHONDONG                 #"
echo "#            http://www.mbahshondong.com              #"
echo "#-----------------------------------------------------#"
echo "#                     HAWOK JOZZ                      #"
echo "#      https://www.facebook.com/groups/pokoemelu      #"
echo "#-----------------------------------------------------#"
echo "#         [== INTERNET GRATIS SAK MODARRE ==]         #"
echo "#######################################################"
echo -e $White""             

# begin of user-list
echo "-----------------------------------"
echo "USERNAME              EXP DATE     "
echo "-----------------------------------"

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
echo "-----------------------------------"
echo ""
# end of user-list

read -p "Isikan Nama Akun: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo ""
	read -p "Mau Kunci Akun Yang Nakal ? [$username] [y/n]: " -e -i y BANNED
	if [[ "$BANNED" = 'y' ]]; then
		echo " User : $username" >> /root/banneduser.txt
		passwd -l $username
		echo ""
		echo "Akun [$username] Berhasil DiKunci!"
	else
		echo ""
		echo "Kunci akun [$username] Dibatalkan!"
	fi
else
	echo "Akun [$username] Belum Terdaftar!"
	exit 1
fi

cd ~/
rm -f /root/IP
