//
//  CKHWaterMask.m
//  MaskPicture
//
//  Created by LJ on 15/9/17.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "CKHWaterMask.h"

@implementation CKHWaterMask
+ (UIImage *)image:(UIImage *)baseImage waterMask:(UIImage *)maskImage text:(NSString *)text withConfig:(CKHWaterMaskConfig *)config{
    CGSize size = CGSizeZero;
    size = baseImage.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //合成
    CGImageRef imgRef1 = baseImage.CGImage;
    CGImageRef imgRef2 = maskImage.CGImage;
    CGRect canvasRect = CGRectMake(0, 0, size.width, size.height);
    CGRect waterMaskRect = CGRectZero;
    if (CGRectEqualToRect(config.waterMaskRect, CGRectZero) && config == nil) {
        waterMaskRect = CGRectMake(size.width - 100, size.height - 100, 100, 100);
    }else{
        waterMaskRect = config.waterMaskRect;
    }
    CGContextDrawImage(context, canvasRect, imgRef1);
    CGContextDrawImage(context, waterMaskRect, imgRef2);
    
    //打文字
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd mm:hh:ss";
    NSString *strDate = [formatter stringFromDate:date];
    UIFont *font = [UIFont systemFontOfSize:40];
    NSDictionary *att = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil];
    CGPoint point = CGPointMake(0, 0);
    if (text == nil) {
        [strDate drawAtPoint:point withAttributes:att];
    }else{
        [text drawAtPoint:point withAttributes:att];
    }
    
    
    UIImage *waterMaskImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageWriteToSavedPhotosAlbum(waterMaskImage, nil, nil, nil);
    
    return waterMaskImage;
    
}
@end
