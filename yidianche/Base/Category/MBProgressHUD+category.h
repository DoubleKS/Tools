//
//  UIButton+extension.h
//  罗文琦语法糖
//
//  Created by 罗文琦 on 2017/6/21.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (category)

/**
 在showView上显示菊花(系统样式)
 */
+(void) yd_showHUDIndeterminateWithShowView:(UIView *)showView;


/**
 *  信息提示
 *  @param text 提示文字
 *  @param view        HUD展示在哪一个view
 *  @param afterDelay  展示的时间
 */
+ (void)yd_showHUDText:(NSString *)text toView:(UIView *)view andAfterDelay:(float)afterDelay;

/**
 *  自定义view
 *  @param customview 自定义的view
 *  @param textString 提示文字
 *  @param view       HUD展示在哪一个view
 *  @param afterDelay 展示时间
 */
+ (void)yd_showCustomview:(UIView *)customview andTextString:(NSString *)textString toView:(UIView *)view andAfterDelay:(float)afterDelay;


/**
 *  隐藏 HUD
 */
+ (void)yd_dissmissShowView:(UIView *)showView;



/**
 *  显示 LoadingHUD
 */
+ (void)yd_showHUDLoadingImageArrWithShowView:(UIView *)showView;

/**
 显示自定义的菊花,并且底下加一个文字
 */
+ (void)yd_showHUDLoadingImageArrWithShowView:(UIView *)showView text:(NSString*)text;

@end

