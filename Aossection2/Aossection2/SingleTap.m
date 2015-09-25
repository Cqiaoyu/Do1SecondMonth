//
//  SingleTap.m
//  
//
//  Created by LJ on 15/9/22.
//
//

#import "SingleTap.h"
#import <objc/runtime.h>


static const char *associatedKey = "singleTap";

@implementation UIControl (SingleTapButton)

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    objc_setAssociatedObject(self, "isIgnoreEvent", @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, "isIgnoreEvent") boolValue];
}

- (NSTimeInterval)tapInterval{
    return [objc_getAssociatedObject(self, associatedKey) doubleValue];
}

- (void)setTapInterval:(NSTimeInterval)tapInterval{
    objc_setAssociatedObject(self, associatedKey, @(tapInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)SingleTap_sendAction:(SEL)sel to:(id)target forEvent:(UIEvent *)event{
    if (self.isIgnoreEvent) return;
    if (self.tapInterval > 0) {
        NSLog(@"######点击!");
        self.isIgnoreEvent = YES;
        [self performSelector:@selector(setIsIgnoreEvent:) withObject:@(NO) afterDelay:self.tapInterval];
    }
    [self SingleTap_sendAction:sel to:target forEvent:event];
}


+ (void)load{
    [super load];
    Method tapAction = class_getInstanceMethod([UIControl class], @selector(sendAction:to:forEvent:));
    Method thenAction = class_getInstanceMethod([UIButton class], @selector(SingleTap_sendAction:to:forEvent:));
    method_exchangeImplementations(tapAction, thenAction);
}
@end
