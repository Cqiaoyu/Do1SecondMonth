//
//  SingleTap.h
//  
//
//  Created by LJ on 15/9/22.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SingleTap : NSObject

@end

@interface UIControl (ControlTapButton)
@property (assign, nonatomic) NSTimeInterval timeInterval;
@property (strong, nonatomic) NSDate *lastTapDate;
@end
