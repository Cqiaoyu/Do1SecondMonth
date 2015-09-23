//
//  SingleTap.m
//  
//
//  Created by LJ on 15/9/22.
//
//

#import "SingleTap.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


@interface UIButton (SingleTapButton)
@property (assign, nonatomic) NSTimeInterval *interval;

- (void)SingleTap_sendAction:(SEL) sel to:(id)target forEvent:(UIEvent *)event;
@end

@implementation UIButton (SingleTapButton)


- (void)SingleTap_sendAction:(SEL)sel to:(id)target forEvent:(UIEvent *)event{
    NSLog(@"点击!");
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
