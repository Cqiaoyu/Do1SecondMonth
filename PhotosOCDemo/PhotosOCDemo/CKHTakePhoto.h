//
//  CKHTakePhoto.h
//  PhotosOCDemo
//
//  Created by LJ on 15/9/15.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CKHTakePhoto : UIViewController
+ (instancetype) shareInstance;
- (void)takePicture:(void(^)(UIImagePickerController *picker)) imagePicker;
- (void)takePictureWithCoustomInterface:(void (^)(UIViewController *camerController))camerViewController;
@end
