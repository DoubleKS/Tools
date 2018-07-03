//
//  PRNavigationTool.h
//  esee
//
//  Created by 罗文琦 on 2017/8/13.
//  Copyright © 2017年 中北明夷. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  KPRNavigationTool [UINavigationTool shared]
#define  kSetBlackNav      [[UINavigationTool shared]setBlackNavigationBar:self.navigationController.navigationBar]
#define  kSetWhiteNav      [[UINavigationTool shared]setWhiteNaviagtionBar:self.navigationController.navigationBar]
#define  kSetRedNav        [[UINavigationTool shared]setRedNavigationBar:self.navigationController.navigationBar]

@interface UINavigationTool : NSObject

+(instancetype)shared;

-(void)setRedNavigationBar:(UINavigationBar*)navigationBar;

-(void)setBlackNavigationBar:(UINavigationBar*)navigationBar;

-(void)setWhiteNaviagtionBar:(UINavigationBar*)navigationBar;


@end
