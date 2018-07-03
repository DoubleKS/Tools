//
//  UIColor+category.h
//  yidianche
//
//  Created by 罗文琦 on 2018/7/3.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM (NSUInteger, UIGradientStyle) {
    UIGradientStyleLeftToRight,
    UIGradientStyleTopToBottom,
    UIGradientStyleRadial,//中心渐变
    UIGradientStyleDiagonal,//左上到右下
};

@interface UIColor (category)

@property (nonatomic, strong) UIImage *gradientImage;

+ (UIColor *)colorWithGradientStyle:(UIGradientStyle)gradientStyle withSize:(CGSize)size andColors:(NSArray *)colors;

@end
