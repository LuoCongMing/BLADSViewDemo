//
//  BLADSInfoViewController.h
//  StartAD
//
//  Created by JMiMac01 on 2018/1/4.
//  Copyright © 2018年 JMiMac01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLADSInfoViewController : UIViewController
// 设置为YES多一个关闭按钮、点击返回按钮webGoback
@property(nonatomic,assign)BOOL isNeedCloseButton;
//广告地址
@property(nonatomic,strong)NSURL*url;

//自定义返回图片
@property(nonatomic,strong)UIImage*backImage;
//自定义关闭文字颜色
@property(nonatomic,strong)UIColor*closeButtonColor;

@end
