//
//  LXQrcodeScanShowController.h
//  二维码模块
//
//  Created by 崇庆旭 on 15/7/15.
//  Copyright (c) 2015年 崇庆旭. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void (^urlBlock) (NSString *url) ;
@interface LXQrcodeScanShowController : UIViewController

@property (copy,nonatomic) urlBlock urlBlock;
@end
