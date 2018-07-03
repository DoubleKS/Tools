//
//  PRTabBarvc.m
//  esee
//
//  Created by 罗文琦 on 2017/6/29.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "BaseNavgationVC.h"

@interface BaseTabBarVC ()

@property(nonatomic , strong) NSMutableArray<BaseNavgationVC*> * controllers;

@end

@implementation BaseTabBarVC

-(instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}


#pragma mark - 设置界面
-(void)setupUI{
    //这里使用json的方式,持久化所有的控制器,方便以后的复用
    NSURL* jsonURL = [[NSBundle mainBundle] URLForResource:@"Controllers.json" withExtension:nil];
    NSData* data = [NSData dataWithContentsOfURL:jsonURL];
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self creatViewController:jsonArray];
    self.viewControllers = self.controllers;    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//创建子控制器
-(void)creatViewController:(NSArray*)jsonArray{
    self.controllers = [NSMutableArray arrayWithCapacity:jsonArray.count];
    for (NSInteger i = 0; i< jsonArray.count; i++) {
        Class cls = NSClassFromString(jsonArray[i][@"className"]);
        UIViewController* VC = [[cls alloc]init];
        VC.view.backgroundColor = [UIColor whiteColor];
        //放到导航控制器里面
        BaseNavgationVC* nav = [[BaseNavgationVC alloc]initWithRootViewController:VC];
        [self.controllers addObject:nav];
        //设置文字
        VC.title = jsonArray[i][@"title"];
        //设置不同状态下的图片
        VC.tabBarItem.image = [[UIImage imageNamed:jsonArray[i][@"imageName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        VC.tabBarItem.selectedImage = [[UIImage imageNamed:jsonArray[i][@"selectImageName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}




//是否支持横屏
-(BOOL)shouldAutorotate{
    return NO;
}


@end
