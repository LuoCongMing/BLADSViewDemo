//
//  BLADSViewController.m
//  StartAD
//
//  Created by JMiMac01 on 2018/1/3.
//  Copyright © 2018年 JMiMac01. All rights reserved.
//

#import "BLADSViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BLADSInfoViewController.h"

@interface BLADSViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property(nonatomic,strong)UIViewController*rootViewController;
@property(nonatomic,strong)NSURL*adsUrl;
@property(nonatomic,strong)NSURL*adsImageUrl;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation BLADSViewController

-(void)dealloc{
    NSLog(@"dealloc");
}
-(instancetype)initWithADSUrl:(NSURL *)url ImageUrl:(NSURL *)imageUrl RootViewController:(UIViewController *)rootViewController{
    self = [super init];
    self.adsUrl = url;
    self.adsImageUrl = imageUrl;
    self.rootViewController = rootViewController;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [_launchImageView sd_setImageWithURL:self.adsImageUrl placeholderImage:[self getLaunchImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //广告加载出来之后开启倒计时
        [self countDown];
    }];
}

-(void)countDown{
    NSTimer*timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(repeat:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
  
}
-(void)repeat:(NSTimer*)timer{
    static int time = 3;
    time--;
    if (time==0) {
        [timer invalidate];
        [UIApplication sharedApplication].delegate.window.rootViewController = self.rootViewController;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%d 跳过",time];
}
//点击广告图片
- (IBAction)tap:(id)sender {
    if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController*nav = (UINavigationController*)self.rootViewController;
        BLADSInfoViewController*adsInfo = [[BLADSInfoViewController alloc] init];
        adsInfo.url = self.adsUrl;
        adsInfo.backImage = _backImage;
        adsInfo.closeButtonColor = _closeButtonColor;
        adsInfo.isNeedCloseButton = self.isNeedCloseButton;
        [nav pushViewController:adsInfo animated:YES];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [UIApplication sharedApplication].delegate.window.rootViewController = self.rootViewController;
    });
   
}
//点击跳过
- (IBAction)skipAds:(id)sender {
    [UIApplication sharedApplication].delegate.window.rootViewController = self.rootViewController;
}

-(UIImage *)getLaunchImage
{
    UIImage *imageP = [self launchImageWithType:@"Portrait"];
    if(imageP) return imageP;
    UIImage *imageL = [self launchImageWithType:@"Landscape"];
    if(imageL) return imageL;
    NSLog(@"获取LaunchImage失败!请检查是否添加启动图,或者规格是否有误.");
    return nil;
}
-(UIImage *)launchImageWithType:(NSString *)type
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = type;
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if([viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            if([dict[@"UILaunchImageOrientation"] isEqualToString:@"Landscape"])
            {
                imageSize = CGSizeMake(imageSize.height, imageSize.width);
            }
            if(CGSizeEqualToSize(imageSize, viewSize))
            {
                launchImageName = dict[@"UILaunchImageName"];
                UIImage *image = [UIImage imageNamed:launchImageName];
                return image;
            }
        }
    }
    return nil;
}

@end
