# Charger
ifeq ($(WITH_KCUF_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.kcuf
endif

include vendor/kcuf/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/kcuf/config/BoardConfigQcom.mk
endif

include vendor/kcuf/config/BoardConfigSoong.mk
