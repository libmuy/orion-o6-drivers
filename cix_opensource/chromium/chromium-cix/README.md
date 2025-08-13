# How to Build
Take Debian chromium 128.0.6613.84 for example:


```bash
mkdir chromium

cd chromium

wget https://launchpad.net/debian/+archive/primary/+sourcefiles/chromium/128.0.6613.84-1~deb12u1/chromium_128.0.6613.84-1~deb12u1.dsc

wget https://launchpad.net/debian/+archive/primary/+sourcefiles/chromium/128.0.6613.84-1~deb12u1/chromium_128.0.6613.84-1~deb12u1.debian.tar.xz

wget https://launchpad.net/debian/+archive/primary/+sourcefiles/chromium/128.0.6613.84-1~deb12u1/chromium_128.0.6613.84.orig.tar.xz

dpkg-source -x chromium_128.0.6613.84-1~deb12u1.dsc

cp -r ../chromium-cix/debian/chromium_128.0.6613.84/patches/ chromium-128.0.6613.84/debian/patches/cix

cd chromium-128.0.6613.84

find "debian/patches/cix" -type f | awk -F'/' '{print $(NF-1)"/"$NF}' | sort >> "debian/patches/series"

sed -i '125i export CHROMIUM_FLAGS="$CHROMIUM_FLAGS --ozone-platform-hint=wayland --use-v4l2-flat-stateful-video-decoder=enable"' debian/scripts/chromium

dpkg-source -b ./

dpkg-buildpackage -nc -uc -us
```
