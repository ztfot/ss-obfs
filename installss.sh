sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt install shadowsocks-libev -y
sudo apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libc-ares-dev libev-dev asciidoc xmlto automake git -y
git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
sudo make install
cd ..
rm -rf /etc/sysctl.conf
chmod +x ss-manager.sh
rm -rf /etc/shadowsocks-libev/config.json
cp config.json /etc/shadowsocks-libev/
cp config.port.json /etc/shadowsocks-libev/
cp sysctl.conf /etc/
cp ss-manager.sh ~
sysctl -p
echo "* soft nofile 512000" >> /etc/security/limits.conf
echo "* hard nofile 1024000" >> /etc/security/limits.conf
echo "ulimit -SHn 1024000" >> /etc/profile
systemctl enable shadowsocks-libev
sudo reboot