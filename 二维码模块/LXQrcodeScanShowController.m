//
//  LXQrcodeScanShowController.m
//  二维码模块
//
//  Created by 崇庆旭 on 15/7/15.
//  Copyright (c) 2015年 崇庆旭. All rights reserved.
//

#import "LXQrcodeScanShowController.h"

#import "LXQrcodeScanViewController.h"
#import "LXWebViewController.h"
#import "ZBarSDK.h"


@interface LXQrcodeScanShowController () <LXQrcodeScanViewControllerDelegate>


/**
 *  相册按钮
 */
@property (weak,nonatomic) UIButton *photoButton;


@end

@implementation LXQrcodeScanShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    LXQrcodeScanViewController *vc = [[LXQrcodeScanViewController alloc] init];
    vc.delegate = self;
    vc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nv animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)qrcodeScanViewController:(LXQrcodeScanShowController *)qrcsVc scanResult:(NSString *)scanResult
{
           // 如果网页的连接，打开网页
//        NSLog(@"scanresult %@",scanResult);
        if ([scanResult hasPrefix:@"http://"]) {
            
            LXWebViewController *webVc = [[LXWebViewController alloc] init];
            webVc.view.backgroundColor = [UIColor whiteColor];
           
            webVc.urlStr = scanResult;
            
            [self.navigationController pushViewController:webVc animated:YES];
    
            
        }
        
        // 让二维码扫描的控制器消失 

    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)dismissWeb
{
     [self dismissViewControllerAnimated:YES completion:nil];
}



@end
