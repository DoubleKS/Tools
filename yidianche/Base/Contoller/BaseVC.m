//
//  PRBaseVC.m
//  esee
//
//  Created by 罗文琦 on 2017/6/29.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()<UIGestureRecognizerDelegate>

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //隐藏返回按钮文字,不自定义图片的最简单方法
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
//    leftBarButtonItem.tintColor = UIColor.redColor;
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}


-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 关闭控制器
-(void)closeVC{
    NSArray* vcArr = self.navigationController.viewControllers;
    if (vcArr.count > 1 && vcArr[vcArr.count - 1] == self) {
        [self pop];
    }else{
        [self dismiss];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        NSLog(@"-----------------/n发送了内存警告,请注意处理 --%@/n-----------",[self class]);
}

#pragma mark - dealloc
-(void)dealloc
{
    NSLog(@"dealloc -----%@",[self class]);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)addConstraints{
}

-(void)requestData{
}


//是否支持横屏
-(BOOL)shouldAutorotate{
    return NO;
}


@end
