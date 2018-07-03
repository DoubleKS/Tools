//
//  UIImage+MUCommon.h
//  BigCalculate
//
//  Created by 罗文琦 on 16/10/27.
//  Copyright © 2016年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+category.h"


@interface UIImage (category)

/**颜色转图片*/
+ (UIImage *)imageWithColor:(UIColor *)color;

/**修正图片旋转*/
-(UIImage *)fixOrientation;

/**根据颜色创建渐变图片*/
+ (UIImage *)imageWithGradientStyle:(UIGradientStyle)gradientStyle  gradientSize:(CGSize)size andColors:(NSArray *)colors;


@end
