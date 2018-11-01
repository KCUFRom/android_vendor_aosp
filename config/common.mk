PRODUCT_BRAND ?= KCUFRom

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/kcuf/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/kcuf/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/kcuf/prebuilt/common/bin/50-kcuf.sh:system/addon.d/50-kcuf.sh \
    vendor/kcuf/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/kcuf/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/kcuf/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/kcuf/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/kcuf/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# KCUF-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/kcuf/config/permissions/kcuf-sysconfig.xml:system/etc/sysconfig/kcuf-sysconfig.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/kcuf/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/kcuf/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/kcuf/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all KCUF-specific init rc files
$(foreach f,$(wildcard vendor/kcuf/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/kcuf/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is KCUF!
PRODUCT_COPY_FILES += \
    vendor/kcuf/config/permissions/org.kcufos.android.xml:system/etc/permissions/org.kcufos.android.xml \
    vendor/kcuf/config/permissions/privapp-permissions-kcuf.xml:system/etc/permissions/privapp-permissions-kcuf.xml

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/kcuf/config/permissions/kcuf-hiddenapi-package-whitelist.xml:system/etc/permissions/kcuf-hiddenapi-package-whitelist.xml

# Include KCUF audio files
include vendor/kcuf/config/kcuf_audio.mk

ifneq ($(TARGET_DISABLE_KCUF_SDK), true)
# KCUF SDK
include vendor/kcuf/config/kcuf_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/kcuf/config/twrp.mk
endif

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Required KCUF packages
PRODUCT_PACKAGES += \
    KCUFParts \
    Development \
    Profiles

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom KCUF packages
PRODUCT_PACKAGES += \
    AudioFX \
    KCUFSettingsProvider \
    KCUFSetupWizard \
    Eleven \
    ExactCalculator \
    Jelly \
    LockClock \
    Trebuchet \
    Updater \
    WallpaperPicker \
    WeatherProvider

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Berry styles
PRODUCT_PACKAGES += \
    KCUFBlackTheme \
    KCUFDarkTheme \
    KCUFBlackAccent \
    KCUFBlueAccent \
    KCUFBrownAccent \
    KCUFCyanAccent \
    KCUFGreenAccent \
    KCUFOrangeAccent \
    KCUFPinkAccent \
    KCUFPurpleAccent \
    KCUFRedAccent \
    KCUFYellowAccent

# Extra tools in KCUF
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_KCUF_CHARGER),true)
PRODUCT_PACKAGES += \
    kcuf_charger_res_images \
    font_log.png \
    libhealthd.kcuf
endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    micro_bench \
    procmem \
    procrank \
    strace

# Conditionally build in su
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/kcuf/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/kcuf/overlay/common

PRODUCT_VERSION_MAJOR = 16
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE := 0

ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    KCUF_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    KCUF_VERSION_MAINTENANCE := 0
endif

# Set KCUF_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef KCUF_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "KCUF_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^KCUF_||g')
        KCUF_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(KCUF_BUILDTYPE)),)
    KCUF_BUILDTYPE :=
endif

ifdef KCUF_BUILDTYPE
    ifneq ($(KCUF_BUILDTYPE), SNAPSHOT)
        ifdef KCUF_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            KCUF_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from KCUF_EXTRAVERSION
            KCUF_EXTRAVERSION := $(shell echo $(KCUF_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to KCUF_EXTRAVERSION
            KCUF_EXTRAVERSION := -$(KCUF_EXTRAVERSION)
        endif
    else
        ifndef KCUF_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            KCUF_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from KCUF_EXTRAVERSION
            KCUF_EXTRAVERSION := $(shell echo $(KCUF_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to KCUF_EXTRAVERSION
            KCUF_EXTRAVERSION := -$(KCUF_EXTRAVERSION)
        endif
    endif
else
    # If KCUF_BUILDTYPE is not defined, set to UNOFFICIAL
    KCUF_BUILDTYPE := UNOFFICIAL
    KCUF_EXTRAVERSION :=
endif

ifeq ($(KCUF_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        KCUF_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(KCUF_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        KCUF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(KCUF_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            ifeq ($(KCUF_VERSION_MAINTENANCE),0)
                KCUF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(KCUF_BUILD)
            else
                KCUF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(KCUF_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(KCUF_BUILD)
            endif
        else
            KCUF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(KCUF_BUILD)
        endif
    endif
else
    ifeq ($(KCUF_VERSION_MAINTENANCE),0)
        ifeq ($(KCUF_VERSION_APPEND_TIME_OF_DAY),true)
            KCUF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d_%H%M%S)-$(KCUF_BUILDTYPE)$(KCUF_EXTRAVERSION)-$(KCUF_BUILD)
        else
            KCUF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(KCUF_BUILDTYPE)$(KCUF_EXTRAVERSION)-$(KCUF_BUILD)
        endif
    else
        ifeq ($(KCUF_VERSION_APPEND_TIME_OF_DAY),true)
            KCUF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(KCUF_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d_%H%M%S)-$(KCUF_BUILDTYPE)$(KCUF_EXTRAVERSION)-$(KCUF_BUILD)
        else
            KCUF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(KCUF_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(KCUF_BUILDTYPE)$(KCUF_EXTRAVERSION)-$(KCUF_BUILD)
        endif
    endif
endif

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/kcuf/build/target/product/security/kcuf

-include vendor/kcuf-priv/keys/keys.mk

KCUF_DISPLAY_VERSION := $(KCUF_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
    ifneq ($(KCUF_BUILDTYPE), UNOFFICIAL)
        ifndef TARGET_VENDOR_RELEASE_BUILD_ID
            ifneq ($(KCUF_EXTRAVERSION),)
                # Remove leading dash from KCUF_EXTRAVERSION
                KCUF_EXTRAVERSION := $(shell echo $(KCUF_EXTRAVERSION) | sed 's/-//')
                TARGET_VENDOR_RELEASE_BUILD_ID := $(KCUF_EXTRAVERSION)
            else
                TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
            endif
        else
            TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
        endif
        ifeq ($(KCUF_VERSION_MAINTENANCE),0)
            KCUF_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(KCUF_BUILD)
        else
            KCUF_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(KCUF_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(KCUF_BUILD)
        endif
    endif
endif
endif

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/kcuf/config/partner_gms.mk

$(call inherit-product-if-exists, vendor/extra/product.mk)
