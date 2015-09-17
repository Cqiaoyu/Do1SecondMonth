//
//  CKHTakePhoto.m
//  PhotosOCDemo
//
//  Created by LJ on 15/9/15.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "CKHTakePhoto.h"
#import <CoreImage/CoreImage.h>

@interface CKHTakePhoto () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController *_picker;
}

@end

@implementation CKHTakePhoto

+ (instancetype)shareInstance{
    static dispatch_once_t token;
    static CKHTakePhoto *instance = nil;
    dispatch_once(&token, ^{
        if (instance == nil) {
            instance = [[CKHTakePhoto alloc]init];
        }
    });
    return instance;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self takePictureWithCoustomInterface:nil];
}

- (void)takePicture:(void (^)(UIImagePickerController *))imagePicker{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _picker = [[UIImagePickerController alloc]init];
        _picker.delegate = self;
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        _picker.allowsEditing = YES;
        _picker.showsCameraControls = NO;
        
        //遮罩
        NSLog(@"%@",NSStringFromCGRect(_picker.view.frame));
        UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, _picker.view.frame.size.height - 50, _picker.view.frame.size.width, 50)];
        maskView.backgroundColor = [UIColor redColor];
        UIButton *btnTakePicture = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnTakePicture setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btnTakePicture setBackgroundColor:[UIColor whiteColor]];
        [btnTakePicture setTintColor:[UIColor redColor]];
        btnTakePicture.layer.cornerRadius = 10;
        btnTakePicture.layer.borderColor = [UIColor redColor].CGColor;
        btnTakePicture.layer.borderWidth = 1.0;
        [btnTakePicture addTarget:_picker action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
        btnTakePicture.frame = CGRectMake(10, 10, 50, 50);
        _picker.cameraOverlayView = btnTakePicture;
        imagePicker(_picker);
    }else{
        NSLog(@"相机不可用");
    }
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
}

- (void)takePictureWithCoustomInterface:(void (^)(UIViewController *))camerViewController{
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetMedium;
    AVCaptureVideoPreviewLayer *photoLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    photoLayer.frame = CGRectMake(0, 0, 1024, 768);
    [self.view.layer addSublayer:photoLayer];
    
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,[NSNumber numberWithFloat:1.0],AVVideoQualityKey, nil];
    AVCaptureStillImageOutput *output = [[AVCaptureStillImageOutput alloc]init];
    output.outputSettings = settings;
    
    if (error == nil) {
        [session addInput:input];
    }
    [session addOutput:output];
    
    [session startRunning];
}

@end
