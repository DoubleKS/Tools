//
//  YDActionAlert.h
//  esee
//
//  Created by 罗文琦 on 2017/7/3.
//  Copyright © 2017年 中北明夷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BaseActionAlert : UIAlertController
/**两个选项的弹窗*/
+ (void )show2AlertControllerWithVC:(nullable UIViewController *)VC
                              Title:(nullable NSString *)title
                            message:(nullable NSString *)message
                        actionTitle:(nullable NSString *)title1
                              style:(UIAlertActionStyle)style1
                            handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler1
                       action2Title:(nullable NSString *)title2
                              style:(UIAlertActionStyle)style2
                            handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler2;

/**一个选项的弹窗*/
+ (void)show1AlertControllerWithVC:(nullable UIViewController*)VC
                             Title:(nullable NSString *)title
                           message:(nullable NSString *)message
                       actionTitle:(nullable NSString *)actionTitle
                             style:(UIAlertActionStyle)style
                           handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler;

@end
