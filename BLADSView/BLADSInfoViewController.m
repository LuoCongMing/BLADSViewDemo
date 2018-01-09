//
//  BLADSInfoViewController.m
//  StartAD
//
//  Created by JMiMac01 on 2018/1/4.
//  Copyright © 2018年 JMiMac01. All rights reserved.
//

#import "BLADSInfoViewController.h"
#import <WebKit/WebKit.h>

// UIScreen width.
#define  JM_ScreenWidth   [UIScreen mainScreen].bounds.size.width

// UIScreen height.
#define  JM_ScreenHeight  [UIScreen mainScreen].bounds.size.height
// iPhone X
#define  JM_iPhoneX (JM_ScreenWidth == 375.f && JM_ScreenHeight == 812.f ? YES : NO)
#define  JM_StatusBarAndNavigationBarHeight  (JM_iPhoneX ? 88.f : 64.f)
@interface BLADSInfoViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView*web;
@property(nonatomic,strong)UIButton*backButton;
@property(nonatomic,strong)UIButton*lastButton;
@property(nonatomic,strong)UIProgressView*progress;
@end

@implementation BLADSInfoViewController

-(void)dealloc{
    [_web removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //
    [self initUI];
}
-(void)initUI{
    _web = [[WKWebView alloc]init];
    _web.frame = self.view.bounds;
    [_web loadRequest:[NSURLRequest requestWithURL:self.url]];
    _web.navigationDelegate = self;
    [self.view addSubview:_web];
    NSMutableArray*items = [[NSMutableArray alloc]init];
    [items addObject:[[UIBarButtonItem alloc]initWithCustomView:self.lastButton]];
    if (_isNeedCloseButton) {
        [items addObject:[[UIBarButtonItem alloc]initWithCustomView:self.backButton]];
    }
    self.navigationItem.leftBarButtonItems = items;
    
    [_web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat progress = [change[@"new"] floatValue];
        [self.progress setProgress:progress animated:YES];
    }
}
#pragma mark WKNavigationDelegate
//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    [self.view addSubview:self.progress];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.progress setHidden:YES];
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.progress setHidden:YES];
}
-(UIButton*)backButton{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 0, 40, 44);
        _backButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_backButton setTitleColor:_closeButtonColor?_closeButtonColor:[[UIColor alloc]initWithRed:81/255.0 green:183/255.0 blue:106/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
         [_backButton setTitle:@"关闭" forState:UIControlStateNormal];
    }
    return _backButton;
}
-(UIButton*)lastButton{
    if (_lastButton == nil) {
        _lastButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        _lastButton.frame = CGRectMake(0, 0, 30, 44);
        _lastButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_lastButton addTarget:self action:@selector(last) forControlEvents:UIControlEventTouchUpInside];
        if (_backImage) {
            [_lastButton setImage:_backImage forState:UIControlStateNormal];
        }
        
    }
    return _lastButton;
}
-(UIProgressView*)progress{
    if (_progress==nil) {
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, JM_StatusBarAndNavigationBarHeight, [UIScreen mainScreen].bounds.size.width, 2)];
        _progress.transform = CGAffineTransformMakeScale(1.0, 2);
        _progress.progressTintColor = [[UIColor alloc]initWithRed:81/255.0 green:183/255.0 blue:106/255.0 alpha:1.0];
    }
    return _progress;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)last{
    if (self.isNeedCloseButton) {
        [_web goBack];
    }else{
         [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
