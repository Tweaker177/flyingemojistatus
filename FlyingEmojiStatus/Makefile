ARCHS = arm64 armv7
TARGET= iphone:clang:11.2:8.0
DEBUG = 0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = FlyingEmojiStatus
FlyingEmojiStatus_FILES = FESRootListController.m
FlyingEmojiStatus_INSTALL_PATH = /Library/PreferenceBundles
FlyingEmojiStatus_FRAMEWORKS = UIKit Foundation 
FlyingEmojiStatus_PRIVATE_FRAMEWORKS = Preferences
FlyingEmojiStatus_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FlyingEmojiStatus.plist$(ECHO_END)
