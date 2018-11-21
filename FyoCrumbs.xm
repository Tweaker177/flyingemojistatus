#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.i0stweak3r.fyocrumbs.plist"
 
inline bool GetPrefBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

%hook UIStatusBarForegroundStyleAttributes
 -(void) setCanShowBreadcrumbs:(bool)arg1 {
 if(GetPrefBool(@"key1")) {
arg1=FALSE;
return %orig(arg1);
}
return %orig;
}
%end

