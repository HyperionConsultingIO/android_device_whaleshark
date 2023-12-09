# Whale Shark - an AOSP14 Automotive Device configuration based on Pixel Tablet (tangorpro)

![GitHub release (latest by date)](https://img.shields.io/github/v/release/alexanderwolz/android_device_whaleshark)
![GitHub](https://img.shields.io/badge/aosp-14-orange)
![GitHub](https://img.shields.io/badge/arch-arm64v8-orange)
![GitHub](https://img.shields.io/github/license/alexanderwolz/android_device_whaleshark)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/alexanderwolz/android_device_whaleshark)
![GitHub all releases](https://img.shields.io/github/downloads/alexanderwolz/android_device_whaleshark/total?color=informational)

## 🧑‍💻 About

This device configuration is intented to be run on a *Google Pixel Tablet (tangorpro)*

See also [aosp_docker](https://github.com/alexanderwolz/aosp_docker) for a Docker-based tool chain and [android_tools](https://github.com/alexanderwolz/android_tools) for additonal sync and flash scripts. 


## 🛠️ Setup

This product is currently being tested against *UP1A.231105.003* (android-14.0.0_r14)

See [Android tags](https://source.android.com/docs/setup/about/build-numbers) for other build ids and branches


### Download AOSP repository

1. ```cd $AOSP_HOME``` (this is a placeholder for your workdir)
2. ```repo init --depth=1 -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r14```
3. ```repo sync -c --no-tags --no-clone-bundle -j$(nproc --all)```


### Add binary drivers
1. Download binaries for *tangorpro* from [here](https://developers.google.com/android/drivers?hl=en) according to branch and build id
2. Extract with ```tar -xvf google_devices-tangorpro-*.tgz```
3. Copy *extract-google_devices-tangorpro.sh* to *$AOSP_HOME*
4. Execute with ```bash extract-google_devices-tangorpro.sh```
6. Drivers will be extracted to ```vendor/google_devices/tangorpro```
7. Clean up with ```rm extract-google_devices-tangorpro.sh```


### Add product configuration

Clone this repository to ```$AOSP_HOME/device/alexanderwolz/whaleshark```

1. ```cd $AOSP_HOME```
2. ```git clone https://github.com/alexanderwolz/android_device_whaleshark.git device/alexanderwolz/whaleshark```


## ⚙️ Build the product

This follows the normal AOSP build approach, e.g.
1. ```cd $AOSP_HOME```
1. ```source build/envsetup.sh```
2. ```lunch whaleshark-userdebug```
3. ```make clobber``` (optionally, cleans target folder)
4. ```m -j$(nproc --all)```
5. ```m -j$(nproc --all) android.hardware.automotive.vehicle@2.0-default-service```
6. See compiled files at ```$ANDROID_PRODUCT_OUT``` (should be ```out/target/product/tangorpro```)

## ✨ Flash the build

Currently, there is an issue with vendor partition, so it needs to be adb synced manually, but these are the steps:

1. Flash device with [official firmware](https://developers.google.com/android/images?hl=en) matching the build id first
2. Disable OEM lock (see settings app)
3. Copy or rsync the ```$ANDROID_PRODUCT_OUT``` folder to localhost, if built remotely
4. Check that ```$ANDROID_PRODUCT_OUT``` is set and export otherwise
5. ```adb reboot bootloader```
6. ```fastboot flashing unlock```
7. ```fastboot flash bootloader $ANDROID_PRODUCT_OUT/bootloader.img``` (could be skipped)
8. ```fastboot reboot bootloader```
9. ```fastboot -w flashall```
10. ```adb root```
11. ```adb remount``` (eventually you need to ```adb shell vdc checkpoint commitChanges```)
12. ```adb synch vendor```
13. ```adb reboot```

Otherwise you can use my script collection [here](https://github.com/alexanderwolz/android_tools) for an automated sync and device flash
