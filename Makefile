ARCHS = arm64 armv7
TARGET = iphone:clang:11.2:8.0
#CFLAGS = -fobjc-arc
DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FlyingEmojiStatus
FlyingEmojiStatus_FILES = Tweak.xm
FlyingEmojiStatus_CFLAGS = -fobjc-arc
FlyingEmojiStatus_FRAMEWORKS = UIKit Foundation 

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += FlyingEmojiStatus
include $(THEOS_MAKE_PATH)/aggregate.mk
