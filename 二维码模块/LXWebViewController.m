//
//  LXWebViewController.m
//  二维码模块
//
//  Created by 崇庆旭 on 15/7/16.
//  Copyright © 2015年 崇庆旭. All rights reserved.
//


#import "MJRefresh.h"
#import "LXWebViewController.h"
#import "LXQrcodeScanShowController.h"

@interface LXWebViewController () <UIWebViewDelegate>

@property (nonatomic,strong)  UIActivityIndicatorView *juhua;

@end

@implementation LXWebViewController


- (void)loadView
{
    self.view = [[UIWebView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

        
        
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat juhuaX = 15;
    CGFloat juhuaY = self.view.frame.size.width / 2;
    UIActivityIndicatorView * juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(juhuaX, juhuaY, 30, 30)];
    [self.view addSubview:juhua];
    [juhua startAnimating];
    [self.juhua hidesWhenStopped];
    
    self.juhua = juhua;
    UIWebView *webView = (UIWebView *) self.view;
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView  loadRequest:urlRequest];
    
    webView.delegate = self;
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(dismissWebView)];
    
   
}

- (void)dismissWebView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self.juhua stopAnimating];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
