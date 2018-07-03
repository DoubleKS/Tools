//
//  PRNavigationTool.m
//  esee
//
//  Created by 罗文琦 on 2017/8/13.
//  Copyright © 2017年 中北明夷. All rights reserved.
//

#import "UINavigationTool.h"

@implementation UINavigationTool

+(instancetype)shared{
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared  = [[UINavigationTool alloc]init];
    });
    return shared;
}

-(void)setRedNavigationBar:(UINavigationBar*)navigationBar{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    navigationBar.translucent = NO;
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = [UIImage new];
    [navigationBar setBarTintColor: RGBHEXA(0XFF4534, 1)];
    [navigationBar setTitleTextAttributes:@{
                                            NSFontAttributeName : [UIFont systemFontOfSize:17],
                                            NSForegroundColorAttributeName :RGBHEXA(0xffffff, 1),
                                            }];
}

-(void)setBlackNavigationBar:(UINavigationBar*)navigationBar{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    navigationBar.translucent = NO;
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = [UIImage new];
    [navigationBar setBarTintColor: RGBHEXA(0x0f0f0f , 1)];
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],
                                            NSForegroundColorAttributeName :RGBHEXA(0xffffff, 1)}];
    

}

-(void)setWhiteNaviagtionBar:(UINavigationBar*)navigationBar{

//    navigationBar.barStyle = UIBarStyleBlack;
//    NSDictionary *textAttributes = @{
//                                     NSFontAttributeName : PRPingFangSCLight(17),
//                                     NSForegroundColorAttributeName :RGBHEXA(0X2B2B2B, 1),
//                                     };
//    navigationBar.titleTextAttributes = textAttributes;
//    navigationBar.barTintColor = RGBHEXA(0xffffff, 1);
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
//    [navigationBar setShadowImage:[UIImage pr_imageWithColor:RGBHEXA(0x000000, 0.05)]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];////白色电池栏
    navigationBar.shadowImage = [UIImage imageWithColor:RGBHEXA(0x000000, 0.05)];
    navigationBar.translucent = NO;
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    navigationBar.shadowImage = [UIImage new];
    [navigationBar setBarTintColor: RGBHEXA(0xffffff, 1)];
    [navigationBar setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName :RGBHEXA(0X2B2B2B, 1)}];

}


@end
