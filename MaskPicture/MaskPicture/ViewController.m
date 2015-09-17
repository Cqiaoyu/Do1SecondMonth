//
//  ViewController.m
//  MaskPicture
//
//  Created by LJ on 15/9/17.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>

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
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 500, 500)];
    iv.image = [self image:img1 waterMask:img2];
    [self.view addSubview:iv];
}

- (UIImage *)image:(UIImage *)baseImage waterMask:(UIImage *)maskImage{
    
    
    CGSize size = baseImage.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, self.view.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGImageRef imgRef1 = baseImage.CGImage;
    CGImageRef imgRef2 = maskImage.CGImage;
    CGRect rect1 = CGRectMake(0, 0, size.width, size.height);
    CGRect rect2 = CGRectMake(size.width - maskImage.size.width, size.height - maskImage.size.height, maskImage.size.width, maskImage.size.height);
    CGContextDrawImage(context, rect1, imgRef1);
    CGContextDrawImage(context, rect2, imgRef2);
    
    UIImage *waterMaskImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageWriteToSavedPhotosAlbum(waterMaskImage, nil, nil, nil);
    
    return waterMaskImage;
    
}


@end
