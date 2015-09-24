//
//  ViewController.m
//  MaskPicture
//
//  Created by LJ on 15/9/17.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "CKHWaterMask.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showAction:(id)sender {
    UIImage *img1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tortiter" ofType:@"jpg"]];
    UIImage *img2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"heart" ofType:@"png"]];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 768, 700)];
    CKHWaterMaskConfig *config = [[CKHWaterMaskConfig alloc]init];
    config.waterMaskRect = CGRectMake(0, 100, 100, 100);
    iv.image = [CKHWaterMask image:img1 waterMask:img2 text:@"呵呵" withConfig:nil];
    iv.image = [self image:img1 waterMask:img2];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:iv];
    
//    [NSThread sleepForTimeInterval:2.0];
//    
//    UIView *v = [self.view snapshotViewAfterScreenUpdates:YES];
//    UIGraphicsBeginImageContextWithOptions(v.bounds.size, YES, 0);
//    [v  drawViewHierarchyInRect:v.bounds afterScreenUpdates:YES];
//    UIImage *ivi = UIGraphicsGetImageFromCurrentImageContext();
//    iv.image = ivi;
}

- (UIImage *)image:(UIImage *)baseImage waterMask:(UIImage *)maskImage{
    CGSize size = baseImage.size;
    NSLog(@"baseImage=%@",NSStringFromCGSize(size));
    CGRect rect1 = CGRectMake(0, 0, size.width, size.height);
    CGRect rect2 = CGRectMake(size.width - 50, 0, 50, 50);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //合成
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGImageRef imgRef1 = baseImage.CGImage;
    CGImageRef imgRef2 = maskImage.CGImage;
    CGContextDrawImage(context, rect1, imgRef1);
    CGContextDrawImage(context, rect2, imgRef2);
    //打文字
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd mm:hh:ss";
    NSString *strDate = [formatter stringFromDate:date];
    UIFont *font = [UIFont systemFontOfSize:40];
    NSDictionary *att = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil];
    CGPoint point = CGPointMake(0, size.height - 40);
    [strDate drawAtPoint:point withAttributes:att];
    
    
    UIImage *waterMaskImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(waterMaskImage, nil, nil, nil);
    
    return waterMaskImage;
    
}


@end
