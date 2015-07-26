//
//  LXQrcodeScanViewController.m
//  二维码模块
//
//  Created by 崇庆旭 on 15/7/15.
//  Copyright (c) 2015年 崇庆旭. All rights reserved.
//

#import "LXQrcodeScanViewController.h"
#import "ZBarSDK.h"

@interface LXQrcodeScanViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZBarReaderViewDelegate,LXQrcodeScanViewControllerDelegate>

/**
 *  zbar读取的界面
 */
@property (weak,nonatomic) ZBarReaderView *readView;

/**
 *  边框范围
 */
@property (weak,nonatomic) UIView *borderView;

/**
 *  设置的扫描线
 */
@property (weak,nonatomic) UIImageView *scanLine;

/**
 *  定时器（让扫描线动起来,用strong)
 */
@property (strong,nonatomic) CADisplayLink *link;

@end

@implementation LXQrcodeScanViewController

- (CADisplayLink *)link
{
    if (!_link) {
        
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    return _link;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photoClick)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    //添加二维码扫描视图
    [self setUpReadView];
    
    //添加扫描框
    [self setUpBorderView];
    
    self.readView.scanCrop = [self getScanCrop:self.borderView.frame readerViewBounds:self.readView.bounds];
//    NSLog(@"%@",NSStringFromCGRect(self.readView.scanCrop));
    
    // 开始扫描
    [self.readView start];
    
    
    // 添加扫描线(动画)
    [self setupScanline];
    
}

#pragma mark - 设置子控件

- (void)setUpReadView
{
    ZBarReaderView *readerView = [[ZBarReaderView alloc] init];
    readerView.frame = self.view.bounds;
    [self.view addSubview:readerView];
    
    self.readView = readerView;
    
    //设置readerview的代理
    readerView.readerDelegate = self;
}


- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    if (symbols.count > 0) {//代表扫描到结果
        // 扫描到结果，要停止
        [readerView stop];
        
        // 定时器停止
        [self.link invalidate];
        
        
        // 获取结果
        for (ZBarSymbol *sysbol in symbols) {
            NSString *result =  sysbol.data;
            
            // 通知代理
            if ([self.delegate respondsToSelector:@selector(qrcodeScanViewController:scanResult:)]) {
                [self.delegate qrcodeScanViewController:self scanResult:result];
                
                
            }
            
        }
    }
}

- (void)setUpBorderView
{
    UIView *borderView = [[UIView alloc] init];
    CGFloat borderW = self.view.frame.size.width * 0.6;
    CGFloat borderH = borderW;
    CGFloat borderX = (self.view.frame.size.width - borderW) * 0.5;
    CGFloat borderY = 130;
    borderView.frame = CGRectMake(borderX, borderY, borderW, borderH);
    borderView.layer.borderColor = [UIColor orangeColor].CGColor;
    borderView.layer.borderWidth = 2;
    
    [self.view addSubview:borderView];
    
    
    self.borderView = borderView;
}

/**
 *  设置有效扫描区域
 *
 */
- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)rvBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.y / rvBounds.size.height;
    y = 1 - (rect.origin.x + rect.size.width) / rvBounds.size.width;
    width = (rect.origin.y + rect.size.height) / rvBounds.size.height;
    height = 1 - rect.origin.x / rvBounds.size.width;
    
    return CGRectMake(x, y, width, height);
}


- (void)setupScanline
{
    UIImageView *scanLine = [[UIImageView alloc] init];
    scanLine.image = [UIImage imageNamed:@"qrcode_scanline_qrcode"];
//    scanLine.backgroundColor = [UIColor whiteColor];
    CGRect scanLineFrm = self.borderView.bounds;
    scanLineFrm.origin.y = - self.borderView.bounds.size.height;
    
    scanLine.frame = scanLineFrm;
    [self.borderView addSubview:scanLine];
    
    self.borderView.clipsToBounds = YES;
    
    self.scanLine = scanLine;
    
 
    // 开起定时器
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) photoClick
{
    //打开相册
    UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
    
    //设置图片的选择来源
    imagePickerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //设置代理
    imagePickerVc.delegate = self;
    
    //展现
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - LobsterChat -> UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取选中的图片
    UIImage *pickedImage = info[UIImagePickerControllerOriginalImage];
    
    //把二维码图片转换为字符串
    ZBarReaderController *zBarReadVc = [[ZBarReaderController alloc] init];
    
    //返回一个集合
    id result = [zBarReadVc scanImage:pickedImage.CGImage];
    
    for (ZBarSymbol *symbol in result) {
        
        NSLog(@"symbol%@",symbol.data);
    }
    

}

-(void)update{
    //更改扫描线的y
    CGRect scanLineFrm = self.scanLine.frame;
    scanLineFrm.origin.y += 3;
    
   
    
    // 边框高度
    CGFloat borderViewH = CGRectGetHeight(self.borderView.frame);
    if (scanLineFrm.origin.y >= borderViewH) {
        scanLineFrm.origin.y = -borderViewH;
    }
    
    self.scanLine.frame = scanLineFrm;

}

@end
