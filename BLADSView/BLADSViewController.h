//
//  BLADSViewController.h
//  StartAD
//
//  Created by JMiMac01 on 2018/1/3.
//  Copyright © 2018年 JMiMac01. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BLADSViewController : UIViewController

///是否显示关闭按钮
@property(nonatomic,assign)BOOL isNeedCloseButton;
///自定义返回图片
@property(nonatomic,strong)UIImage*backImage;
///自定义关闭文字颜色
@property(nonatomic,strong)UIColor*closeButtonColor;
/**
 @param url 广告地址
 @param imageUrl 广告图片地址
 @param rootViewController 根控制器
 */
-(instancetype)initWithADSUrl:(NSURL*)url ImageUrl:(NSURL*)imageUrl RootViewController:(UIViewController*)rootViewController;
@end
