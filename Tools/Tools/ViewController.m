//
//  ViewController.m
//  Tools
//
//  Created by lwq on 2018/6/5.
//  Copyright © 2018年 lwq. All rights reserved.
//

#import "ViewController.h"
#import "JJVersionTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JJVersionTool updataVersion];

 

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
