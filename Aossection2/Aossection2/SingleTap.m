//
//  SingleTap.m
//  
//
//  Created by LJ on 15/9/22.
//
//

#import "SingleTap.h"
#import <objc/runtime.h>



static const char *lastTapDateKey = "lastTapDate";
static const char *timeIntervalKey = "timeInterval";
static NSDate *lastTapDate;
@implementation UIControl (SingleTapButton)

- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, timeIntervalKey, @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, timeIntervalKey) doubleValue];
}

- (void)setLastTapDate:(NSDate *)lastTapDate{
    objc_setAssociatedObject(self, lastTapDateKey, lastTapDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSDate *)lastTapDate{
    return objc_getAssociatedObject(self, lastTapDateKey);
}

- (void)SingleTap_sendAction:(SEL)sel to:(id)target forEvent:(UIEvent *)event{
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSinceDate:lastTapDate];
    lastTapDate = now;
    NSLog(@"间隔:%f",interval);
    if (self.timeInterval == 0.0) self.timeInterval = 5.0;
    if (interval < self.timeInterval && interval) return;
    [self SingleTap_sendAction:sel to:target forEvent:event];
}
@end

@implementation SingleTap
+ (void)load{
    [super load];
    Method tapAction = class_getInstanceMethod([UIControl class], @selector(sendAction:to:forEvent:));
    Method thenAction = class_getInstanceMethod([UIButton class], @selector(SingleTap_sendAction:to:forEvent:));
    method_exchangeImplementations(tapAction, thenAction);
}

@end

