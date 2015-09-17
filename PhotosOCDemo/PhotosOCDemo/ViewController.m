//
//  ViewController.m
//  PhotosOCDemo
//
//  Created by LJ on 15/9/14.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "CKHTakePhoto.h"

@interface ViewController (){
    NSMutableArray *assets;
}

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (PHAuthorizationStatusAuthorized == status) {
            NSLog(@"已授权");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fetchPhotoAction:(id)sender {
    PHFetchOptions *options = [[PHFetchOptions alloc]init];
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:true];
    options.sortDescriptors = @[sortDesc];
    PHFetchResult *result = [PHAsset fetchAssetsWithOptions:options];
    NSLog(@"####%ld",(unsigned long)result.count);
    
    assets = [NSMutableArray arrayWithObjects:result[result.count-1],result[result.count-2], nil];
    NSLog(@"%d",((PHAsset *)assets[0]).mediaType);
    NSLog(@"%d",((PHAsset *)assets[0]).pixelHeight);
    NSLog(@"%d",((PHAsset *)assets[0]).pixelWidth);
    NSLog(@"%@",((PHAsset *)assets[0]).creationDate);
    NSLog(@"%@",((PHAsset *)assets[0]).modificationDate);
    NSLog(@"%@",((PHAsset *)assets[0]).location);
    
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.networkAccessAllowed = YES;
//    PHImageManager *imageManager = [PHImageManager defaultManager];
    PHCachingImageManager *cacheImage = [[PHCachingImageManager alloc]init];
    [cacheImage requestImageForAsset:assets[0] targetSize:CGSizeMake(((PHAsset *)assets[0]).pixelWidth, ((PHAsset *)assets[0]).pixelHeight) contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
        //
        _showIV.image = result;
    }];
    
}
- (IBAction)delAction:(id)sender {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //删除
        [PHAssetChangeRequest deleteAssets:assets];
    } completionHandler:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"删除成功");
            [self.view setNeedsDisplay];
        }
    }];
}
- (IBAction)takePictureAction:(id)sender {
//    [[CKHTakePhoto shareInstance] takePicture:^(UIImagePickerController *picker) {
//        [self presentViewController:picker animated:YES completion:nil];
//    }];
    CKHTakePhoto *takePicture = [CKHTakePhoto shareInstance];
    [self presentViewController:takePicture animated:YES completion:nil];
}

@end
