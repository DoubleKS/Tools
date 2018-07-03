//
//  BaseNavgationVC.m
//  esee
//
//  Created by 罗文琦 on 2017/6/29.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "BaseNavgationVC.h"

@interface BaseNavgationVC ()<UINavigationControllerDelegate>

@end

@implementation BaseNavgationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIFont* font = [UIFont fontWithName:@"PingFangSC-Light" size:17];
//    NSDictionary *textAttributes = @{
//                                     NSFontAttributeName : font,
//                                     NSForegroundColorAttributeName : RGBHEX(0x2B2B2B)
//                                     };
//    [self.navigationBar setTitleTextAttributes:textAttributes];
//

    

    
    
    
    
    
    
    
    
    
//    self.delegate = self;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////支持旋转
//-(BOOL)shouldAutorotate{
//    return [self.topViewController shouldAutorotate];
//}
//
////支持的方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return [self.topViewController supportedInterfaceOrientations];
//}

//push时候tabbar隐藏
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    self.navigationBar.userInteractionEnabled = NO;
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
