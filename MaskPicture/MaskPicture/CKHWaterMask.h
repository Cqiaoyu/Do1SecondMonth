//
//  CKHWaterMask.h
//  MaskPicture
//
//  Created by LJ on 15/9/17.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CKHWaterMaskConfig.h"

@interface CKHWaterMask : NSObject
+ (UIImage *)image:(UIImage *)baseImage waterMask:(UIImage *)maskImage text:(NSString *)text withConfig:(CKHWaterMaskConfig *)config;
@end
