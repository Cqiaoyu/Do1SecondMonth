//
//  SingleTap.h
//  
//
//  Created by LJ on 15/9/22.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIControl (SingleTapButton)
@property (assign, nonatomic) BOOL isIgnoreEvent;
@property (assign, nonatomic) NSTimeInterval tapInterval;

- (void)SingleTap_sendAction:(SEL) sel to:(id)target forEvent:(UIEvent *)event;
@end
