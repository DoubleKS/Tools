//
//  PreVC.m
//  yidianche
//
//  Created by 罗文琦 on 2018/5/21.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import "PreVC.h"
@interface PreVC ()
@property(nonatomic , strong) NSString * dogName;
@end

@implementation PreVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    kSetBlackNav;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
}


@end
