# Permissions for kcuf sdk services
PRODUCT_COPY_FILES += \
    vendor/kcuf/config/permissions/org.kcufos.audio.xml:system/etc/permissions/org.kcufos.audio.xml \
    vendor/kcuf/config/permissions/org.kcufos.livedisplay.xml:system/etc/permissions/org.kcufos.livedisplay.xml \
    vendor/kcuf/config/permissions/org.kcufos.performance.xml:system/etc/permissions/org.kcufos.performance.xml \
    vendor/kcuf/config/permissions/org.kcufos.profiles.xml:system/etc/permissions/org.kcufos.profiles.xml \
    vendor/kcuf/config/permissions/org.kcufos.settings.xml:system/etc/permissions/org.kcufos.settings.xml \
    vendor/kcuf/config/permissions/org.kcufos.style.xml:system/etc/permissions/org.kcufos.style.xml \
    vendor/kcuf/config/permissions/org.kcufos.trust.xml:system/etc/permissions/org.kcufos.trust.xml \
    vendor/kcuf/config/permissions/org.kcufos.weather.xml:system/etc/permissions/org.kcufos.weather.xml

# KCUF Platform Library
PRODUCT_PACKAGES += \
    org.kcufos.platform-res \
    org.kcufos.platform \
    org.kcufos.platform.xml

# KCUF Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.kcufos.hardware \
    org.kcufos.hardware.xml

# JNI Libraries
PRODUCT_PACKAGES += \
    libkcuf-sdk_platform_jni

ifndef KCUF_PLATFORM_SDK_VERSION
  # This is the canonical definition of the SDK version, which defines
  # the set of APIs and functionality available in the platform.  It
  # is a single integer that increases monotonically as updates to
  # the SDK are released.  It should only be incremented when the APIs for
  # the new release are frozen (so that developers don't write apps against
  # intermediate builds).
  KCUF_PLATFORM_SDK_VERSION := 9
endif

ifndef KCUF_PLATFORM_REV
  # For internal SDK revisions that are hotfixed/patched
  # Reset after each KCUF_PLATFORM_SDK_VERSION release
  # If you are doing a release and this is NOT 0, you are almost certainly doing it wrong
  KCUF_PLATFORM_REV := 0
endif
