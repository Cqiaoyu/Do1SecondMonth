//
//  SingleTap.h
//  
//
//  Created by LJ on 15/9/22.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SingleTap:NSObject
@end

@interface UIControl (SingleTapButton)
@property (assign, nonatomic) NSTimeInterval timeInterval;

@end