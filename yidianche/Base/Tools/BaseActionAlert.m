//
//  YDActionAlert.m
//  esee
//
//  Created by 罗文琦 on 2017/7/3.
//  Copyright © 2017年 中北明夷. All rights reserved.
//

#import "BaseActionAlert.h"

@interface BaseActionAlert ()

@end

@implementation BaseActionAlert

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+ (void)show1AlertControllerWithVC:(nullable UIViewController*)VC
                              Title:(nullable NSString *)title
                            message:(nullable NSString *)message
                   actionTitle:(nullable NSString *)actionTitle
                              style:(UIAlertActionStyle)style
                            handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title  message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:actionTitle style:style handler:handler];
    [alert addAction:action];
    [VC presentViewController:alert animated:YES completion:nil];
}


+ (void )show2AlertControllerWithVC:(nullable UIViewController *)VC
                              Title:(nullable NSString *)title
                            message:(nullable NSString *)message
                   actionTitle:(nullable NSString *)title1
                              style:(UIAlertActionStyle)style1
                            handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler1
                   action2Title:(nullable NSString *)title2
                              style:(UIAlertActionStyle)style2
                            handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler2{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title  message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action1 = [UIAlertAction actionWithTitle:title1 style:style1 handler:handler1];
    [alert addAction:action1];
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:title2 style:style2 handler:handler2];
    [alert addAction:action2];
    [VC presentViewController:alert animated:YES completion:nil];
}

@end
