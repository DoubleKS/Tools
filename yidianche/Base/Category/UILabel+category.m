//
//  UILabel+extention.m
//  罗文琦语法糖
//
//  Created by 罗文琦 on 2017/6/21.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "UILabel+category.h"

@implementation UILabel (category)

-(instancetype)initWithText:(NSString*)text{
    if (self = [super init]) {
        self.text = text;
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = [UIColor lightGrayColor];
    }
    return self;
}

-(instancetype)initWithText:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor{
    if (self = [super init]) {
        self.text = text;
        self.font = font;
        self.textColor = textColor;
    }
    return self;
}


+(UILabel*)labelWithText:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor{
    UILabel* lab = [UILabel new];
    lab.text = text;
    lab.font = font;
    lab.textColor = textColor;
    return lab;
}

+(UILabel*)labelWithText:(NSString*)text{
    UILabel* lab = [UILabel new];
    lab.text = text;
    return lab;
}

@end
