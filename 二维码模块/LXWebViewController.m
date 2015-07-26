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

@property (nonatomic,strong)  UIWebView *webView;
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
    
   __weak UIWebView *webView = (UIWebView *) self.view;
    self.webView = webView;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView  loadRequest:urlRequest];
    
    webView.delegate = self;
    
    __weak UIScrollView *scrollView = webView.scrollView;
    scrollView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
       
        [webView reload];
    }];
    
    [scrollView.header beginRefreshing];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(dismissWebView)];
    
   
}

- (void)dismissWebView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
   [self.webView.scrollView.header endRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
