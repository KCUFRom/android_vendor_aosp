# Inherit full common KCUF stuff
$(call inherit-product, vendor/kcuf/config/common_full.mk)

PRODUCT_PACKAGES += \
    AppDrawer \
    KCUFCustomizer

DEVICE_PACKAGE_OVERLAYS += vendor/kcuf/overlay/tv
