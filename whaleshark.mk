# Copyright (C) 2023 Alexander Wolz, mail@alexanderwolz.de
# product based on:
#	- device/google_car/tangorpro_car/aosp_tangorpro_car.mk

$(call inherit-product, device/google_car/tangorpro_car/aosp_tangorpro_car.mk)

# see also https://source.android.com/docs/automotive/start/pixelxl?hl=en
# somehow audiocontrol and vehicle service have changed, complains about 'unknown module'

# TODO audiocontrol and vehicle service need to be built with this product

PRODUCT_BRAND := alexanderwolz
PRODUCT_NAME := whaleshark
PRODUCT_DEVICE := whaleshark
PRODUCT_MODEL := Whale Shark AAOS on Tangorpro
