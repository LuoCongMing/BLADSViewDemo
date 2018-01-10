# BLADSViewDemo
pod 'BLADSView','~>1.0.2'

使用方法：

    UINavigationController*nav = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
    BLADSViewController*ads = [[BLADSViewController alloc]initWithADSUrl:[NSURL URLWithString:@"http://www.baidu.com"] ImageUrl:[NSURL URLWithString:@"http://www.qqjia.com/z/11/tu13234_6.jpg"] RootViewController:nav];
   // ads.isNeedCloseButton = YES;
   // ads.backImage = [UIImage imageNamed:@"navbar_btn_back_green"];
     self.window.rootViewController = ads;
