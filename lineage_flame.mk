#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

TARGET_FACE_UNLOCK_SUPPORTED := false
PRODUCT_NO_CAMERA := true

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

#
# All components inherited here go to system image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)

# Enable mainline checking
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed

#
# All components inherited here go to system_ext image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

#
# All components inherited here go to product image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

#
# All components inherited here go to vendor image
#
# TODO(b/136525499): move *_vendor.mk into the vendor makefile later
TARGET_SUPPORTS_OMX_SERVICE := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_vendor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_vendor.mk)

include device/google/coral/flame/device.mk

# Device identifier. This must come after all inclusions
PRODUCT_BRAND := google
PRODUCT_DEVICE := flame
PRODUCT_MANUFACTURER := Google
PRODUCT_MODEL := Pixel 4
PRODUCT_NAME := lineage_flame

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="flame-user 13 TP1A.221005.002.B2 9382335 release-keys" \
    BuildFingerprint=google/flame/flame:13/TP1A.221005.002.B2/9382335:user/release-keys \
    DeviceProduct=flame

$(call inherit-product, vendor/google/flame/flame-vendor.mk)

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += %
include device/google/coral/boot_diagnostics/boot_capture.mk

$(call inherit-product, vendor/hecker/floral/motionsense/motionsense.mk)
$(call inherit-product, vendor/hecker/floral/faceid/faceid.mk)

# Use the original signed Camera package tested on Infinity-X Coral.
$(call inherit-product, device/google/coral/camera/camera.mk)
PRODUCT_PACKAGES := $(filter-out Aperture Camera2,$(PRODUCT_PACKAGES))
