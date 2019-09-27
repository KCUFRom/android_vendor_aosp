# Copyright (C) 2016 The Pure Nexus Project
# Copyright (C) 2016 The JDCTeam
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

KCUF_MOD_VERSION = 10.0

ifndef KCUF_BUILD_TYPE
    KCUF_BUILD_TYPE := UNOFFICIAL
endif

CUSTOM_DATE_YEAR := $(shell date -u +%Y)
CUSTOM_DATE_MONTH := $(shell date -u +%m)
CUSTOM_DATE_DAY := $(shell date -u +%d)
CUSTOM_DATE_HOUR := $(shell date -u +%H)
CUSTOM_DATE_MINUTE := $(shell date -u +%M)
CUSTOM_BUILD_DATE_UTC := $(shell date -d '$(CUSTOM_DATE_YEAR)-$(CUSTOM_DATE_MONTH)-$(CUSTOM_DATE_DAY) $(CUSTOM_DATE_HOUR):$(CUSTOM_DATE_MINUTE) UTC' +%s)
CUSTOM_BUILD_DATE := $(CUSTOM_DATE_YEAR)$(CUSTOM_DATE_MONTH)$(CUSTOM_DATE_DAY)-$(CUSTOM_DATE_HOUR)$(CUSTOM_DATE_MINUTE)

TARGET_PRODUCT_SHORT := $(subst aosp_,,$(CUSTOM_BUILD))

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(KCUF_BUILD_TYPE), OFFICIAL)
    ifneq ($(CURRENT_DEVICE), whyred)
        KCUF_BUILD_TYPE := UNOFFICIAL
        $(error $(CURRENT_DEVICE) is not an Official Device)
    endif
endif

KCUF_VERSION := $(KCUF_MOD_VERSION)-$(CURRENT_DEVICE)-$(KCUF_BUILD_TYPE)-$(CUSTOM_BUILD_DATE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.kcuf.version=$(KCUF_VERSION) \
  ro.kcuf.releasetype=$(KCUF_BUILD_TYPE) \
  ro.mod.version=$(KCUF_MOD_VERSION)

KCUF_DISPLAY_VERSION := KCUFRom-$(KCUF_MOD_VERSION)-$(KCUF_BUILD_TYPE)
ROM_FINGERPRINT := KCUFRom/$(KCUF_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(CUSTOM_BUILD_DATE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.kcuf.display.version=$(KCUF_DISPLAY_VERSION)
  ro.kcuf.fingerprint=$(ROM_FINGERPRINT)
