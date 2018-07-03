//
//  UIButton+extension.h
//  罗文琦语法糖
//
//  Created by 罗文琦 on 2017/6/21.
//  Copyright © 2017年 罗文琦. All rights reserved.

#import "MBProgressHUD+category.h"


@implementation MBProgressHUD (category)


+ (void)yd_showHUDText:(NSString *)text toView:(UIView *)view andAfterDelay:(float)afterDelay{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.font = YDPFSCLight(11);
    hud.square = NO;
    hud.minShowTime = 0.5;
    [hud hideAnimated:YES afterDelay:afterDelay];
}

+ (void)yd_showCustomview:(UIView *)customview andTextString:(NSString *)textString toView:(UIView *)view andAfterDelay:(float)afterDelay{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    hud.customView = customview;
    hud.square = NO;
    hud.minShowTime = 0.5;
    hud.label.text = textString;
    [hud hideAnimated:YES afterDelay:afterDelay];
}

/**
 *  隐藏 HUD
 */
+ (void)yd_dissmissShowView:(UIView *)showView {
    if (showView == nil) {
        showView = (UIView*)[[[UIApplication sharedApplication]delegate]window];
    }
    [self hideHUDForView:showView animated:YES];
}


/**
 *  显示 HUD
 */
+ (void)yd_showHUDWithImageArr:(NSMutableArray *)imageArr andShowView:(UIView *)showView{
    if (showView == nil) {
        showView  = (UIView *)[[UIApplication sharedApplication].delegate window];
    }
    if (imageArr == nil) {
        [self showHUDAddedTo:showView animated:YES];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
        hud.minShowTime = 0.5;
        [UIApplication sharedApplication].keyWindow.rootViewController.navigationController.navigationBar.userInteractionEnabled = NO;
        hud.mode = MBProgressHUDModeCustomView;
        UIImageView *imaegCustomView = [[UIImageView alloc] init];
        imaegCustomView.animationImages = imageArr;
        [imaegCustomView setAnimationRepeatCount:0];
        [imaegCustomView setAnimationDuration:(imageArr.count + 1) * 0.1];
        [imaegCustomView startAnimating];
        hud.customView = imaegCustomView;
        hud.square = YES;
        hud.label.text = @"加载中...";
    }
}

+ (void)yd_showHUDLoadingImageArrWithShowView:(UIView *)showView{
    [UIApplication sharedApplication].keyWindow.rootViewController.navigationController.navigationBar.userInteractionEnabled = NO;
    NSMutableArray *imageArr = [NSMutableArray arrayWithObjects:
                                [UIImage imageNamed:@"1"],
                                [UIImage imageNamed:@"2"],
                                [UIImage imageNamed:@"3"],
                                [UIImage imageNamed:@"4"],
                                [UIImage imageNamed:@"5"],
                                [UIImage imageNamed:@"6"],
                                nil];
    if (showView == nil) {
        showView  = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    hud.minShowTime = 0.5;
    [UIApplication sharedApplication].keyWindow.rootViewController.navigationController.navigationBar.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *imaegCustomView = [[UIImageView alloc] init];
    imaegCustomView.animationImages = imageArr;
    [imaegCustomView setAnimationRepeatCount:0];
    [imaegCustomView setAnimationDuration:(imageArr.count + 1) * 0.05];
    [imaegCustomView startAnimating];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor =RGBHEX(0x000000);
    hud.customView = imaegCustomView;
    hud.square = YES;
    hud.label.text = @"加载中...";
    hud.label.font = YDPFSCLight(11);
    hud.label.textColor = RGBHEX(0xffffff);
}

+(void)yd_showHUDIndeterminateWithShowView:(UIView *)showView{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;    //显示模式为菊花
    hud.bezelView.color = [UIColor blackColor];   //HUD的底色
    hud.contentColor = [UIColor whiteColor];      //HUD菊花的颜色
    showView.userInteractionEnabled = NO;
}

+(void)yd_showHUDLoadingImageArrWithShowView:(UIView *)showView text:(NSString*)text{
    NSMutableArray *imageArr = [NSMutableArray arrayWithObjects:
                                [UIImage imageNamed:@"1"],
                                [UIImage imageNamed:@"2"],
                                [UIImage imageNamed:@"3"],
                                [UIImage imageNamed:@"4"],
                                [UIImage imageNamed:@"5"],
                                [UIImage imageNamed:@"6"],
                                nil];
    if (showView == nil) {
        showView  = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    hud.minShowTime = 0.5;
    [UIApplication sharedApplication].keyWindow.rootViewController.navigationController.navigationBar.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *imaegCustomView = [[UIImageView alloc] init];
    imaegCustomView.animationImages = imageArr;
    [imaegCustomView setAnimationRepeatCount:0];
    [imaegCustomView setAnimationDuration:(imageArr.count + 1) * 0.05];
    [imaegCustomView startAnimating];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor =RGBHEX(0x000000);
    hud.customView = imaegCustomView;
    hud.square = YES;
    //设置hud的最小尺寸,hud会自动计算最小尺寸,要设置的比最小尺寸有用才行
    //    hud.minSize = CGSizeMake(100, 100);
    //    hud.minSize = CGSizeMake(KScreenWidth, KScreenHeight);
    if (text == nil) {
        text = @"加载中...";
    }else{
        hud.label.text = text;
    }
    hud.label.font = YDPFSCLight(11);
    hud.label.textColor = RGBHEX(0xffffff);
    //    showView.userInteractionEnabled = NO;
    //    if ([showView.nextResponder isKindOfClass:[UIViewController class]]) {
    //        UIViewController* vc  = (UIViewController*)showView.nextResponder;
    //        vc.navigationController.navigationBar.userInteractionEnabled = NO;
    //    }
}

@end


