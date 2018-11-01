# Inherit full common KCUF stuff
$(call inherit-product, vendor/kcuf/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include KCUF LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/kcuf/overlay/dictionaries
