//
//  UILabel+extention.h
//  罗文琦语法糖
//
//  Created by 罗文琦 on 2017/6/21.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (category)

-(instancetype)initWithText:(NSString*)text;
-(instancetype)initWithText:(NSString *)text font:(UIFont*)font textColor:(UIColor*)textColor;

+(UILabel*)labelWithText:(NSString*)text;
+(UILabel*)labelWithText:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor;

@end
