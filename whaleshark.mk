# Copyright (C) 2023 Alexander Wolz, mail@alexanderwolz.de
# product based on:
#	- device/google_car/tangorpro_car/aosp_tangorpro_car.mk

$(call inherit-product, device/google_car/tangorpro_car/aosp_tangorpro_car.mk)

# see also https://source.android.com/docs/automotive/start/pixelxl?hl=en
# somehow audiocontrol and vehicle service have changed, complains about 'unknown module'

# vehicle service needs to be built with this product, normally this is done by Automotive OEMs
# we want to use the default stubbed service here, so we need to manually build it:
# m -j$(nproc --all) android.hardware.automotive.vehicle@2.0-default-service
# TODO integrate with device tree build

PRODUCT_PACKAGE_OVERLAYS :=  device/alexanderwolz/whaleshark/overlay $(PRODUCT_PACKAGE_OVERLAYS)

PRODUCT_BRAND := alexanderwolz
PRODUCT_NAME := whaleshark
PRODUCT_MODEL := Whale Shark AAOS on Tangorpro

# we reuse the original device configuration from device/google_car/tangorpro
# otherwise it complains about "error: cannot assign to readonly variable: PRODUCT_NAME"
PRODUCT_DEVICE := tangorpro
PRODUCT_MANUFACTURER := Google
