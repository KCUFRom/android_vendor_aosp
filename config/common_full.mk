# Inherit common KCUF stuff
$(call inherit-product, vendor/kcuf/config/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
