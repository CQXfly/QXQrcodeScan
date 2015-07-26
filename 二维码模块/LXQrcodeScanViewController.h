//
//  LXQrcodeScanViewController.h
//  二维码模块
//
//  Created by 崇庆旭 on 15/7/15.
//  Copyright (c) 2015年 崇庆旭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXQrcodeScanViewController;

@protocol LXQrcodeScanViewControllerDelegate <NSObject>

-(void)qrcodeScanViewController:(LXQrcodeScanViewController *)qrcsVc scanResult:(NSString *)scanResult;

@end

@interface LXQrcodeScanViewController : UIViewController

@property (nonatomic,weak )id <LXQrcodeScanViewControllerDelegate> delegate;

@end
