//
//  YDPersonalVC.m
//  yidianche
//
//  Created by 罗文琦 on 2018/5/19.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import "YDPersonalVC.h"
#import "PreVC.h"

@interface YDPersonalVC ()

@end

@implementation YDPersonalVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    kSetRedNav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.navigationController pushViewController:[PreVC new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
