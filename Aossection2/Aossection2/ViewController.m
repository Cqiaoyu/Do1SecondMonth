//
//  ViewController.m
//  Aossection2
//
//  Created by LJ on 15/9/22.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "SingleTap.h"




@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnTest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.btnTest.timeInterval = 3.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapAction:(id)sender {
    NSLog(@"###1可以操作");
}
- (IBAction)tap2Action:(id)sender {
    NSLog(@"$$$$2可以操作");
}

@end
