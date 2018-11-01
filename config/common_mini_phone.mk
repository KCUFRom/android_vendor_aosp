# Inherit mini common KCUF stuff
$(call inherit-product, vendor/kcuf/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/kcuf/config/telephony.mk)
