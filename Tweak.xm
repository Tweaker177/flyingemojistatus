#define PLIST_PATH                                                             \
@"/var/mobile/Library/Preferences/com.i0stweak3r.flyingemojistatus.plist"

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#include <objc/runtime.h>               
/*
@interface UIStatusBarServiceItemView : UIView
@end                            

static bool kWantsAnimated = YES;
*/
static bool kEnabled = YES;
static NSString *kText2;
static bool kWantsNoCrumbs = YES;
static bool kWantsFadeAnim = YES;

/**
static void -(void) fade {
if([!self fade] {
    [UIView animateWithDuration:1.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         fadeView.alpha = (int)fadeAlphaValue;
                     }
                     completion:^(BOOL finished){
                         fadeAlphaValue=!fadeAlphaValue;
                         [self fade];
                     }];
}
}//end if

-(void)fade2 {
[UIView animateWithDuration:1.0f
                      delay:0.0f
                    options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                 animations:^{
                     // your animation code here
                 }
                completion:nil];
}
**/

%hook UIStatusBarForegroundStyleAttributes
 -(void) setCanShowBreadcrumbs:(bool)arg1 {
 if((KWantsNoCrumbs) && (kEnabled)) {
arg1=FALSE;
return %orig(arg1);
}
return %orig;
}
%end

/**
static NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
**/

%hook SBTelephonyManager
-(void)_reallySetOperatorName:(id)arg1 {


if([kText2 isEqualToString:@""] || kText2 == nil || !kEnabled) 
{
      return  %orig;
  }
    
    else if (kEnabled) {
        arg1 = kText2;
       return %orig(arg1);
    }

}
%end
 
%hook UIStatusBarServiceItemView

-(id)_contentsImageFromString:(id)arg1 withWidth:(CGFloat)arg2 letterSpacing:(CGFloat)arg3 {

if([kText2 isEqualToString:@""] || kText2 == nil || !kEnabled) 
{
      return  %orig;
  }
    
    else if(kEnabled) {
        arg1 = kText2;
return %orig;
}
else { return %orig; }
}

-(BOOL)animatesDataChange {
if(kEnabled) {
return 1;
} else {
return %orig; }
}

-(BOOL)_loopNowIfNecessary {
if(kEnabled) { return 1; }
else { return %orig; }
}
%end
/*
-(id)_crossfadeContentsImage {
return %orig;
}
*/
/***

%new
MSHookIvar<NSString *>(UIStatusBarServiceItemView, _serviceString) = kText2;

UIStatusBarServiceItemView *itemView = [[super alloc] initWithFrame:frame];

[UIView animateWithDuration:1
                      delay:0
                    options:UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat
                 animations:^{
                     self.transform = CGAffineTransformMakeScale(1.5, 1.5);
                 }
                 completion:nil];

**/


/****

[UIView animateWithDuration:1
                 animations:^{
                     self.transform = CGAffineTransformMakeScale(1.5, 1.5);
                 }
                 completion:^(BOOL finished) {
                     [UIView animateWithDuration:1
                                      animations:^{
                                          self.transform = CGAffineTransformIdentity;

                                      }];
                 }];
}
else { return; }
}
%end
***************/


static void
loadPrefs() {
    static NSUserDefaults *prefs = [[NSUserDefaults alloc]
                                    initWithSuiteName:@"com.i0stweak3r.flyingemojistatus"];
    
  
kEnabled = [prefs boolForKey:@"enabled"];

kText2 = [prefs stringForKey:@"text2"];

kWantsNoCrumbs =  [prefs boolForKey:@"wantsNoCrumbs"];


/*
kWantsAnimated= [prefs boolForKey:@"wantsAnimated"];
*/
}

%ctor
{
CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.i0stweak3r.flyingemojistatus-prefsreload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
loadPrefs();
}

